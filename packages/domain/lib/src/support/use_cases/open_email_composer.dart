import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/policies/problem_report_builder.dart';
import 'package:buckets_domain/src/support/ports/email_composer.dart';
import 'package:buckets_domain/src/support/value_objects/problem_report.dart';

/// Opens the email app with a problem report (SCREENS 31, R-SUPPORT-1). The
/// support address comes from app config, passed as `to`.
final class OpenEmailComposer {
  /// Creates the use case.
  const new(this._email);

  final EmailComposer _email;

  /// Opens a draft of [report] to [to]; `email.noApp` when there is no email
  /// app.
  Future<Result<void>> call(ProblemReport report, {required String to}) =>
      _email.compose(
        to: to,
        subject: ProblemReportBuilder.subject,
        body: ProblemReportBuilder.body(report),
      );
}
