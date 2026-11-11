import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/platform/image_picker_capture.dart';
import 'package:buckets_data/src/repositories/guard.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// [DataWiper] on drift: empties every table, cancels all notifications and
/// deletes receipt images (SCREENS 27, R-PRIV-4). The schema and the
/// append-only ledger triggers are kept, so the app starts fresh at Welcome.
final class DriftDataWiper implements DataWiper {
  /// Creates the wiper. [photos] is optional so tests can skip file I/O.
  new(this._db, this._notifications, {this.photos});

  final BucketsDatabase _db;
  final NotificationScheduler _notifications;

  /// Optional receipt-image store; null in tests.
  final PhotoApi? photos;

  @override
  Future<Result<void>> wipeEverything() => guard(() async {
    // Foreign keys can't be toggled inside a transaction, so turn them off
    // around the wipe to delete in any order.
    await _db.customStatement('PRAGMA foreign_keys = OFF');
    try {
      await _db.transaction(() async {
        await _db.customStatement(
          'DROP TRIGGER IF EXISTS ledger_entries_no_update',
        );
        await _db.customStatement(
          'DROP TRIGGER IF EXISTS ledger_entries_no_delete',
        );
        for (final table in _db.allTables) {
          await _db.delete(table).go();
        }
        for (final statement in BucketsDatabase.appendOnlyLedger) {
          await _db.customStatement(statement);
        }
      });
    } finally {
      await _db.customStatement('PRAGMA foreign_keys = ON');
    }

    // Best-effort: cancel every scheduled notification.
    await _notifications.replaceAll(const []);

    // Delete receipt images.
    final photos = this.photos;
    if (photos != null) {
      final dir = await photos.receiptsDirectory();
      if (dir.existsSync()) {
        for (final entity in dir.listSync()) {
          entity.deleteSync(recursive: true);
        }
      }
    }
    return const Ok(null);
  });
}
