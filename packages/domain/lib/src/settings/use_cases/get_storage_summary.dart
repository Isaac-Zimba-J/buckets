import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/ports/storage_manager.dart';
import 'package:buckets_domain/src/settings/value_objects/storage_summary.dart';

/// Reads the on-device storage summary for Data & privacy (SCREENS 27).
final class GetStorageSummary {
  /// Creates the use case.
  const new(this._storage);

  final StorageManager _storage;

  /// The current storage summary.
  Future<Result<StorageSummary>> call() => _storage.summary();
}
