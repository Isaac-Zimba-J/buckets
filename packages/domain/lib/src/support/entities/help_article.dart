import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// A bundled help article (SCREENS 29–30). Content ships with the app as
/// Markdown; nothing is fetched over the network (R-PRIV-1).
final class HelpArticle with Equatable {
  const new _({
    required this.id,
    required this.title,
    required this.body,
    required this.keywords,
  });

  /// Validates and creates an article. [keywords] help local search
  /// (`SearchHelp`); they are lower-cased and blanks are dropped.
  static Result<HelpArticle> create({
    required String id,
    required String title,
    required String body,
    List<String> keywords = const [],
  }) => validated(
    [
      requireText(id, 'id'),
      requireText(title, 'title'),
      requireText(body, 'body'),
    ],
    () => HelpArticle._(
      id: id.trim(),
      title: title.trim(),
      body: body.trim(),
      keywords: [
        for (final k in keywords)
          if (k.trim().isNotEmpty) k.trim().toLowerCase(),
      ],
    ),
  );

  /// Stable identifier, used in the route `/help/:articleId`.
  final String id;

  /// Heading shown in the list and at the top of the article.
  final String title;

  /// Markdown body.
  final String body;

  /// Search terms, lower-cased.
  final List<String> keywords;

  /// Whether [query] matches the title, body or a keyword (case-insensitive).
  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return false;
    return title.toLowerCase().contains(q) ||
        body.toLowerCase().contains(q) ||
        keywords.any((k) => k.contains(q));
  }

  @override
  List<Object?> get props => [id, title, body, keywords];
}
