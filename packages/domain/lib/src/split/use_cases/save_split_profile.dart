import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:buckets_domain/src/split/ports/split_profile_repository.dart';
import 'package:buckets_domain/src/split/value_objects/allocation.dart';

/// Saves a split (screen 04). Only future paydays use it (R-SPLIT-6).
final class SaveSplitProfile {
  /// Creates the use case.
  const SaveSplitProfile(this._profiles);

  final SplitProfileRepository _profiles;

  /// The saved profile; fails unless it adds up to 100% (R-SPLIT-1).
  Future<Result<SplitProfile>> call({
    required String id,
    required List<Allocation> allocations,
    bool holdUntilMonthEnd = false,
  }) => attempt(() async {
    final profile = unwrap(
      SplitProfile.create(
        id: id,
        allocations: allocations,
        holdUntilMonthEnd: holdUntilMonthEnd,
      ),
    );
    unwrap(await _profiles.save(profile));
    return profile;
  });
}
