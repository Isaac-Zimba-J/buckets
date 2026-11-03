import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_payment_controller.freezed.dart';
part 'log_payment_controller.g.dart';

/// The two ways to log on screen 19.
enum LogTab {
  /// Cash payment.
  cash,

  /// Pasted payment message.
  paste,
}

/// Screen 19 Log a payment.
@freezed
abstract class LogPaymentState with _$LogPaymentState {
  /// [parsedAmount] etc. come from the pasted text; [suggestWish] shows the
  /// "add it as a wish instead?" banner (R-PLAN-1); [saved] pops with a
  /// toast.
  const factory LogPaymentState({
    @Default(LogTab.cash) LogTab tab,
    Money? parsedAmount,
    String? parsedCounterparty,
    @Default(false) bool suggestWish,
    @Default(false) bool saving,
    @Default(false) bool saved,
    String? errorCode,
  }) = _LogPaymentState;
}

/// Screen 19 Log a payment.
@riverpod
class LogPaymentController extends _$LogPaymentController {
  ParsedMessage _parsed = ParsedMessage.unparsed;

  @override
  LogPaymentState build() => const LogPaymentState();

  /// Switches between cash and paste.
  void setTab(LogTab tab) => state = state.copyWith(tab: tab, errorCode: null);

  /// Reads a pasted message (never fails, R-PARSE-2).
  void paste(String text) {
    _parsed = ref.read(parsePastedMessageProvider)(text);
    state = state.copyWith(
      parsedAmount: _parsed.amount,
      parsedCounterparty: _parsed.counterparty,
    );
  }

  /// Shows or hides the wish suggestion for [amount].
  Future<void> amountChanged(Money amount) async {
    final r = await ref.read(suggestWishProvider)(amount: amount);
    state = state.copyWith(suggestWish: r is Ok<bool> && r.value);
  }

  /// Logs the payment on the current tab.
  Future<bool> save({
    required Category category,
    required String bucketId,
    Money? amount,
    String? note,
  }) async {
    state = state.copyWith(saving: true, errorCode: null);
    final result = state.tab == LogTab.cash
        ? await ref.read(logCashPaymentProvider)(
            amount: amount ?? Money.zero,
            category: category,
            bucketId: bucketId,
            note: note,
          )
        : await ref.read(logPastedPaymentProvider)(
            parsed: _parsed,
            category: category,
            bucketId: bucketId,
            amount: amount,
            note: note,
          );
    state = switch (result) {
      Ok() => state.copyWith(saving: false, saved: true),
      Err(:final failure) => state.copyWith(
        saving: false,
        errorCode: failure.code,
      ),
    };
    return result is Ok;
  }
}
