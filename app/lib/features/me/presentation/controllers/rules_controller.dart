import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/combine_latest.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rules_controller.freezed.dart';
part 'rules_controller.g.dart';

/// Screen 28 Auto-filing rules: categories (R-CAT-1/2) and saved merchant
/// rules (R-SPEND-3).
@freezed
abstract class RulesState with _$RulesState {
  /// Categories, merchant rules and bucket names; [errorCode] is the last
  /// change that failed.
  const factory RulesState({
    required List<Category> categories,
    required List<MerchantRule> merchantRules,
    required Map<String, String> bucketNames,
    String? errorCode,
  }) = _RulesState;
}

/// Screen 28, live.
@riverpod
class RulesController extends _$RulesController {
  @override
  Stream<RulesState> build() => combineLatest3(
    ref.watch(watchCategoriesProvider)(),
    ref.watch(watchMerchantRulesProvider)(),
    ref.watch(bucketRepositoryProvider).watchAll(),
    (categories, rules, buckets) => RulesState(
      categories: categories,
      merchantRules: rules,
      bucketNames: {for (final b in buckets) b.id: b.name},
    ),
  );

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

  /// Removes a merchant rule (R-SPEND-3).
  Future<bool> deleteRule(String id) async =>
      await _done(await ref.read(deleteMerchantRuleProvider)(id));
}
