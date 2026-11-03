import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/platform/local_auth_app_lock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';

class FakeBiometricApi implements BiometricApi {
  bool available = true;
  bool unlocks = true;
  LocalAuthExceptionCode? throws;
  String? lastReason;

  @override
  Future<bool> canAuthenticate() async {
    if (throws case final code?) throw LocalAuthException(code: code);
    return available;
  }

  @override
  Future<bool> authenticate(String reason) async {
    lastReason = reason;
    if (throws case final code?) throw LocalAuthException(code: code);
    return unlocks;
  }
}

bool? valueOf(Result<bool> r) => switch (r) {
  Ok(:final value) => value,
  Err() => null,
};

Matcher isErr(String code) =>
    isA<Err<bool>>().having((e) => e.failure.code, 'code', code);

void main() {
  late FakeBiometricApi api;
  late LocalAuthAppLock lock;
  setUp(() {
    api = FakeBiometricApi();
    lock = LocalAuthAppLock(reason: 'Unlock Buckets', api: api);
  });

  test('available when the device has biometrics or a screen lock', () async {
    expect(valueOf(await lock.isAvailable()), isTrue);
    api.available = false;
    expect(valueOf(await lock.isAvailable()), isFalse);
    api.throws = LocalAuthExceptionCode.uiUnavailable;
    expect(valueOf(await lock.isAvailable()), isFalse);
  });

  test('unlocks with the app-supplied reason', () async {
    expect(valueOf(await lock.authenticate()), isTrue);
    expect(api.lastReason, 'Unlock Buckets');
    api.unlocks = false;
    expect(valueOf(await lock.authenticate()), isFalse);
  });

  test('cancelling is "not unlocked", not an error', () async {
    for (final code in [
      LocalAuthExceptionCode.userCanceled,
      LocalAuthExceptionCode.systemCanceled,
    ]) {
      api.throws = code;
      expect(valueOf(await lock.authenticate()), isFalse);
    }
  });

  test('platform errors become safe PlatformFailures', () async {
    final cases = {
      LocalAuthExceptionCode.temporaryLockout: 'appLock.lockedOut',
      LocalAuthExceptionCode.biometricLockout: 'appLock.lockedOut',
      LocalAuthExceptionCode.noCredentialsSet: 'appLock.unavailable',
      LocalAuthExceptionCode.noBiometricHardware: 'appLock.unavailable',
      LocalAuthExceptionCode.timeout: 'appLock.failed',
    };
    for (final MapEntry(key: code, value: failure) in cases.entries) {
      api.throws = code;
      expect(await lock.authenticate(), isErr(failure), reason: '$code');
    }
  });
}
