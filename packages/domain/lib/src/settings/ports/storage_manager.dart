import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/value_objects/storage_summary.dart';

/// Reports on-device storage use for Data & privacy (SCREENS 27).
abstract interface class StorageManager {
  /// The current storage summary.
  Future<Result<StorageSummary>> summary();
}
