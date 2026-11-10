import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/ports/app_info_reader.dart';
import 'package:buckets_domain/src/support/value_objects/app_info.dart';

/// Reads the app and device facts for About (SCREENS 32).
final class GetAppInfo {
  /// Creates the use case.
  const new(this._appInfo);

  final AppInfoReader _appInfo;

  /// The current app info.
  Future<Result<AppInfo>> call() => _appInfo.read();
}
