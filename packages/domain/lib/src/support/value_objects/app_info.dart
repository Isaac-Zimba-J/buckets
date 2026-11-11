import 'package:equatable/equatable.dart';

/// The only device facts a problem report may carry (R-SUPPORT-2). By
/// holding just these four, it cannot leak balances, messages, names or
/// account numbers.
final class AppInfo with Equatable {
  /// Creates the device facts attached to a problem report.
  const new({
    required this.appVersion,
    required this.buildNumber,
    required this.androidVersion,
    required this.deviceModel,
  });

  /// App version name, e.g. `1.0.0`.
  final String appVersion;

  /// App build number, e.g. `42`.
  final String buildNumber;

  /// Android release, e.g. `14`.
  final String androidVersion;

  /// Device model, e.g. `Tecno Spark 10`.
  final String deviceModel;

  @override
  List<Object?> get props => [
    appVersion,
    buildNumber,
    androidVersion,
    deviceModel,
  ];
}
