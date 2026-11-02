import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_activity.dart';
import '../../helpers.dart';
import '../../support/world.dart';

// Synthetic formats for the engine only (AGENTS.md §5).
final SmsParser testParser = SmsParser([
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'test-paid',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^TEST PAID K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
      r'FEE K(?<fee>[\d,.]+)(?: REF (?<reference>\w+))?$',
    ),
  ),
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'test-cash-out',
    direction: MessageDirection.outgoing,
    pattern: RegExp(r'^TEST CASH K(?<amount>[\d,.]+) FEE K(?<fee>[\d,.]+)$'),
    isWithdrawal: true,
  ),
]);

const momoPackage = 'test.momo';

class LoggingWorld extends World {
  final source = FakePaymentAlertSource();
  final rules = InMemoryMerchantRuleRepository();
  final receipts = InMemoryReceiptRepository();
  final capture = FakeImageCapture();
  final recognizer = FakeTextRecognizer();
  final receiptParser = FakeReceiptTextParser();

  late final writer = SpendWriter(transactions, ledger, ids);
  late final ingest = IngestPaymentAlerts(
    source: source,
    parser: testParser,
    alerts: alerts,
    packageSources: const {momoPackage: AlertSource.mtnMomo},
    ids: ids,
    zone: zone,
  );
  late final categorize = CategorizeAlert(
    alerts: alerts,
    accounts: accounts,
    transactions: transactions,
    rules: rules,
    writer: writer,
    ids: ids,
  );

  void capture_(String text, [String package = momoPackage, DateTime? at]) =>
      source.queue.add(
        IncomingAlertText(
          packageName: package,
          text: text,
          receivedAt: at ?? clock.now(),
        ),
      );

  Future<List<LedgerEntry>> entries() async => ok(await ledger.getEntries());
}

