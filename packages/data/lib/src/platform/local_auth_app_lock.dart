import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:local_auth/local_auth.dart';

/// The parts of `local_auth` the app lock uses; a seam for tests.
abstract interface class BiometricApi {
  /// Whether biometrics or a device PIN/pattern can be used.
  Future<bool> canAuthenticate();

  /// Shows the system unlock prompt with [reason].
  Future<bool> authenticate(String reason);
}

/// [BiometricApi] over `local_auth`.
final class LocalAuthBiometricApi implements BiometricApi {
  /// Creates the API.
  new();

  final _auth = LocalAuthentication();

  @override
  Future<bool> canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  @override
  Future<bool> authenticate(String reason) => _auth.authenticate(
    localizedReason: reason,
    // Unlock with PIN or pattern too, not only biometrics.
    persistAcrossBackgrounding: true,
  );
}

/// [AppLock] on the device PIN or biometrics (ARCHITECTURE §8).
final class LocalAuthAppLock implements AppLock {
  /// Creates the lock. [reason] is the line shown in the system prompt;
  /// the app passes it from its strings.
  new({required this.reason, BiometricApi? api})
    : _api = api ?? LocalAuthBiometricApi();

  /// Shown in the system prompt.
  final String reason;

  final BiometricApi _api;

  @override
  Future<Result<bool>> isAvailable() async {
    try {
      return Ok(await _api.canAuthenticate());
    } on LocalAuthException {
      return const Ok(false);
    }
  }

  @override
  Future<Result<bool>> authenticate() async {
    try {
      return Ok(await _api.authenticate(reason));
    } on LocalAuthException catch (e) {
      return switch (e.code) {
        LocalAuthExceptionCode.userCanceled ||
        LocalAuthExceptionCode.systemCanceled => const Ok(false),
        LocalAuthExceptionCode.temporaryLockout ||
        LocalAuthExceptionCode.biometricLockout => const Err(
          PlatformFailure(
            'appLock.lockedOut',
            'Too many tries. Wait a moment, then unlock with your PIN.',
          ),
        ),
        LocalAuthExceptionCode.noCredentialsSet ||
        LocalAuthExceptionCode.noBiometricHardware => const Err(
          PlatformFailure(
            'appLock.unavailable',
            'Set a screen lock on your phone to use the app lock.',
          ),
        ),
        _ => const Err(
          PlatformFailure('appLock.failed', "Couldn't unlock. Try again."),
        ),
      };
    }
  }
}
