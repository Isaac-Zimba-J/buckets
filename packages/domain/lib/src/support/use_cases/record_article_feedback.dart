import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/ports/help_content_repository.dart';

/// Records whether a help article helped (SCREENS 30). Stored on the device
/// only (R-PRIV-1).
final class RecordArticleFeedback {
  /// Creates the use case.
  const new(this._help);

  final HelpContentRepository _help;

  /// Saves the feedback for article [articleId].
  Future<Result<void>> call(String articleId, {required bool helpful}) =>
      _help.recordFeedback(articleId, helpful: helpful);
}
