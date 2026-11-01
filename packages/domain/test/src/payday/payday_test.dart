import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Result<Transfer> transfer({
  Money amount = const Money.kwacha(770),
  DateTime? at,
}) => Transfer.create(
  id: 't',
  bucketId: 'emergency',
  toAccountId: 'save',
  amount: amount,
  provenAt: at,
);

void main() {
  group('Transfer', () {
    test('starts pending with nothing proven or owed', () {
      final t = ok(transfer());
      expect(t.status, TransferStatus.pending);
      expect(t.provenAmount, isNull);
      expect(t.owedAmount, isNull);
      expect(t.proofRefs, isEmpty);
    });

    test('amount is positive and provenAt is UTC', () {
      expect(transfer(amount: Money.zero), isErr('amount.notPositive'));
      expect(transfer(at: DateTime(2026)), isErr('provenAt.notUtc'));
      expect(ok(transfer(at: utc)).provenAt, utc);
    });
  });

  group('Payday', () {
    Result<Payday> payday({int snoozes = 0, DateTime? at}) => Payday.create(
      id: 'p',
      incomeSourceId: 'salary',
      amount: const Money.kwacha(12000),
      startedAt: at ?? utc,
      transfers: [ok(transfer())],
      snoozesUsed: snoozes,
    );

    test('starts open', () {
      final p = ok(payday());
      expect(p.status, PaydayStatus.open);
      expect(p.transfers, hasLength(1));
      expect(p.snoozesUsed, 0);
    });

    test('rejects negative snoozes and local times', () {
      expect(payday(snoozes: -1), isErr('snoozesUsed.outOfRange'));
      expect(payday(at: DateTime(2026)), isErr('startedAt.notUtc'));
    });
  });
}
