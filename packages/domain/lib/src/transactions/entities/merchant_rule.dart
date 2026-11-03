import 'package:buckets_domain/src/transactions/value_objects/category.dart';
import 'package:buckets_domain/src/transactions/value_objects/merchant_key.dart';
import 'package:equatable/equatable.dart';

/// "Always file [merchantKey] as [category] from [bucketId]" (R-SPEND-3).
final class MerchantRule with Equatable {
  /// Creates a rule from already-validated parts.
  const new({
    required this.id,
    required this.merchantKey,
    required this.category,
    required this.bucketId,
  });

  /// Unique ID.
  final String id;

  /// The merchant it matches.
  final MerchantKey merchantKey;

  /// The category to file under.
  final Category category;

  /// The bucket to pay from.
  final String bucketId;

  @override
  List<Object?> get props => [id, merchantKey, category, bucketId];
}
