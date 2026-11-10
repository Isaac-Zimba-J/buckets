import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/support/entities/help_article.dart';
import 'package:buckets_domain/src/support/ports/help_content_repository.dart';

/// Reads one help article (SCREENS 30).
final class GetHelpArticle {
  /// Creates the use case.
  const new(this._help);

  final HelpContentRepository _help;

  /// The article with [id]; `help.notFound` when there is none.
  Future<Result<HelpArticle>> call(String id) => attempt(() async {
    final article = unwrap(await _help.get(id));
    if (article == null) {
      unwrap<void>(
        const Err(NotFoundFailure('help.notFound', 'That help topic is gone.')),
      );
    }
    return article!;
  });
}
