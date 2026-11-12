import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/transactions/entities/merchant_rule.dart';
import 'package:buckets_domain/src/transactions/value_objects/merchant_key.dart';

/// Stores merchant rules (R-SPEND-3).
abstract interface class MerchantRuleRepository {
  /// The rule for [key], if any.
  Future<Result<MerchantRule?>> findByKey(MerchantKey key);

  /// Every saved rule.
  Future<Result<List<MerchantRule>>> getAll();

  /// The rules, emitting again on change (SCREENS 28).
  Stream<List<MerchantRule>> watchAll();

  /// Inserts or replaces [rule]; one rule per merchant key.
  Future<Result<void>> save(MerchantRule rule);

  /// Removes the rule with [id] (SCREENS 28).
  Future<Result<void>> delete(String id);
}
