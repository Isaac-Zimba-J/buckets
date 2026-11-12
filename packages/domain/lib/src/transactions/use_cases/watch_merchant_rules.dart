import 'package:buckets_domain/src/transactions/entities/merchant_rule.dart';
import 'package:buckets_domain/src/transactions/ports/merchant_rule_repository.dart';

/// Streams the saved merchant rules for the auto-filing screen (SCREENS 28).
final class WatchMerchantRules {
  /// Creates the use case.
  const new(this._rules);

  final MerchantRuleRepository _rules;

  /// Emits the rules and again on change.
  Stream<List<MerchantRule>> call() => _rules.watchAll();
}
