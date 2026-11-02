import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('R-PLAN-1 suggest a wish', () {
    const threshold = Money.kwacha(500);

    test('only for unplanned payments above the threshold', () {
      expect(
        CoolingOffPolicy.suggestWish(
          amount: const Money(50001),
          threshold: threshold,
          isPlanned: false,
        ),
        isTrue,
      );
      expect(
        CoolingOffPolicy.suggestWish(
          amount: threshold,
          threshold: threshold,
          isPlanned: false,
        ),
        isFalse,
      );
      expect(
        CoolingOffPolicy.suggestWish(
          amount: const Money.kwacha(2000),
          threshold: threshold,
          isPlanned: true,
        ),
        isFalse,
      );
    });
  });

  group('R-PLAN-2 cooling off', () {
    Wish wish({int hours = 48}) => ok(
      CoolingOffPolicy.newWish(
        id: 'w',
        name: 'Speaker',
        amount: const Money.kwacha(1200),
        bucketId: 'fun',
        now: utc,
        coolingOffHours: hours,
      ),
    );

    test('ends after the cooling-off hours from the setting', () {
      expect(wish().endsAt, utc.add(const Duration(hours: 48)));
      expect(wish(hours: 24).endsAt, utc.add(const Duration(hours: 24)));
      expect(wish().status, WishStatus.coolingOff);
    });

    test('is over at endsAt, not before', () {
      final w = wish();
      expect(CoolingOffPolicy.isOver(w, w.endsAt), isTrue);
      expect(
        CoolingOffPolicy.isOver(
          w,
          w.endsAt.subtract(const Duration(seconds: 1)),
        ),
        isFalse,
      );
    });

    test('approve only once cooling off is over; drop any time', () {
      final w = wish();
      expect(
        CoolingOffPolicy.approve(w, now: utc),
        isErr('wish.stillCoolingOff'),
      );
      expect(
        ok(CoolingOffPolicy.approve(w, now: w.endsAt)).status,
        WishStatus.approved,
      );
      expect(ok(CoolingOffPolicy.drop(w)).status, WishStatus.dropped);
      expect(ok(CoolingOffPolicy.markBought(w)).status, WishStatus.bought);
    });

    test('a resolved wish cannot change again', () {
      final dropped = ok(CoolingOffPolicy.drop(wish()));
      expect(CoolingOffPolicy.drop(dropped), isErr('wish.resolved'));
      expect(
        CoolingOffPolicy.approve(dropped, now: dropped.endsAt),
        isErr('wish.resolved'),
      );
      expect(CoolingOffPolicy.markBought(dropped), isErr('wish.resolved'));
    });

    test('an approved wish can still be bought', () {
      final w = wish();
      final approved = ok(CoolingOffPolicy.approve(w, now: w.endsAt));
      expect(
        ok(CoolingOffPolicy.markBought(approved)).status,
        WishStatus.bought,
      );
    });
  });

  group('R-PLAN-3 planned purchase done', () {
    final planned = ok(
      PlannedPurchase.create(
        id: 'pp',
        name: 'Gas refill',
        amount: const Money.kwacha(350),
        bucketId: 'living',
      ),
    );

    test('links the paying transaction and shows the difference', () {
      final done = ok(CoolingOffPolicy.markPlannedDone(planned, 'tx'));
      expect(done.done, isTrue);
      expect(done.transactionId, 'tx');
      expect(
        CoolingOffPolicy.difference(planned, actual: const Money.kwacha(380)),
        const Money.kwacha(30),
      );
      expect(
        CoolingOffPolicy.difference(planned, actual: const Money.kwacha(300)),
        const Money.kwacha(-50),
      );
    });

    test('unticking clears the link', () {
      final done = ok(CoolingOffPolicy.markPlannedDone(planned, 'tx'));
      final undone = ok(done.withDone(done: false, transactionId: 'tx'));
      expect(undone.done, isFalse);
      expect(undone.transactionId, isNull);
    });
  });
}
