import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

/// The part of a split transaction paid from one bucket.
final class TransactionLine with Equatable {
  /// Pays [amount] from [bucketId]; validated by `Transaction.create`.
  const TransactionLine(this.bucketId, this.amount);

  /// The bucket paying this part.
  final String bucketId;

  /// The part's amount.
  final Money amount;

  @override
  List<Object?> get props => [bucketId, amount];
}
