import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/checkin/entities/check_in.dart';

/// Stores weekly cash counts.
abstract interface class CheckInRepository {
  /// The most recent check-in, or null before the first.
  Future<Result<CheckIn?>> latest();

  /// Inserts or replaces [checkIn].
  Future<Result<void>> save(CheckIn checkIn);
}
