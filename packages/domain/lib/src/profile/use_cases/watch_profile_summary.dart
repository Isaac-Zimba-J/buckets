import 'package:buckets_domain/src/profile/ports/profile_repository.dart';
import 'package:buckets_domain/src/profile/value_objects/profile_summary.dart';

/// Streams the Me-tab profile summary (SCREENS 24): the name, greeting and
/// avatar letter. It re-emits whenever the profile changes.
final class WatchProfileSummary {
  /// Creates the use case.
  const new(this._profiles);

  final ProfileRepository _profiles;

  /// Emits a fresh summary on every profile change.
  Stream<ProfileSummary> call() => _profiles.watch().map(ProfileSummary.of);
}
