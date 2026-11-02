import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';

/// Every income source (screen 02, Me tab).
final class ListIncomeSources {
  /// Creates the use case.
  const ListIncomeSources(this._incomes);

  final IncomeRepository _incomes;

  /// The sources.
  Future<Result<List<IncomeSource>>> call() => _incomes.getAll();
}
