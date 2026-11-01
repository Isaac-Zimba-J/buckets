import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';

/// Stores income sources.
abstract interface class IncomeRepository {
  /// Every income source.
  Future<Result<List<IncomeSource>>> getAll();

  /// The income source with [id], or `NotFoundFailure`.
  Future<Result<IncomeSource>> get(String id);

  /// Inserts or replaces [source].
  Future<Result<void>> save(IncomeSource source);
}
