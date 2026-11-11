import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/profile/entities/profile.dart';

/// Stores the local profile (R-PROFILE-1). Returns `null` until the user
/// has been through "About you" (SCREENS 01b).
abstract interface class ProfileRepository {
  /// The saved profile, or `null` if none.
  Future<Result<Profile?>> get();

  /// Inserts or replaces the profile.
  Future<Result<void>> save(Profile profile);

  /// The profile, emitting again on change; `null` until first saved.
  Stream<Profile?> watch();
}
