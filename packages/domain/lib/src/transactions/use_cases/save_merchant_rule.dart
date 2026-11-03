import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/merchant_rule.dart';
import 'package:buckets_domain/src/transactions/policies/categorizer.dart';
import 'package:buckets_domain/src/transactions/ports/merchant_rule_repository.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// "Always file this merchant as X from Y" (R-SPEND-3, screen 18).
final class SaveMerchantRule {
  /// Creates the use case.
  const new(this._rules, this._ids);

  final MerchantRuleRepository _rules;
  final IdGenerator _ids;

  /// The saved rule; replaces any rule for the same merchant.
  Future<Result<MerchantRule>> call({
    required String counterparty,
    required Category category,
    required String bucketId,
  }) => attempt(() async {
    final rule = unwrap(
      Categorizer.newRule(
        id: _ids.newId(),
        counterparty: counterparty,
        category: category,
        bucketId: bucketId,
      ),
    );
    unwrap(await _rules.save(rule));
    return rule;
  });
}
