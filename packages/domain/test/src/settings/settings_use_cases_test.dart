import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes.dart';
import '../../helpers.dart';

/// Records the cutoff passed to [clearRawTextBefore]; other methods are
/// unused here.
class RecordingAlertRepository implements AlertRepository {
  DateTime? cutoff;

  @override
  Future<Result<void>> clearRawTextBefore(DateTime cutoff) async {
    this.cutoff = cutoff;
    return const Ok(null);
  }

  @override
  Future<Result<PaymentAlert>> get(String id) => throw UnimplementedError();

  @override
  Future<Result<void>> save(PaymentAlert alert) => throw UnimplementedError();

  @override
  Future<Result<PaymentAlert?>> findByReference(
    AlertSource source,
    String reference,
  ) => throw UnimplementedError();

  @override
  Future<Result<List<PaymentAlert>>> getReceivedIn(DateWindow window) =>
      throw UnimplementedError();

  @override
  Stream<List<PaymentAlert>> watchByStatus(AlertStatus status) =>
      throw UnimplementedError();
}

void main() {
  late InMemorySettingsRepository settings;
  setUp(() => settings = InMemorySettingsRepository());

  test('WatchSettings streams the current settings', () async {
    final first = await WatchSettings(settings)().first;
    expect(first, Settings.defaults);
  });

  test('SetLockTimeout saves the choice (R-SEC-2)', () async {
    final updated = ok(await SetLockTimeout(settings)(LockTimeout.fiveMinutes));
    expect(updated.lockTimeout, LockTimeout.fiveMinutes);
    expect(ok(await settings.get()).lockTimeout, LockTimeout.fiveMinutes);
  });

  test('SetHideAmounts toggles the flag (R-SEC-4)', () async {
    expect(
      ok(await SetHideAmounts(settings)(hidden: true)).hideAmounts,
      isTrue,
    );
    expect(
      ok(await SetHideAmounts(settings)(hidden: false)).hideAmounts,
      isFalse,
    );
  });

  test('SetBillReminders toggles the flag', () async {
    expect(
      ok(await SetBillReminders(settings)(enabled: false)).billReminders,
      isFalse,
    );
  });

  test('ClearAlertHistory clears raw text up to now (R-PRIV-3)', () async {
    final alerts = RecordingAlertRepository();
    final clock = FakeClock(utc);
    ok(await ClearAlertHistory(alerts, clock)());
    expect(alerts.cutoff, utc);
  });
}
