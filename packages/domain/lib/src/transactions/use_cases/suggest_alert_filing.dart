import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/policies/categorizer.dart';
import 'package:buckets_domain/src/transactions/ports/merchant_rule_repository.dart';

/// Pre-fills the sort sheet from merchant rules (R-SPEND-3, screen 18).
final class SuggestAlertFiling {
  /// Creates the use case.
  const new(this._rules, this._settings);

  final MerchantRuleRepository _rules;
  final SettingsRepository _settings;

  /// The category and bucket to pre-select for [alert].
  Future<Result<FilingSuggestion>> call(PaymentAlert alert) =>
      attempt(() async {
        final key = Categorizer.merchantKeyOf(alert.parsed);
        final rule = key == null ? null : unwrap(await _rules.findByKey(key));
        return Categorizer.suggest(
          rule,
          autoFile: unwrap(await _settings.get()).autoFile,
        );
      });
}
