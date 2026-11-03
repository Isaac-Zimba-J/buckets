import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';
import 'package:buckets_domain/src/transactions/entities/merchant_rule.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';
import 'package:buckets_domain/src/transactions/value_objects/merchant_key.dart';
import 'package:equatable/equatable.dart';

/// How to pre-fill the sort sheet for an alert (R-SPEND-3).
final class FilingSuggestion with Equatable {
  /// Creates a suggestion.
  const new({
    required this.category,
    required this.bucketId,
    required this.fileAutomatically,
  });

  /// The category to pre-select.
  final Category? category;

  /// The bucket to pre-select.
  final String? bucketId;

  /// Whether to file without showing the sort sheet.
  final bool fileAutomatically;

  @override
  List<Object?> get props => [category, bucketId, fileAutomatically];
}

/// Merchant rules: "Always file `merchant` as X from Y" (R-SPEND-3).
abstract final class Categorizer {
  /// The merchant key of a message's counterparty, or null if it has none.
  static MerchantKey? merchantKeyOf(ParsedMessage parsed) {
    final counterparty = parsed.counterparty;
    if (counterparty == null) return null;
    return switch (MerchantKey.create(counterparty)) {
      Ok(:final value) => value,
      Err() => null,
    };
  }

  /// A rule filing [counterparty] as [category] from [bucketId].
  static Result<MerchantRule> newRule({
    required String id,
    required String counterparty,
    required Category category,
    required String bucketId,
  }) => switch (MerchantKey.create(counterparty)) {
    Ok(:final value) => Ok(
      MerchantRule(
        id: id,
        merchantKey: value,
        category: category,
        bucketId: bucketId,
      ),
    ),
    Err(:final failure) => Err(failure),
  };

  /// Pre-fill from the matching [rule]. Alerts still show in the sort sheet
  /// unless [autoFile] is on.
  static FilingSuggestion suggest(
    MerchantRule? rule, {
    required bool autoFile,
  }) => FilingSuggestion(
    category: rule?.category,
    bucketId: rule?.bucketId,
    fileAutomatically: rule != null && autoFile,
  );
}
