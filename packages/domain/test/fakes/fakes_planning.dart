import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

import 'fakes.dart';

/// In-memory [PlanningRepository].
class InMemoryPlanningRepository implements PlanningRepository {
  final planned = MemoryStore<PlannedPurchase>((p) => p.id);
  final wishes = MemoryStore<Wish>((w) => w.id);

  @override
  Future<Result<void>> savePlanned(PlannedPurchase purchase) =>
      planned.run(() => planned.put(purchase));

  @override
  Future<Result<Wish>> getWish(String id) => wishes.get(id);

  @override
  Future<Result<void>> saveWish(Wish wish) =>
      wishes.run(() => wishes.put(wish));

  @override
  Stream<List<PlannedPurchase>> watchPlanned() =>
      planned.watch(() => planned.items.values.toList());

  @override
  Stream<List<Wish>> watchWishes() =>
      wishes.watch(() => wishes.items.values.toList());
}

/// In-memory [CheckInRepository].
class InMemoryCheckInRepository implements CheckInRepository {
  final store = MemoryStore<CheckIn>((c) => c.id);

  @override
  Future<Result<CheckIn?>> latest() => store.run(
    () =>
        (store.items.values.toList()
              ..sort((a, b) => b.countedAt.compareTo(a.countedAt)))
            .firstOrNull,
  );

  @override
  Future<Result<void>> save(CheckIn checkIn) =>
      store.run(() => store.put(checkIn));
}

/// A [NotificationScheduler] that remembers the last schedule.
class FakeNotificationScheduler implements NotificationScheduler {
  List<ScheduledNotification> scheduled = const [];

  @override
  Future<Result<void>> replaceAll(
    List<ScheduledNotification> notifications,
  ) async {
    scheduled = notifications;
    return const Ok(null);
  }

  @override
  Future<Result<void>> cancel(String id) async {
    scheduled = [...scheduled.where((n) => n.id != id)];
    return const Ok(null);
  }
}
