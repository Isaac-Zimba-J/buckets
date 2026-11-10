import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes.dart';
import '../../helpers.dart';

/// An [AppLock] whose answers the test sets.
final class ScriptedAppLock implements AppLock {
  bool available = true;
  bool unlocks = true;
  int asked = 0;

  @override
  Future<Result<bool>> isAvailable() async => Ok(available);

  @override
  Future<Result<bool>> authenticate() async {
    asked++;
    return Ok(unlocks);
  }
}

void main() {
  late InMemorySettingsRepository settings;
  late ScriptedAppLock lock;
  setUp(() {
    settings = InMemorySettingsRepository();
    lock = ScriptedAppLock();
  });

  group('SetAppLock', () {
    test('turning on asks to unlock first, then saves', () async {
      expect(
        ok(await SetAppLock(settings, lock)(enabled: true)).appLock,
        isTrue,
      );
      expect(lock.asked, 1);
      expect(ok(await settings.get()).appLock, isTrue);
    });

    test('no screen lock on the phone: not turned on', () async {
      lock.available = false;
      expect(
        await SetAppLock(settings, lock)(enabled: true),
        isErr('appLock.unavailable'),
      );
      expect(lock.asked, 0);
      expect(ok(await settings.get()).appLock, isFalse);
    });

    test('unlock cancelled: nothing changes, either way', () async {
      ok(await SetAppLock(settings, lock)(enabled: true));
      lock.unlocks = false;
      expect(
        await SetAppLock(settings, lock)(enabled: false),
        isErr('appLock.cancelled'),
      );
      expect(ok(await settings.get()).appLock, isTrue);
    });

    test('turning off also asks to unlock', () async {
      ok(await SetAppLock(settings, lock)(enabled: true));
      expect(
        ok(await SetAppLock(settings, lock)(enabled: false)).appLock,
        isFalse,
      );
      expect(lock.asked, 2);
    });
  });

  test('UnlockApp asks the lock', () async {
    expect(ok(await UnlockApp(lock)()), isTrue);
    lock.unlocks = false;
    expect(ok(await UnlockApp(lock)()), isFalse);
    expect(lock.asked, 2);
  });

  group('SavePlanningPreferences', () {
    test('cooling-off hours, threshold and auto-file are saved', () async {
      final save = SavePlanningPreferences(settings);
      final s = ok(
        await save(
          coolingOffHours: 72,
          coolingOffThreshold: const Money.kwacha(300),
          autoFile: true,
        ),
      );
      expect(s.coolingOffHours, 72);
      expect(s.coolingOffThreshold, const Money.kwacha(300));
      expect(s.autoFile, isTrue);
      expect(ok(await settings.get()).coolingOffHours, 72);
    });

    test('values outside the rules are refused (R-PLAN-1, R-PLAN-2)', () async {
      final save = SavePlanningPreferences(settings);
      expect(
        await save(coolingOffHours: 30),
        isErr('coolingOffHours.notAllowed'),
      );
      expect(
        await save(coolingOffThreshold: Money.zero),
        isErr('coolingOffThreshold.notPositive'),
      );
      expect(ok(await settings.get()).coolingOffHours, 48);
    });
  });

  group('AppLockPolicy.shouldLock', () {
    final now = DateTime.utc(2026, 10, 25, 8);
    test('off: never', () {
      expect(
        AppLockPolicy.shouldLock(
          enabled: false,
          backgroundedAt: null,
          now: now,
        ),
        isFalse,
      );
    });

    test('on: at launch, and on resume after a minute or more', () {
      expect(
        AppLockPolicy.shouldLock(enabled: true, backgroundedAt: null, now: now),
        isTrue,
      );
      for (final (seconds, lock) in [(59, false), (60, true), (600, true)]) {
        expect(
          AppLockPolicy.shouldLock(
            enabled: true,
            backgroundedAt: now.subtract(Duration(seconds: seconds)),
            now: now,
          ),
          lock,
          reason: '$seconds s away',
        );
      }
    });

    test('timeout is configurable (R-SEC-2, D-16b)', () {
      bool lockedAfter(int seconds, LockTimeout timeout) =>
          AppLockPolicy.shouldLock(
            enabled: true,
            backgroundedAt: now.subtract(Duration(seconds: seconds)),
            now: now,
            timeout: timeout,
          );

      // immediately: locks on any time away, even zero.
      expect(lockedAfter(0, LockTimeout.immediately), isTrue);
      expect(lockedAfter(1, LockTimeout.immediately), isTrue);

      // one minute (the default): the 60 s boundary.
      expect(lockedAfter(59, LockTimeout.oneMinute), isFalse);
      expect(lockedAfter(60, LockTimeout.oneMinute), isTrue);

      // five minutes: the 300 s boundary.
      expect(lockedAfter(299, LockTimeout.fiveMinutes), isFalse);
      expect(lockedAfter(300, LockTimeout.fiveMinutes), isTrue);

      // still never when the lock is off, whatever the timeout.
      expect(
        AppLockPolicy.shouldLock(
          enabled: false,
          backgroundedAt: now.subtract(const Duration(minutes: 10)),
          now: now,
          timeout: LockTimeout.immediately,
        ),
        isFalse,
      );
    });
  });
}
