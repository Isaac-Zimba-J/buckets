import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/profile/entities/profile.dart';
import 'package:buckets_domain/src/profile/ports/profile_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Saves the local profile from "About you" and the Me tab (SCREENS 01b, 24).
/// Keeps the original `createdAt` on later edits.
final class SaveProfile {
  /// Creates the use case.
  const new(this._profiles);

  final ProfileRepository _profiles;

  /// Validates and saves the profile, returning it. Pass an empty
  /// [displayName] to clear the name (R-PROFILE-2).
  Future<Result<Profile>> call({
    required DateTime now,
    String? displayName,
    Greeting greeting = Greeting.muliShani,
    String? timeZone,
  }) => attempt(() async {
    final existing = unwrap(await _profiles.get());
    final profile = unwrap(
      Profile.create(
        createdAt: existing?.createdAt ?? now,
        displayName: displayName,
        greeting: greeting,
        timeZone: timeZone ?? existing?.timeZone ?? 'Africa/Lusaka',
      ),
    );
    unwrap(await _profiles.save(profile));
    return profile;
  });
}
