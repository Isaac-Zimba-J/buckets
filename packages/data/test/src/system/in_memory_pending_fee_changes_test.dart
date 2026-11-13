import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('add replaces per band; remove clears; the stream follows', () async {
    final store = InMemoryPendingFeeChanges();
    final band = (FeeBand.create(
      minAmount: const Money.kwacha(1),
      maxAmount: const Money.kwacha(100),
      fee: const Money.kwacha(2),
      source: FeeBandSource.user,
    ) as Ok<FeeBand>).value;
    PendingFeeChange change(int fee) => PendingFeeChange(
      AlertSource.mtnMomo,
      FeeType.send,
      FeeChange(band, Money.kwacha(fee)),
    );
    final seen = <int>[];
    final sub = store.watchAll().listen((l) => seen.add(l.length));
    await store.add(change(3));
    await store.add(change(4));
    await store.remove(
      provider: AlertSource.mtnMomo,
      feeType: FeeType.send,
      min: const Money.kwacha(1),
    );
    await pumpEventQueue();
    await sub.cancel();
    expect(seen, [0, 1, 1, 0]);
  });
}