void main() {
  late LoggingWorld w;
  setUp(() => w = LoggingWorld());
  String living() => w.bucketOf(BucketKind.living);

  group('IngestPaymentAlerts', () {
    test('parses captures with their provider and stores them', () async {
      w.capture_('TEST PAID K185.00 TO [MERCHANT] FEE K2.50 REF ZX98');
      final fresh = ok(await w.ingest());
      final a = fresh.single;
      expect(a.source, AlertSource.mtnMomo);
      expect(a.parsed.amount, const Money(18500));
      expect(a.status, AlertStatus.newAlert);
      expect(await WatchUnsortedAlerts(w.alerts)().first, [a]);
    });

    test('marks repeats as duplicates (R-PARSE-4)', () async {
      w
        ..capture_('TEST PAID K185.00 TO [MERCHANT] FEE K2.50 REF ZX98')
        ..capture_('TEST PAID K185.00 TO [MERCHANT] FEE K2.50 REF ZX98');
      expect(ok(await w.ingest()), hasLength(1));
      w
        ..capture_('TEST PAID K40.00 TO [SHOP] FEE K1.00')
        ..capture_('TEST PAID K40.00 TO [SHOP] FEE K1.00');
      expect(ok(await w.ingest()), hasLength(1));
      final statuses = w.alerts.store.items.values.map((a) => a.status);
      expect(statuses.where((s) => s == AlertStatus.duplicate), hasLength(2));
    });

    test('unknown packages and unreadable text still become alerts', () async {
      w.capture_('something else', 'other.app');
      final a = ok(await w.ingest()).single;
      expect(a.source, AlertSource.unknown);
      expect(a.parsed, ParsedMessage.unparsed);
    });
  });

  group('CategorizeAlert (screen 18)', () {
    test(
      'files the payment and its fee from the bucket (R-SPEND-1/2)',
      () async {
        w.capture_('TEST PAID K185.00 TO [MERCHANT] FEE K2.50 REF ZX98');
        final a = ok(await w.ingest()).single;
        final tx = ok(
          await w.categorize(
            alertId: a.id,
            category: Category.food,
            bucketId: living(),
          ),
        )!;
        expect(tx.accountId, 'momo');
        expect(tx.amount, const Money(18500));
        expect(ok(await w.alerts.get(a.id)).status, AlertStatus.sorted);
        expect(
          BalanceCalculator.balance(await w.entries(), living()),
          const Money(-18750),
        );
        final categories = w.transactions.store.items.values.map(
          (t) => t.category,
        );
        expect(categories, containsAll([Category.food, Category.fees]));
      },
    );

    test(
      '"always file" saves a rule that pre-fills the next one (R-SPEND-3)',
      () async {
        w.capture_('TEST PAID K185.00 TO [MERCHANT] FEE K2.50 REF ZX98');
        final a = ok(await w.ingest()).single;
        await w.categorize(
          alertId: a.id,
          category: Category.market,
          bucketId: living(),
          alwaysFile: true,
        );
        w.capture_('TEST PAID K20.00 TO [MERCHANT] FEE K1.00 REF QQ11');
        final next = ok(await w.ingest()).single;
        final s = ok(await SuggestAlertFiling(w.rules, w.settings)(next));
        expect(s.category, Category.market);
        expect(s.bucketId, living());
        expect(s.fileAutomatically, isFalse);
      },
    );

    test(
      'a withdrawal moves cash; only the fee is spending (R-SPEND-4)',
      () async {
        w.capture_('TEST CASH K500.00 FEE K5.00');
        final a = ok(await w.ingest()).single;
        final filed = ok(
          await w.categorize(
            alertId: a.id,
            category: Category.other,
            bucketId: living(),
          ),
        );
        expect(filed, isNull);
        final withdrawal = w.transactions.withdrawals.items.values.single;
        expect(withdrawal.amount, const Money.kwacha(500));
        expect(withdrawal.cashAccountId, 'cash');
        expect(
          BalanceCalculator.balance(await w.entries(), living()),
          const Money.kwacha(-5),
        );
      },
    );

    test('an alert without an amount must be entered', () async {
      w.capture_('something else', 'other.app');
      final a = ok(await w.ingest()).single;
      expect(
        await w.categorize(
          alertId: a.id,
          category: Category.other,
          bucketId: living(),
        ),
        isErr('amount.missing'),
      );
    });

    test('SkipAlert steps to the next unsorted alert', () async {
      w
        ..capture_('TEST PAID K1.00 TO [A] FEE K0.10 REF A1')
        ..capture_(
          'TEST PAID K2.00 TO [B] FEE K0.10 REF B1',
          momoPackage,
          w.clock.now().add(const Duration(minutes: 1)),
        );
      final [first, second] = ok(await w.ingest());
      expect(ok(await SkipAlert(w.alerts)(first.id)), second);
      expect(ok(await SkipAlert(w.alerts)(second.id)), isNull);
    });

    test('SaveMerchantRule on its own', () async {
      final rule = ok(
        await SaveMerchantRule(w.rules, w.ids)(
          counterparty: 'ZESCO 01',
          category: Category.bill,
          bucketId: living(),
        ),
      );
      expect(rule.merchantKey.value, 'zesco');
    });
  });

  group('Log a payment (screen 19)', () {
    test('cash comes from Cash in hand', () async {
      final tx = ok(
        await LogCashPayment(w.accounts, w.writer, w.ids, w.clock)(
          amount: const Money.kwacha(40),
          category: Category.transport,
          bucketId: living(),
        ),
      );
      expect(tx.accountId, 'cash');
      expect(tx.source, TransactionSource.cash);
      expect(tx.occurredAt, w.clock.now());
    });

    test('validation error for K 0', () async {
      expect(
        await LogCashPayment(w.accounts, w.writer, w.ids, w.clock)(
          amount: Money.zero,
          category: Category.food,
          bucketId: living(),
        ),
        isErr('amount.notPositive'),
      );
    });

    test('a pasted message is parsed and logged with its fee', () async {
      final parsed = ParsePastedMessage(testParser, w.clock, w.zone)(
        'TEST PAID K185.00 TO [MERCHANT] FEE K2.50 REF ZX98',
      );
      final tx = ok(
        await LogPastedPayment(w.accounts, w.writer, w.ids, w.clock)(
          parsed: parsed,
          category: Category.food,
          bucketId: living(),
          source: AlertSource.mtnMomo,
        ),
      );
      expect(tx.source, TransactionSource.pasted);
      expect(tx.accountId, 'momo');
      expect(w.transactions.store.items, hasLength(2));
      expect(
        await LogPastedPayment(w.accounts, w.writer, w.ids, w.clock)(
          parsed: ParsedMessage.unparsed,
          category: Category.food,
          bucketId: living(),
        ),
        isErr('amount.missing'),
      );
    });

    test('R-PLAN-1 suggests a wish above K 500', () async {
      final suggest = SuggestWish(w.settings);
      expect(ok(await suggest(amount: const Money.kwacha(501))), isTrue);
      expect(ok(await suggest(amount: const Money.kwacha(500))), isFalse);
    });
  });

  group('Receipts (screens 20–21)', () {
    test('capture, recognise, edit and save split across buckets', () async {
      final path = ok(
        await CaptureReceiptImage(w.capture)(CaptureSource.camera),
      );
      w
        ..recognizer.text = '[OCR TEXT]'
        ..receiptParser.draft = ReceiptDraft(
          total: Scored(const Money.kwacha(300), 0.9),
        );
      final recognize = RecognizeReceipt(
        recognizer: w.recognizer,
        parser: w.receiptParser,
        receipts: w.receipts,
        ids: w.ids,
        clock: w.clock,
        zone: w.zone,
      );
      final stored = ok(await recognize(path!));
      expect(stored.imagePath, path);
      final edited = ok(
        await UpdateReceiptDraft(w.receipts)(
          stored.id,
          ReceiptDraft(total: Scored(const Money.kwacha(300), 1)),
        ),
      );
      expect(edited.draft.total!.confidence, 1);
      final short = w.bucketOf(BucketKind.shortTerm);
      final tx = ok(
        await SaveReceipt(w.receipts, w.accounts, w.writer, w.ids, w.clock)(
          receiptId: stored.id,
          total: const Money.kwacha(300),
          category: Category.market,
          bucketId: living(),
          lines: [
            TransactionLine(living(), const Money.kwacha(200)),
            TransactionLine(short, const Money.kwacha(100)),
          ],
        ),
      );
      expect(tx.receiptId, stored.id);
      expect(tx.accountId, 'momo');
    });

    test('no text found', () async {
      final recognize = RecognizeReceipt(
        recognizer: w.recognizer,
        parser: w.receiptParser,
        receipts: w.receipts,
        ids: w.ids,
        clock: w.clock,
        zone: w.zone,
      );
      expect(await recognize('/x.jpg'), isErr('receipt.noText'));
    });

    test('a cancelled capture returns null', () async {
      w.capture.path = null;
      expect(
        ok(await CaptureReceiptImage(w.capture)(CaptureSource.gallery)),
        isNull,
      );
    });
  });
}
