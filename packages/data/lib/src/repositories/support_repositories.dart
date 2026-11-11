import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/repositories/guard.dart';
import 'package:buckets_data/src/support/help_content.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// [HelpContentRepository] over the bundled articles (SCREENS 29–30);
/// feedback is stored locally in `help_feedback` (R-PRIV-1).
final class BundledHelpContentRepository implements HelpContentRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<List<HelpArticle>>> all() async => Ok(helpArticles);

  @override
  Future<Result<HelpArticle?>> get(String id) async {
    for (final article in helpArticles) {
      if (article.id == id) return Ok(article);
    }
    return const Ok(null);
  }

  @override
  Future<Result<void>> recordFeedback(
    String articleId, {
    required bool helpful,
  }) => guard(() async {
    await _db
        .into(_db.helpFeedbacks)
        .insertOnConflictUpdate(
          HelpFeedbacksCompanion.insert(articleId: articleId, helpful: helpful),
        );
    return const Ok(null);
  });
}

/// [StorageManager] over the database (SCREENS 27).
final class DriftStorageManager implements StorageManager {
  /// Creates the manager.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<StorageSummary>> summary() => guard(() async {
    return Ok(
      StorageSummary(
        alertCount: await _count('payment_alerts'),
        receiptCount: await _count('receipts'),
        databaseBytes: await _databaseBytes(),
      ),
    );
  });

  Future<int> _count(String table) async {
    final row = await _db
        .customSelect('SELECT COUNT(*) AS c FROM $table')
        .getSingle();
    return row.read<int>('c');
  }

  Future<int> _databaseBytes() async {
    final pages = (await _db.customSelect('PRAGMA page_count').getSingle())
        .read<int>('page_count');
    final pageSize = (await _db.customSelect('PRAGMA page_size').getSingle())
        .read<int>('page_size');
    return pages * pageSize;
  }
}
