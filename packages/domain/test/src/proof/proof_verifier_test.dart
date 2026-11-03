import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

const lusaka = Duration(hours: 2);
final startedAt = DateTime.utc(2026, 10, 25, 6); // 08:00 local
final now = DateTime.utc(2026, 10, 26, 10); // 12:00 local, the day after

final Account savings = ok(
  Account.create(
    id: 'savings',
    name: 'Savings',
    kind: AccountKind.bank,
    matchKeys: [ok(MatchKey.create('4521'))],
  ),
);

Transfer transfer({
  TransferStatus status = TransferStatus.pending,
  Money? owed,
  Money? proven,
  List<String> refs = const [],
}) => ok(
  Transfer.create(
    id: 't',
    bucketId: 'emergency',
    toAccountId: 'savings',
    amount: const Money.kwacha(1540),
    status: status,
    owedAmount: owed,
    provenAmount: proven,
    proofRefs: refs,
  ),
);

ParsedMessage message({
  Money? amount = const Money.kwacha(1540),
  String? to = 'Transfer to acc ****4521',
  String? ref = 'ZX98YW76',
  DateTime? at,
  bool noDate = false,
}) => ParsedMessage(
  confidence: 1,
  direction: MessageDirection.outgoing,
  amount: amount,
  counterparty: to,
  reference: ref,
  occurredAt: noDate ? null : (at ?? DateTime.utc(2026, 10, 26, 9)),
);

ProofResult verify(
  ParsedMessage parsed, {
  Transfer? t,
  bool used = false,
  Account? account,
}) => ProofVerifier.verify(
  transfer: t ?? transfer(),
  destination: account ?? savings,
  parsed: parsed,
  referenceUsed: used,
  paydayStartedAt: startedAt,
  now: now,
  utcOffset: lusaka,
);

