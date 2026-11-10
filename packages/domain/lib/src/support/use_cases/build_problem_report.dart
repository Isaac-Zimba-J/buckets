import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/ports/app_info_reader.dart';
import 'package:buckets_domain/src/support/value_objects/app_info.dart';
import 'package:buckets_domain/src/support/value_objects/problem_report.dart';

/// Builds a problem report (SCREENS 31, R-SUPPORT-1/2). App info is read and
/// attached only when the user opts in; it is the four whitelisted facts.
final class BuildProblemReport {
  /// Creates the use case.
  const new(this._appInfo);

  final AppInfoReader _appInfo;

  /// Validates the text and attaches app info when [includeAppInfo] is set.
  Future<Result<ProblemReport>> call({
    required ProblemCategory category,
    required String text,
    bool includeAppInfo = false,
  }) async {
    AppInfo? info;
    if (includeAppInfo) {
      switch (await _appInfo.read()) {
        case Ok(:final value):
          info = value;
        case Err(:final failure):
          return Err(failure);
      }
    }
    return ProblemReport.create(category: category, text: text, appInfo: info);
  }
}
