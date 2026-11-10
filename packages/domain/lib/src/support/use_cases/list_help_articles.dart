import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/entities/help_article.dart';
import 'package:buckets_domain/src/support/ports/help_content_repository.dart';

/// Lists the bundled help articles (SCREENS 29).
final class ListHelpArticles {
  /// Creates the use case.
  const new(this._help);

  final HelpContentRepository _help;

  /// Every article, in display order.
  Future<Result<List<HelpArticle>>> call() => _help.all();
}