void main() {
  const pass = CheckPassed();

  test('R-PROOF-1 passes when all four checks pass', () {
    final r = verify(message());
    expect(r.checks, everyElement(pass));
    expect(r.passed, isTrue);
  });

  group('R-PROOF-1.1 amount within ±K 1', () {
    test('boundaries', () {
      expect(verify(message(amount: const Money(153900))).amount, pass);
      expect(verify(message(amount: const Money(154100))).amount, pass);
      expect(
        verify(message(amount: const Money(153899))).amount,
        const CheckFailed('amountTooLow'),
      );
      expect(
        verify(message(amount: const Money(154101))).amount,
        const CheckFailed('amountTooHigh'),
      );
    });

    test('a partial transfer is checked against what is owed', () {
      final partial = transfer(
        status: TransferStatus.partial,
        owed: const Money.kwacha(90),
        proven: const Money.kwacha(1450),
      );
      expect(
        verify(message(amount: const Money.kwacha(90)), t: partial).amount,
        pass,
      );
    });
  });

  group('R-PROOF-1.2 account', () {
    test('counterparty must contain a match key (R-ACC-3)', () {
      expect(verify(message(to: 'TRANSFER TO ACC ****4521')).account, pass);
      expect(
        verify(message(to: 'Transfer to acc ****9999')).account,
        const CheckFailed('accountMismatch'),
      );
    });

    test('an account without match keys cannot be checked', () {
      final noKeys = ok(
        Account.create(id: 's', name: 'S', kind: AccountKind.bank),
      );
      expect(
        verify(message(), account: noKeys).account,
        const CheckFailed('accountMismatch'),
      );
    });
  });

  group('R-PROOF-1.3 date', () {
    test('today or yesterday in local time (R-TIME-2)', () {
      // 25 Oct 22:00 UTC is 26 Oct 00:00 local = today.
      expect(verify(message(at: DateTime.utc(2026, 10, 25, 22))).date, pass);
      // 25 Oct 21:59 UTC is 25 Oct 23:59 local = yesterday.
      expect(
        verify(message(at: DateTime.utc(2026, 10, 25, 21, 59))).date,
        pass,
      );
    });

    test('older or future dates fail', () {
      expect(
        verify(message(at: DateTime.utc(2026, 10, 24, 21, 59))).date,
        const CheckFailed('notTodayOrYesterday'),
      );
      expect(
        verify(message(at: DateTime.utc(2026, 10, 26, 22))).date,
        const CheckFailed('notTodayOrYesterday'),
      );
    });

    test('not before the payday started minus 1 day', () {
      final late = ProofVerifier.verify(
        transfer: transfer(),
        destination: savings,
        parsed: message(at: DateTime.utc(2026, 10, 24, 22)), // 25 Oct 00:00
        referenceUsed: false,
        paydayStartedAt: DateTime.utc(2026, 10, 25, 23), // 26 Oct 01:00
        now: now,
        utcOffset: lusaka,
      );
      expect(late.date, const CheckFailed('beforePayday'));
      // Exactly started − 1 day passes.
      final edge = ProofVerifier.verify(
        transfer: transfer(),
        destination: savings,
        parsed: message(at: DateTime.utc(2026, 10, 24, 23)),
        referenceUsed: false,
        paydayStartedAt: DateTime.utc(2026, 10, 25, 23),
        now: now,
        utcOffset: lusaka,
      );
      expect(edge.date, pass);
    });
  });

  group('R-PROOF-1.4 reference', () {
    test('must not be used by another proof', () {
      expect(
        verify(message(), used: true).reference,
        const CheckFailed('referenceUsed'),
      );
    });

    test('blank counts as missing', () {
      expect(verify(message(ref: '  ')).reference, const CheckUnknown());
    });
  });

  test('R-PROOF-2 missing fields are unknown and fail the proof', () {
    final r = verify(message(amount: null, to: null, ref: null, noDate: true));
    expect(r.checks, everyElement(const CheckUnknown()));
    expect(r.passed, isFalse);
  });

  group('applying a proof', () {
    test('a passing proof makes the transfer proven', () {
      final t = ok(
        ProofVerifier.applyProof(transfer(), verify(message()), message(), now),
      );
      expect(t.status, TransferStatus.proven);
      expect(t.provenAmount, const Money.kwacha(1540));
      expect(t.owedAmount, Money.zero);
      expect(t.proofRefs, ['ZX98YW76']);
      expect(t.provenAt, now);
    });

    test('a failed proof cannot be applied', () {
      final bad = message(amount: const Money.kwacha(10));
      expect(
        ProofVerifier.applyProof(transfer(), verify(bad), bad, now),
        isErr('proof.notPassed'),
      );
    });
  });

  group('R-PROOF-3 partial', () {
    final low = message(amount: const Money.kwacha(1450));

    test('only when the amount is the only failure and is lower', () {
      expect(ProofVerifier.canSavePartial(verify(low)), isTrue);
      expect(
        ProofVerifier.canSavePartial(
          verify(message(amount: const Money.kwacha(2000))),
        ),
        isFalse,
      );
      expect(
        ProofVerifier.canSavePartial(
          verify(message(amount: const Money.kwacha(1450), to: 'x')),
        ),
        isFalse,
      );
      expect(ProofVerifier.canSavePartial(verify(message())), isFalse);
    });

    test('saves K x and marks K y owed, then a second proof completes it', () {
      final partial = ok(
        ProofVerifier.applyPartial(transfer(), verify(low), low, now),
      );
      expect(partial.status, TransferStatus.partial);
      expect(partial.provenAmount, const Money.kwacha(1450));
      expect(partial.owedAmount, const Money.kwacha(90));
      expect(ProofVerifier.amountDue(partial), const Money.kwacha(90));

      final rest = message(amount: const Money.kwacha(90), ref: 'QQ11');
      final done = ok(
        ProofVerifier.applyProof(partial, verify(rest, t: partial), rest, now),
      );
      expect(done.status, TransferStatus.proven);
      expect(done.provenAmount, const Money.kwacha(1540));
      expect(done.owedAmount, Money.zero);
      expect(done.proofRefs, ['ZX98YW76', 'QQ11']);
    });

    test('a second short proof keeps it partial with less owed', () {
      final partial = ok(
        ProofVerifier.applyPartial(transfer(), verify(low), low, now),
      );
      final some = message(amount: const Money.kwacha(40), ref: 'QQ11');
      final still = ok(
        ProofVerifier.applyPartial(
          partial,
          verify(some, t: partial),
          some,
          now,
        ),
      );
      expect(still.owedAmount, const Money.kwacha(50));
      expect(still.provenAmount, const Money.kwacha(1490));
    });

    test('cannot be applied when partial is not offered', () {
      expect(
        ProofVerifier.applyPartial(
          transfer(),
          verify(message()),
          message(),
          now,
        ),
        isErr('proof.notPartial'),
      );
    });
  });

  group('R-PROOF-4 self-reported', () {
    test('marks a pending or partial transfer as done', () {
      final t = ok(ProofVerifier.markSelfReported(transfer(), now));
      expect(t.status, TransferStatus.selfReported);
      expect(t.provenAt, now);
      expect(
        ok(
          ProofVerifier.markSelfReported(
            transfer(status: TransferStatus.partial, owed: const Money(1)),
            now,
          ),
        ).status,
        TransferStatus.selfReported,
      );
    });

    test('a proven transfer stays proven', () {
      expect(
        ProofVerifier.markSelfReported(
          transfer(status: TransferStatus.proven),
          now,
        ),
        isErr('transfer.alreadyProven'),
      );
    });
  });

  group('R-PROOF-5 streak', () {
    Payday payday(
      List<TransferStatus> statuses, {
      PaydayStatus status = PaydayStatus.complete,
    }) => ok(
      Payday.create(
        id: 'p',
        incomeSourceId: 's',
        amount: const Money(1),
        startedAt: startedAt,
        status: status,
        transfers: [for (final s in statuses) transfer(status: s)],
      ),
    );
    final proven = payday([TransferStatus.proven, TransferStatus.proven]);
    final self = payday([TransferStatus.proven, TransferStatus.selfReported]);
    final open = payday([TransferStatus.pending], status: PaydayStatus.open);

    test('counts consecutive completed all-proven paydays, newest first', () {
      expect(ProofVerifier.streak([proven, proven, proven]), 3);
      expect(ProofVerifier.streak(const []), 0);
    });

    test('the newest payday still in progress is skipped', () {
      expect(ProofVerifier.streak([open, proven, proven]), 2);
    });

    test('an older payday left open breaks the streak', () {
      expect(ProofVerifier.streak([proven, open, proven]), 1);
    });

    test('self-reported breaks nothing but does not count', () {
      expect(ProofVerifier.streak([proven, self, proven]), 2);
    });
  });
}
