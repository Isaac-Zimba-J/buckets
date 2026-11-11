import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import '../../support/payday_world.dart';

void main() {
  late PaydayWorld w;
  setUp(() => w = PaydayWorld());

  GetCurrentCycle cycleOf() =>
      GetCurrentCycle(w.incomes, w.paydays, w.settings, w.clock, w.zone);

  MoveBetweenBuckets moveUseCase() =>
      MoveBetweenBuckets(w.buckets, w.ledger, cycleOf(), w.ids, w.clock);

  Future<Money> balance(String bucketId) async =>
      BalanceCalculator.balance(ok(await w.ledger.getEntries()), bucketId);

  group('MoveBetweenBuckets (R-MOVE-1, R-MOVE-2)', () {
    test('a plain move writes the pair and shifts both balances', () async {
      final salary = await w.canvasSetup();
      await w.startSalary(salary);
      final short = w.bucketOf(BucketKind.shortTerm);
      final before = await balance(short);
      final laptop = await balance('laptop');
      final result = ok(
        await moveUseCase()(
          fromBucketId: short,
          toBucketId: 'laptop',
          amount: const Money.kwacha(100),
        ),
      );
      expect(result, isA<MoveCompleted>());
      expect(await balance(short), before - const Money.kwacha(100));
      expect(await balance('laptop'), laptop + const Money.kwacha(100));
    });

    test('moving more than available fails', () async {
      final salary = await w.canvasSetup();
      await w.startSalary(salary);
      final short = w.bucketOf(BucketKind.shortTerm);
      expect(
        await moveUseCase()(
          fromBucketId: short,
          toBucketId: 'laptop',
          amount: const Money.kwacha(999999),
        ),
        isErr('amount.exceedsAvailable'),
      );
    });

    test('a protected move needs confirming, then goes through', () async {
      final salary = await w.canvasSetup();
      await w.startSalary(salary);
      final long = w.bucketOf(BucketKind.longTerm);
      final pending = ok(
        await moveUseCase()(
          fromBucketId: long,
          toBucketId: 'laptop',
          amount: const Money.kwacha(100),
        ),
      );
      expect(pending, isA<MoveNeedsConfirm>());
      expect((pending as MoveNeedsConfirm).warning, MoveWarning.fromProtected);
      final done = ok(
        await moveUseCase()(
          fromBucketId: long,
          toBucketId: 'laptop',
          amount: const Money.kwacha(100),
          confirmed: true,
        ),
      );
      expect(done, isA<MoveCompleted>());
    });

    test('same bucket is rejected', () async {
      final salary = await w.canvasSetup();
      await w.startSalary(salary);
      final short = w.bucketOf(BucketKind.shortTerm);
      expect(
        await moveUseCase()(
          fromBucketId: short,
          toBucketId: short,
          amount: const Money.kwacha(10),
        ),
        isErr('move.sameBucket'),
      );
    });
  });

  group('SetStartingBalance (R-LEDGER-6)', () {
    test('adds, corrects by reversal, and clears to zero', () async {
      final useCase = SetStartingBalance(w.ledger, w.ids, w.clock);
      ok(await useCase(bucketId: 'laptop', amount: const Money.kwacha(500)));
      expect(await balance('laptop'), const Money.kwacha(500));
      ok(await useCase(bucketId: 'laptop', amount: const Money.kwacha(800)));
      expect(await balance('laptop'), const Money.kwacha(800));
      ok(await useCase(bucketId: 'laptop', amount: Money.zero));
      expect(await balance('laptop'), Money.zero);
    });

    test('a negative amount is refused', () async {
      expect(
        await SetStartingBalance(w.ledger, w.ids, w.clock)(
          bucketId: 'laptop',
          amount: const Money.kwacha(-1),
        ),
        isErr('amount.negative'),
      );
    });

    test('is excluded from saved this cycle but counts in total', () async {
      final salary = await w.canvasSetup();
      await w.startSalary(salary);
      final stats = GetSavingsStats(w.buckets, w.ledger, cycleOf());
      final before = ok(await stats());
      ok(
        await SetStartingBalance(w.ledger, w.ids, w.clock)(
          bucketId: w.bucketOf(BucketKind.longTerm),
          amount: const Money.kwacha(5000),
        ),
      );
      final after = ok(await stats());
      expect(after.savedThisCycle, before.savedThisCycle);
      expect(after.totalSaved, before.totalSaved + const Money.kwacha(5000));
    });
  });

  group('ArchiveBucket (R-BUCKET-6)', () {
    ArchiveBucket archiveUseCase() => ArchiveBucket(
      buckets: w.buckets,
      ledger: w.ledger,
      paydays: w.paydays,
      incomes: w.incomes,
      profiles: w.profiles,
      settings: w.settings,
      ids: w.ids,
      clock: w.clock,
    );

    test('a default bucket cannot be removed', () async {
      expect(
        await archiveUseCase()(bucketId: w.bucketOf(BucketKind.living)),
        isErr('bucket.notRemovable'),
      );
    });

    test('an empty goal is archived', () async {
      ok(await archiveUseCase()(bucketId: 'laptop'));
      expect(ok(await w.buckets.get('laptop')).archived, isTrue);
    });

    test('money is moved out first, then the goal is archived', () async {
      ok(
        await SetStartingBalance(w.ledger, w.ids, w.clock)(
          bucketId: 'laptop',
          amount: const Money.kwacha(300),
        ),
      );
      final short = w.bucketOf(BucketKind.shortTerm);
      ok(await archiveUseCase()(bucketId: 'laptop', moveTo: short));
      expect(await balance('laptop'), Money.zero);
      expect(await balance(short), const Money.kwacha(300));
      expect(ok(await w.buckets.get('laptop')).archived, isTrue);
    });

    test('money with no destination is refused', () async {
      ok(
        await SetStartingBalance(w.ledger, w.ids, w.clock)(
          bucketId: 'laptop',
          amount: const Money.kwacha(300),
        ),
      );
      expect(
        await archiveUseCase()(bucketId: 'laptop'),
        isErr('moveTo.missing'),
      );
    });

    test('an overspent bucket must be covered first', () async {
      final spend = ok(
        LedgerEntry.create(
          id: 'od',
          occurredAt: w.clock.now(),
          kind: LedgerEntryKind.spend,
          bucketId: 'laptop',
          amount: const Money.kwacha(-50),
        ),
      );
      ok(await w.ledger.append([spend]));
      expect(
        await archiveUseCase()(bucketId: 'laptop'),
        isErr('bucket.overspent'),
      );
    });

    test('blocked while a payday transfer to it is open', () async {
      final salary = await w.canvasSetup();
      await w.startSalary(salary);
      expect(
        await archiveUseCase()(bucketId: 'laptop', moveTo: 'savings'),
        isErr('bucket.transferOpen'),
      );
    });

    test('the split share hands over to the fallback bucket', () async {
      final salary = await w.canvasSetup();
      final before = ok(await w.profiles.get(salary.splitProfileId));
      final longId = w.bucketOf(BucketKind.longTerm);
      final longBefore = before.allocations
          .firstWhere((a) => a.bucketId == longId)
          .bp
          .value;
      final laptopBp = before.allocations
          .firstWhere((a) => a.bucketId == 'laptop')
          .bp
          .value;
      ok(await archiveUseCase()(bucketId: 'laptop'));
      final after = ok(await w.profiles.get(salary.splitProfileId));
      expect(after.allocations.any((a) => a.bucketId == 'laptop'), isFalse);
      expect(
        after.allocations.firstWhere((a) => a.bucketId == longId).bp.value,
        longBefore + laptopBp,
      );
    });
  });
}
