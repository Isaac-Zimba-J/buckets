import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'help_article_controller.freezed.dart';
part 'help_article_controller.g.dart';

/// Screen 30 Help article.
@freezed
abstract class HelpArticleState with _$HelpArticleState {
  /// The article and whether feedback has been given.
  const factory HelpArticleState({
    required HelpArticle article,
    @Default(false) bool feedbackGiven,
  }) = _HelpArticleState;
}

/// Screen 30, live; keyed by article id.
@riverpod
class HelpArticleController extends _$HelpArticleController {
  @override
  Future<HelpArticleState> build(String articleId) async {
    final article = (await ref.read(getHelpArticleProvider)(articleId))
        .orThrow();
    return HelpArticleState(article: article);
  }

  /// Records whether the article helped (stored locally).
  Future<void> recordFeedback({required bool helpful}) async {
    final current = state.value;
    if (current == null) return;
    await ref.read(recordArticleFeedbackProvider)(
      current.article.id,
      helpful: helpful,
    );
    state = AsyncData(current.copyWith(feedbackGiven: true));
  }

  /// Opens the notification-access settings.
  Future<void> openNotificationAccess() =>
      ref.read(openNotificationAccessSettingsProvider)();

  /// Opens the battery settings.
  Future<void> openBatterySettings() => ref.read(openBatterySettingsProvider)();
}
