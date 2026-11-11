import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:buckets_domain/src/support/value_objects/app_info.dart';
import 'package:equatable/equatable.dart';

/// What kind of report this is (SCREENS 31). Display labels come from the
/// app's strings, not here.
enum ProblemCategory {
  /// Something is broken.
  somethingWrong,

  /// An idea or suggestion.
  idea,

  /// A question.
  question,

  /// Anything else.
  other,
}

/// A problem report the user composes to send to support by email
/// (R-SUPPORT-1). [appInfo] is attached only if the user opted in.
final class ProblemReport with Equatable {
  const new _({
    required this.category,
    required this.text,
    required this.appInfo,
  });

  /// Validates and creates a report; [text] must not be blank.
  static Result<ProblemReport> create({
    required ProblemCategory category,
    required String text,
    AppInfo? appInfo,
  }) => validated(
    [requireText(text, 'text')],
    () => ProblemReport._(
      category: category,
      text: text.trim(),
      appInfo: appInfo,
    ),
  );

  /// What kind of report this is.
  final ProblemCategory category;

  /// The user's words.
  final String text;

  /// Device facts, when the user chose to attach them (R-SUPPORT-2).
  final AppInfo? appInfo;

  @override
  List<Object?> get props => [category, text, appInfo];
}
