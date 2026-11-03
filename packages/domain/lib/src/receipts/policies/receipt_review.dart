import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/receipts/value_objects/receipt_draft.dart';
import 'package:equatable/equatable.dart';

/// What the receipt review screen should flag (R-RECEIPT-2).
final class ReceiptReview with Equatable {
  const new _({
    required this.totalNeedsCheck,
    required this.itemsMatchTotal,
    required this.itemsTotal,
    required this.difference,
  });

  /// Reviews [draft]: the total needs checking when it is missing, its
  /// confidence is below [minTotalConfidence], or the items differ from it
  /// by more than [tolerance].
  factory of(ReceiptDraft draft) {
    final itemsTotal = draft.items.fold(Money.zero, (s, i) => s + i.amount);
    final total = draft.total;
    if (total == null) {
      return ReceiptReview._(
        totalNeedsCheck: true,
        itemsMatchTotal: false,
        itemsTotal: itemsTotal,
        difference: null,
      );
    }
    final hasItems = draft.items.isNotEmpty;
    final difference = itemsTotal - total.value;
    return ReceiptReview._(
      totalNeedsCheck:
          total.confidence < minTotalConfidence ||
          (hasItems && difference.abs() > tolerance),
      itemsMatchTotal: hasItems && difference.isZero,
      itemsTotal: itemsTotal,
      difference: difference,
    );
  }

  /// Totals read with less confidence than this need checking.
  static const minTotalConfidence = 0.8;

  /// The largest allowed gap between the items and the total.
  static const tolerance = Money(100);

  /// Show the "please check" warning on the total.
  final bool totalNeedsCheck;

  /// Show "items add up to the total".
  final bool itemsMatchTotal;

  /// The sum of the line items.
  final Money itemsTotal;

  /// Items total minus the printed total; null without a total.
  final Money? difference;

  @override
  List<Object?> get props => [
    totalNeedsCheck,
    itemsMatchTotal,
    itemsTotal,
    difference,
  ];
}
