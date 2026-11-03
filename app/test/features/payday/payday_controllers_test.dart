import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/payday/presentation/controllers/income_received_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_done_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/proof_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

// A synthetic message format for tests only (AGENTS.md §5).
final SmsParser testParser = SmsParser([
  MessageTemplate(
    source: AlertSource.unknown,
    name: 'test-sent',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^TEST SENT K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
      r'REF (?<reference>\w+) AT (?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2})$',
    ),
    parseDate: (raw, offset) {
      final p = raw.split(RegExp('[- :]')).map(int.parse).toList();
      return DateTime.utc(p[0], p[1], p[2], p[3], p[4]).subtract(offset);
    },
  ),
]);

String sent(String amount, String ref) =>
    'TEST SENT K$amount TO acc ****4521 REF $ref AT 2026-10-25 09:00';

Future<T> next<T>(
  ProviderContainer c,
  ProviderListenable<AsyncValue<T>> p,
) async {
  c.listen(p, (_, _) {});
  for (var i = 0; i < 100; i++) {
    final v = c.read(p);
    if (v case AsyncData(:final value) when !v.isLoading) return value;
    if (v case AsyncError(:final error)) fail('$p failed: $error');
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('no value for $p');
}

void main() {
  late ProviderContainer c;
  late Payday payday;
  setUp(() async {
    c = ProviderContainer(
      overrides: [
        ...fakePortOverrides(),
        smsParserProvider.overrideWithValue(testParser),
      ],
      retry: retryUnlessFailure,
    );
    (await seedDemo(c)).orThrow();
    payday = (await c.read(paydayRepositoryProvider).getAll()).orThrow().single;
  });
  tearDown(() => c.dispose());

  Transfer transfer(String bucketName) {
    final buckets = (c.read(
      bucketRepositoryProvider,
    ) as InMemoryBucketRepository).store.items.values;
    final id = buckets.firstWhere((b) => b.name == bucketName).id;
    return payday.transfers.firstWhere((t) => t.bucketId == id);
  }

  group('13 Payday transfers', () {
    test('open: 0 of 4, K 3,850 left, snooze available', () async {
      final s = await next(c, paydayControllerProvider(payday.id));
      expect(s.transfers, hasLength(4));
      expect(s.done, 0);
      expect(s.left, const Money.kwacha(3850));
      expect(s.complete, isFalse);
      expect(s.snoozesLeft, 1);
    });

    test('snooze used, then no snoozes left', () async {
      final p = paydayControllerProvider(payday.id);
      await next(c, p);
      expect(await c.read(p.notifier).snooze(), isTrue);
      await pumpEventQueue();
      var s = await next(c, p);
      expect(s.snoozed, isTrue);
      expect(s.snoozesLeft, 0);
      expect(await c.read(p.notifier).snooze(), isFalse);
      s = c.read(p).value!;
      expect(s.errorCode, 'snooze.noneLeft');
    });

    test('all proven or saved: complete', () async {
      for (final t in payday.transfers) {
        (await c.read(markTransferSelfReportedProvider)(
          paydayId: payday.id,
          transferId: t.id,
        )).orThrow();
      }
      final s = await next(c, paydayControllerProvider(payday.id));
      expect(s.complete, isTrue);
      expect(s.done, 4);
    });
  });

  group('14–15 Prove transfer', () {
    test('idle → passed with four green checks', () async {
      final t = transfer('Emergency');
      final p = proofControllerProvider(payday.id, t.id);
      c.listen(p, (_, _) {});
      expect(c.read(p), isA<ProofIdle>());
      await c.read(p.notifier).check(sent('770.00', 'ZX98'));
      final s = c.read(p) as ProofPassed;
      expect(s.checks.every((x) => x.passed), isTrue);
    });

    test('failed with unknown fields', () async {
      final t = transfer('Emergency');
      final p = proofControllerProvider(payday.id, t.id);
      c.listen(p, (_, _) {});
      await c.read(p.notifier).check('hello');
      final s = c.read(p) as ProofFailed;
      expect(s.checks.every((x) => x.unknown), isTrue);
      expect(s.canSavePartial, isFalse);
    });

    test('failed low: save K 700 and mark K 70 owed (R-PROOF-3)', () async {
      final t = transfer('Emergency');
      final p = proofControllerProvider(payday.id, t.id);
      c.listen(p, (_, _) {});
      await c.read(p.notifier).check(sent('700.00', 'AA11'));
      final s = c.read(p) as ProofFailed;
      expect(s.canSavePartial, isTrue);
      expect(s.parsed, const Money.kwacha(700));
      expect(s.owed, const Money.kwacha(70));
      expect(s.checks.firstWhere((x) => !x.passed).reason, 'amountTooLow');
      expect(await c.read(p.notifier).savePartial(), isTrue);
      expect(c.read(p), isA<ProofSaved>());
    });

    test('mark as saved (R-PROOF-4)', () async {
      final t = transfer('Short-term');
      final p = proofControllerProvider(payday.id, t.id);
      c.listen(p, (_, _) {});
      expect(await c.read(p.notifier).markSelfReported(), isTrue);
      expect(c.read(p), isA<ProofSaved>());
    });
  });

  test('16 Payday complete summary', () async {
    final s = await next(c, paydayDoneControllerProvider(payday.id));
    expect(s.livingLeft, const Money.kwacha(3080));
    expect(s.guiltFreeLeft, const Money.kwacha(770));
    expect(s.moved, Money.zero);
    expect(s.streak, 0);
  });

  group('17 Side hustle received', () {
    late String hustleId;
    setUp(() async {
      hustleId = (await c.read(saveIncomeSourceProvider)(
        name: 'Tutoring',
        kind: IncomeKind.sideHustle,
        landsInAccountId: 'momo',
      )).orThrow().id;
      (await c
              .read(alertRepositoryProvider)
              .save(
                PaymentAlert.create(
                  id: 'al',
                  rawText: null,
                  source: AlertSource.mtnMomo,
                  receivedAt: c.read(clockProvider).now(),
                  parsed: ParsedMessage(
                    confidence: 1,
                    direction: MessageDirection.incoming,
                    amount: const Money.kwacha(2000),
                    counterparty: '[CUSTOMER]',
                  ),
                ).orThrow(),
              ))
          .orThrow();
    });

    test('ready with the side-hustle suggestion', () async {
      final s = await next(c, incomeReceivedControllerProvider('al'));
      s as IncomeReady;
      expect(s.suggestion, IncomeSuggestion.sideHustle);
      expect(s.amount, const Money.kwacha(2000));
      expect(s.sideHustles.single.id, hustleId);
    });

    test('split now starts a payday', () async {
      final p = incomeReceivedControllerProvider('al');
      await next(c, p);
      expect(await c.read(p.notifier).splitNow(hustleId), isTrue);
      expect(c.read(p).value, isA<IncomeSplit>());
    });

    test('hold until month end', () async {
      final p = incomeReceivedControllerProvider('al');
      await next(c, p);
      expect(await c.read(p.notifier).hold(hustleId), isTrue);
      final s = c.read(p).value! as IncomeHolding;
      expect(s.releaseAt, DateTime.utc(2026, 10, 31, 16));
    });

    test('not a hustle: dismissed', () async {
      final p = incomeReceivedControllerProvider('al');
      await next(c, p);
      expect(await c.read(p.notifier).dismiss(), isTrue);
      expect(c.read(p).value, isA<IncomeDismissed>());
    });
  });
}
