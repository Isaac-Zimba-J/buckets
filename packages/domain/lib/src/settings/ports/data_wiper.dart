import 'package:buckets_core/buckets_core.dart';

/// Wipes everything for "Delete all data" (SCREENS 27, R-PRIV-4).
abstract interface class DataWiper {
  /// Deletes the database, receipt images, settings, the profile and all
  /// scheduled notifications, returning the app to a first-run state.
  Future<Result<void>> wipeEverything();
}
