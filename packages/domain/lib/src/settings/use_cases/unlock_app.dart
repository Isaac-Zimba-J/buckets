import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/ports/app_lock.dart';

/// Asks the user to unlock the app (PIN or fingerprint).
final class UnlockApp {
  /// Creates the use case.
  const new(this._lock);

  final AppLock _lock;

  /// True when the user unlocked.
  Future<Result<bool>> call() => _lock.authenticate();
}
