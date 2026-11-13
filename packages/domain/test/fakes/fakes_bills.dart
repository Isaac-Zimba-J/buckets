import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

import 'fakes.dart';

/// In-memory [BillOccurrenceRepository].
class InMemoryBillOccurrenceRepository implements BillOccurrenceRepository {
  final store = MemoryStore<BillOccurrence>((o) => o.id);

  List<BillOccurrence> _sorted() => store.items.values.toList()
    ..sort((a, b) {
      final c = a.cycleStart.compareTo(b.cycleStart);
      return c != 0 ? c : a.dueDate.compareTo(b.dueDate);
    });

  @override
  Future<Result<List<BillOccurrence>>> getAll() => store.run(_sorted);

  @override
  Future<Result<List<BillOccurrence>>> getForCycle(LocalDate cycleStart) =>
      store.run(
        () => _sorted().where((o) => o.cycleStart == cycleStart).toList(),
      );

  @override
  Future<Result<List<BillOccurrence>>> getForBill(String billId) =>
      store.run(() => _sorted().where((o) => o.billId == billId).toList());

  @override
  Future<Result<void>> save(BillOccurrence occurrence) =>
      store.run(() => store.put(occurrence));

  @override
  Stream<List<BillOccurrence>> watchAll() => store.watch(_sorted);
}

/// In-memory [FeeTariffRepository].
class InMemoryFeeTariffRepository implements FeeTariffRepository {
  final store = MemoryStore<FeeTariff>(
    (t) => '${t.provider.name}/${t.feeType.name}',
  );

  @override
  Future<Result<List<FeeTariff>>> getAll() =>
      store.run(() => store.items.values.toList());

  @override
  Future<Result<FeeTariff?>> find(AlertSource provider, FeeType feeType) =>
      store.run(() => store.items['${provider.name}/${feeType.name}']);

  @override
  Future<Result<void>> save(FeeTariff tariff) =>
      store.run(() => store.put(tariff));

  @override
  Stream<List<FeeTariff>> watchAll() =>
      store.watch(() => store.items.values.toList());
}
