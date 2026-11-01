import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('PlannedPurchase', () {
    Result<PlannedPurchase> planned({
      String name = 'Gas refill',
      DateTime? due,
      Duration? repeatEvery,
    }) => PlannedPurchase.create(
      id: 'pp',
      name: name,
      amount: const Money.kwacha(350),
      bucketId: 'living',
      due: due,
      repeatEvery: repeatEvery,
    );

    test('starts not done and unlinked', () {
      final p = ok(planned(due: utc, repeatEvery: const Duration(days: 30)));
      expect(p.done, isFalse);
      expect(p.transactionId, isNull);
      expect(p.repeatEvery, const Duration(days: 30));
    });

    test('validates name, due and repeat', () {
      expect(planned(name: ''), isErr('name.blank'));
      expect(planned(due: DateTime(2026)), isErr('due.notUtc'));
      expect(
        planned(repeatEvery: Duration.zero),
        isErr('repeatEvery.notPositive'),
      );
    });
  });

  group('Wish', () {
    Result<Wish> wish(DateTime ends) => Wish.create(
      id: 'w',
      name: 'Speaker',
      amount: const Money.kwacha(1200),
      bucketId: 'fun',
      createdAt: utc,
      endsAt: ends,
    );

    test('starts cooling off', () {
      final w = ok(wish(utc.add(const Duration(hours: 48))));
      expect(w.status, WishStatus.coolingOff);
    });

    test('ends after it was created, in UTC', () {
      expect(wish(utc), isErr('endsAt.notAfterCreated'));
      expect(wish(DateTime(2027)), isErr('endsAt.notUtc'));
    });
  });
}
