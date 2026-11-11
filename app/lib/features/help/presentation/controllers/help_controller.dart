import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'help_controller.freezed.dart';
part 'help_controller.g.dart';

/// Screen 29 Help: the article list and local search (R-PRIV-1). Empty
/// [results] with a non-empty [query] is the no-results state.
@freezed
abstract class HelpState with _$HelpState {
  /// The articles shown and the current query.
  const factory HelpState({
    required List<HelpArticle> results,
    @Default('') String query,
  }) = _HelpState;
}

/// Screen 29 Help, live.
@riverpod
class HelpController extends _$HelpController {
  @override
  Future<HelpState> build() async {
    final all = (await ref.read(listHelpArticlesProvider)()).orThrow();
    return HelpState(results: all);
  }

  /// Filters the articles by [query]; blank shows them all.
  Future<void> search(String query) async {
    final results = await ref.read(searchHelpProvider)(query);
    switch (results) {
      case Ok(:final value):
        state = AsyncData(HelpState(results: value, query: query));
      case Err():
        break;
    }
  }
}
