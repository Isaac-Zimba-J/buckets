import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/payday/entities/held_income.dart';

/// Side-hustle money waiting for the month-end split (R-PAY-6).
abstract interface class HeldIncomeRepository {
  /// Everything held for [incomeSourceId], oldest first.
  Future<Result<List<HeldIncome>>> getFor(String incomeSourceId);

  /// Adds [held].
  Future<Result<void>> add(HeldIncome held);

  /// Removes the held amounts with [ids], once split.
  Future<Result<void>> remove(List<String> ids);
}
