import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/entities/help_article.dart';

/// Reads the bundled help content and stores local-only article feedback
/// (SCREENS 29–30). No network (R-PRIV-1).
abstract interface class HelpContentRepository {
  /// Every bundled article, in display order.
  Future<Result<List<HelpArticle>>> all();

  /// The article with [id], or `null` if there is none.
  Future<Result<HelpArticle?>> get(String id);

  /// Records whether the user found article [articleId] helpful. Stored on
  /// the device only.
  Future<Result<void>> recordFeedback(
    String articleId, {
    required bool helpful,
  });
}
