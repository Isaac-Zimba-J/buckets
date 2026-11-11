import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rules_controller.freezed.dart';
part 'rules_controller.g.dart';

/// Screen 28 Auto-filing rules: the category list (R-CAT-1/2). Merchant-rule
/// editing follows when the repository gains watch/delete.
@freezed
abstract class RulesState with _$RulesState {
  /// Active and archived categories; [errorCode] is the last change failed.
  const factory RulesState({
    required List<Category> categories,
    String? errorCode,
  }) = _RulesState;
}

/// Screen 28, live.
@riverpod
class RulesController extends _$RulesController {
  @override
  Stream<RulesState> build() => ref
      .watch(watchCategoriesProvider)()
      .map((categories) => RulesState(categories: categories));

  Future<bool> _done(Result<Object?> result) async {
    final current = state.value;
    if (current != null) {
      state = AsyncData(
        current.copyWith(
          errorCode: switch (result) {
            Err(:final failure) => failure.code,
            Ok() => null,
          },
        ),
      );
    }
    return result is Ok;
  }

  /// Adds a custom category (R-CAT-2).
  Future<bool> add(String name) async =>
      await _done(await ref.read(addCategoryProvider)(name));

  /// Renames a category (R-CAT-1).
  Future<bool> rename({required String from, required String to}) async =>
      await _done(await ref.read(renameCategoryProvider)(from: from, to: to));

  /// Archives or restores a category (R-CAT-1).
  Future<bool> setArchived(String name, {required bool archived}) async =>
      await _done(
        await ref.read(archiveCategoryProvider)(name, archived: archived),
      );
}
