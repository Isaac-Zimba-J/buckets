import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'receipt_review_controller.freezed.dart';
part 'receipt_review_controller.g.dart';

/// A line item on the review screen (screen 21).
@freezed
abstract class ReceiptItemVm with _$ReceiptItemVm {
  /// Creates the row.
  const factory ReceiptItemVm({required String name, required Money amount}) =
      _ReceiptItemVm;
}

/// Screen 21 Receipt review.
@freezed
abstract class ReceiptReviewState with _$ReceiptReviewState {
  /// [totalNeedsCheck] shows the warning card; [itemsOff] the "items don't
  /// add up" caption; [itemsMatch] the "items add up" helper (R-RECEIPT-2).
  const factory ReceiptReviewState({
    required String receiptId,
    required String imagePath,
    required String? merchant,
    required Money? total,
    required List<ReceiptItemVm> items,
    required bool totalNeedsCheck,
    required bool itemsMatch,
    required Money? itemsOff,
    @Default(false) bool saving,
    @Default(false) bool saved,
    String? errorCode,
  }) = _ReceiptReviewState;
}

/// Screen 21 for [receiptId].
@riverpod
class ReceiptReviewController extends _$ReceiptReviewController {
  @override
  Future<ReceiptReviewState> build(String receiptId) async {
    final stored = (await ref.watch(receiptRepositoryProvider).get(receiptId))
        .orThrow();
    return _state(stored);
  }

  ReceiptReviewState _state(StoredReceipt r) {
    final review = ReceiptReview.of(r.draft);
    final off = review.difference;
    return ReceiptReviewState(
      receiptId: r.id,
      imagePath: r.imagePath,
      merchant: r.draft.merchant?.value,
      total: r.draft.total?.value,
      items: [
        for (final i in r.draft.items)
          ReceiptItemVm(name: i.name, amount: i.amount),
      ],
      totalNeedsCheck: review.totalNeedsCheck,
      itemsMatch: review.itemsMatchTotal,
      itemsOff: off == null || off.isZero || r.draft.items.isEmpty ? null : off,
    );
  }

  /// The user corrects the total; a confirmed total is fully trusted.
  Future<void> setTotal(Money total) async {
    final current = await future;
    final stored = (await ref.read(receiptRepositoryProvider).get(receiptId))
        .orThrow();
    final updated = (await ref.read(updateReceiptDraftProvider)(
      receiptId,
      ReceiptDraft(
        merchant: stored.draft.merchant,
        date: stored.draft.date,
        total: Scored(total, 1),
        items: stored.draft.items,
      ),
    )).orThrow();
    state = AsyncData(_state(updated).copyWith(errorCode: current.errorCode));
  }

  /// Saves the receipt, split across buckets by [lines] (R-SPEND-1).
  Future<bool> save({
    required Category category,
    required String bucketId,
    List<TransactionLine> lines = const [],
  }) async {
    final current = await future;
    final total = current.total;
    if (total == null) {
      state = AsyncData(current.copyWith(errorCode: 'total.missing'));
      return false;
    }
    state = AsyncData(current.copyWith(saving: true, errorCode: null));
    final result = await ref.read(saveReceiptProvider)(
      receiptId: receiptId,
      total: total,
      category: category,
      bucketId: bucketId,
      lines: lines,
    );
    state = AsyncData(switch (result) {
      Ok() => current.copyWith(saved: true),
      Err(:final failure) => current.copyWith(errorCode: failure.code),
    });
    return result is Ok;
  }
}
