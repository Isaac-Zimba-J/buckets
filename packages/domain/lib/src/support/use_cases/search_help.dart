import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/support/entities/help_article.dart';
import 'package:buckets_domain/src/support/ports/help_content_repository.dart';

/// Searches the bundled help articles locally (SCREENS 29). No network
/// (R-PRIV-1). A blank query returns every article.
final class SearchHelp {
  /// Creates the use case.
  const new(this._help);

  final HelpContentRepository _help;

  /// Articles matching [query] by title, body or keyword.
  Future<Result<List<HelpArticle>>> call(String query) => attempt(() async {
    final all = unwrap(await _help.all());
    final q = query.trim();
    if (q.isEmpty) return all;
    return [
      for (final article in all)
        if (article.matches(q)) article,
    ];
  });
}
