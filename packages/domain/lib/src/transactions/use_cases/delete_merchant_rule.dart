import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/transactions/ports/merchant_rule_repository.dart';

/// Removes a merchant rule so its payments are sorted by hand again
/// (SCREENS 28, R-SPEND-3).
final class DeleteMerchantRule {
  /// Creates the use case.
  const new(this._rules);

  final MerchantRuleRepository _rules;

  /// Deletes the rule with [id].
  Future<Result<void>> call(String id) => _rules.delete(id);
}
