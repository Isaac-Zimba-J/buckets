import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

import 'fakes.dart';

/// In-memory [PaydayRepository].
class InMemoryPaydayRepository implements PaydayRepository {
  final store = MemoryStore<Payday>((p) => p.id);

  List<Payday> _newestFirst() =>
      store.items.values.toList()
        ..sort((a, b) => b.startedAt.compareTo(a.startedAt));

  Payday? _open() =>
      _newestFirst().where((p) => p.status == PaydayStatus.open).firstOrNull;

  @override
  Future<Result<Payday>> get(String id) => store.get(id);

  @override
  Future<Result<List<Payday>>> getAll() => store.run(_newestFirst);

  @override
  Future<Result<void>> save(Payday payday) =>
      store.run(() => store.put(payday));

  @override
  Future<Result<bool>> isProofReferenceUsed(String reference) => store.run(
    () => store.items.values.any(
      (p) => p.transfers.any((t) => t.proofRefs.contains(reference)),
    ),
  );

  @override
  Stream<Payday> watch(String id) => store.watch(() => store.items[id]!);

  @override
  Stream<Payday?> watchOpen() => store.watch(_open);
}

/// In-memory [AlertRepository].
class InMemoryAlertRepository implements AlertRepository {
  final store = MemoryStore<PaymentAlert>((a) => a.id);

  @override
  Future<Result<PaymentAlert>> get(String id) => store.get(id);

  @override
  Future<Result<void>> save(PaymentAlert alert) =>
      store.run(() => store.put(alert));

  @override
  Future<Result<PaymentAlert?>> findByReference(
    AlertSource source,
    String reference,
  ) => store.run(
    () => store.items.values
        .where((a) => a.source == source && a.parsed.reference == reference)
        .firstOrNull,
  );

  @override
  Future<Result<List<PaymentAlert>>> getReceivedIn(DateWindow window) =>
      store.run(
        () => store.items.values
            .where((a) => window.contains(a.receivedAt))
            .toList(),
      );

  @override
  Future<Result<void>> clearRawTextBefore(DateTime cutoff) => store.run(() {
    for (final a in store.items.values.toList()) {
      if (!a.receivedAt.isBefore(cutoff) || a.rawText == null) continue;
      store.put(switch (PaymentAlert.create(
        id: a.id,
        rawText: null,
        source: a.source,
        receivedAt: a.receivedAt,
        parsed: a.parsed,
        status: a.status,
      )) {
        Ok(:final value) => value,
        Err() => a,
      });
    }
  });

  @override
  Stream<List<PaymentAlert>> watchByStatus(AlertStatus status) => store.watch(
    () =>
        store.items.values.where((a) => a.status == status).toList()
          ..sort((a, b) => a.receivedAt.compareTo(b.receivedAt)),
  );
}

/// In-memory [GoalRepository].
class InMemoryGoalRepository implements GoalRepository {
  final store = MemoryStore<Goal>((g) => g.bucketId);

  @override
  Future<Result<Goal?>> get(String bucketId) =>
      store.run(() => store.items[bucketId]);

  @override
  Future<Result<void>> save(Goal goal) => store.run(() => store.put(goal));

  @override
  Stream<List<Goal>> watchAll() =>
      store.watch(() => store.items.values.toList());
}

/// In-memory [HeldIncomeRepository].
class InMemoryHeldIncomeRepository implements HeldIncomeRepository {
  final store = MemoryStore<HeldIncome>((h) => h.id);

  @override
  Future<Result<List<HeldIncome>>> getFor(String incomeSourceId) => store.run(
    () =>
        store.items.values
            .where((h) => h.incomeSourceId == incomeSourceId)
            .toList()
          ..sort((a, b) => a.receivedAt.compareTo(b.receivedAt)),
  );

  @override
  Future<Result<void>> add(HeldIncome held) => store.run(() => store.put(held));

  @override
  Future<Result<void>> remove(List<String> ids) =>
      store.run(() => ids.forEach(store.remove));
}

/// In-memory [TransactionRepository].
class InMemoryTransactionRepository implements TransactionRepository {
  final store = MemoryStore<Transaction>((t) => t.id);
  final withdrawals = MemoryStore<CashWithdrawal>((w) => w.id);

  @override
  Future<Result<Transaction>> get(String id) => store.get(id);

  @override
  Future<Result<void>> save(Transaction transaction) =>
      store.run(() => store.put(transaction));

  @override
  Future<Result<List<Transaction>>> getIn(DateWindow window) => store.run(
    () =>
        store.items.values.where((t) => window.contains(t.occurredAt)).toList()
          ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt)),
  );

  @override
  Future<Result<void>> saveWithdrawal(CashWithdrawal withdrawal) =>
      withdrawals.run(() => withdrawals.put(withdrawal));

  @override
  Future<Result<List<CashWithdrawal>>> getWithdrawalsIn(DateWindow window) =>
      withdrawals.run(
        () => withdrawals.items.values
            .where((w) => window.contains(w.occurredAt))
            .toList(),
      );

  @override
  Stream<List<Transaction>> watchRecent(int limit) => store.watch(
    () =>
        (store.items.values.toList()
              ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt)))
            .take(limit)
            .toList(),
  );
}

/// In-memory [MerchantRuleRepository].
class InMemoryMerchantRuleRepository implements MerchantRuleRepository {
  final store = MemoryStore<MerchantRule>((r) => r.merchantKey.value);

  @override
  Future<Result<MerchantRule?>> findByKey(MerchantKey key) =>
      store.run(() => store.items[key.value]);

  @override
  Future<Result<void>> save(MerchantRule rule) =>
      store.run(() => store.put(rule));
}

/// In-memory [ReceiptRepository].
class InMemoryReceiptRepository implements ReceiptRepository {
  final store = MemoryStore<StoredReceipt>((r) => r.id);

  @override
  Future<Result<StoredReceipt>> get(String id) => store.get(id);

  @override
  Future<Result<void>> save(StoredReceipt receipt) =>
      store.run(() => store.put(receipt));
}

/// A [PaymentAlertSource] with a queue tests fill.
class FakePaymentAlertSource implements PaymentAlertSource {
  final queue = <IncomingAlertText>[];

  @override
  Future<Result<List<IncomingAlertText>>> drain() async {
    final drained = [...queue];
    queue.clear();
    return Ok(drained);
  }
}

/// An [ImageCapture] returning [path], or null as if cancelled.
class FakeImageCapture implements ImageCapture {
  String? path = '/private/receipt.jpg';

  @override
  Future<Result<String?>> capture(CaptureSource source) async => Ok(path);
}

/// A [TextRecognizer] returning [text].
class FakeTextRecognizer implements TextRecognizer {
  String text = '';

  @override
  Future<Result<String>> recognize(String imagePath) async => Ok(text);
}

/// A [ReceiptTextParser] returning [draft] for any text.
class FakeReceiptTextParser implements ReceiptTextParser {
  ReceiptDraft draft = ReceiptDraft();

  @override
  ReceiptDraft parse(String text, {required Duration utcOffset}) => draft;
}
