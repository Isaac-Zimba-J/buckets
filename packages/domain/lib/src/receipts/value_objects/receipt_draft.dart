import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/confidence.dart';
import 'package:equatable/equatable.dart';

/// A value read by OCR with how sure the reader is (R-RECEIPT-1).
final class Scored<T> with Equatable {
  /// Throws a [RangeError] unless [confidence] is from 0 to 1.
  new(this.value, this.confidence) {
    checkConfidence(confidence);
  }

  /// The value read.
  final T value;

  /// How sure the reader is, from 0 to 1.
  final double confidence;

  @override
  List<Object?> get props => [value, confidence];
}

/// One line item on a receipt.
final class ReceiptItem with Equatable {
  /// Throws a [RangeError] unless [confidence] is from 0 to 1.
  new(this.name, this.amount, this.confidence) {
    checkConfidence(confidence);
  }

  /// The item as printed.
  final String name;

  /// Its price.
  final Money amount;

  /// How sure the reader is, from 0 to 1.
  final double confidence;

  @override
  List<Object?> get props => [name, amount, confidence];
}

/// What OCR read from a receipt, before the user reviews it (DOMAIN §10).
final class ReceiptDraft with Equatable {
  /// Creates a draft; every field may be missing.
  new({
    this.merchant,
    this.date,
    this.total,
    List<ReceiptItem> items = const [],
  }) : items = List.unmodifiable(items);

  /// The merchant name.
  final Scored<String>? merchant;

  /// The receipt date, in UTC.
  final Scored<DateTime>? date;

  /// The printed total.
  final Scored<Money>? total;

  /// Line items in printed order.
  final List<ReceiptItem> items;

  @override
  List<Object?> get props => [merchant, date, total, items];
}
