import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/value_objects/app_info.dart';

/// Reads the whitelisted app and device facts for About (SCREENS 32) and
/// problem reports (R-SUPPORT-2). It never exposes anything beyond
/// [AppInfo]'s four fields.
abstract interface class AppInfoReader {
  /// The current app version, build, Android version and device model.
  Future<Result<AppInfo>> read();
}
