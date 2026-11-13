import 'dart:async';

import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_sync.g.dart';

/// Keeps the local notification schedule current (screen 12, DOMAIN §12):
/// runs `ScheduleNotifications` once on start, again whenever paydays,
/// alerts, bills, wishes, the ledger or settings change, and on resume.
/// Bursts of changes (a proof writes the payday and the ledger) are
/// coalesced into one run. No rules here: the policy decides what to show.
final class NotificationSync {
  /// Starts listening to [triggers]; each change runs [_schedule]. Call
  /// [dispose] to stop.
  NotificationSync(this._schedule, {required List<Stream<Object?>> triggers}) {
    _subscriptions = [
      for (final t in triggers) t.listen((_) => refresh(), onError: (_) {}),
    ];
    refresh();
  }

  final Future<void> Function() _schedule;
  late final List<StreamSubscription<Object?>> _subscriptions;
  bool _pending = false;
  bool _disposed = false;

  /// Asks for a run; several asks before it starts make one run.
  void refresh() {
    if (_pending || _disposed) return;
    _pending = true;
    // A timer, not a microtask: stream events land in separate microtasks,
    // so this waits until the whole burst has been delivered.
    Timer.run(() async {
      _pending = false;
      if (!_disposed) await _schedule();
    });
  }

  /// Stops listening.
  Future<void> dispose() async {
    _disposed = true;
    for (final s in _subscriptions) {
      await s.cancel();
    }
  }
}

/// The app's [NotificationSync]; `BucketsApp` keeps it alive.
@Riverpod(keepAlive: true)
NotificationSync notificationSync(Ref ref) {
  final schedule = ref.watch(scheduleNotificationsProvider);
  final ensureOccurrences = ref.watch(ensureBillOccurrencesProvider);
  final sync = NotificationSync(
    () async {
      // A new payday opens a new cycle: its bills need occurrences first.
      await ensureOccurrences();
      await schedule();
    },
    triggers: [
      ref.watch(paydayRepositoryProvider).watchOpen(),
      ref.watch(alertRepositoryProvider).watchByStatus(AlertStatus.newAlert),
      ref.watch(billRepositoryProvider).watchAll(),
      ref.watch(billOccurrenceRepositoryProvider).watchAll(),
      ref.watch(planningRepositoryProvider).watchWishes(),
      ref.watch(ledgerRepositoryProvider).watchEntries(),
      ref.watch(settingsRepositoryProvider).watch(),
    ],
  );
  ref.onDispose(sync.dispose);
  return sync;
}
