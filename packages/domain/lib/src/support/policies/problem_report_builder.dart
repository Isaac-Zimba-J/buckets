import 'package:buckets_domain/src/support/value_objects/problem_report.dart';

/// Turns a [ProblemReport] into the subject and body for the email app
/// (R-SUPPORT-1). The body carries the user's words and, only when it was
/// attached, the whitelisted app info (R-SUPPORT-2) — never balances,
/// messages, names or account numbers.
abstract final class ProblemReportBuilder {
  /// The email subject.
  static const subject = 'Buckets — problem report';

  /// The email body.
  static String body(ProblemReport report) {
    final buffer = StringBuffer(report.text.trim());
    final info = report.appInfo;
    if (info != null) {
      buffer
        ..write('\n\n---\n')
        ..write('App version: ${info.appVersion} (${info.buildNumber})\n')
        ..write('Android: ${info.androidVersion}\n')
        ..write('Device: ${info.deviceModel}');
    }
    return buffer.toString();
  }
}
