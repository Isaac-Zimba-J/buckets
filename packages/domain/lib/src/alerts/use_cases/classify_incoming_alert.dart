import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/policies/income_classifier.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// "Salary landed" or "Side hustle money?" for an alert (R-PARSE-5).
final class ClassifyIncomingAlert {
  /// Creates the use case.
  const ClassifyIncomingAlert(this._alerts, this._incomes);

  final AlertRepository _alerts;
  final IncomeRepository _incomes;

  /// The suggestion for [alertId], using the first salary's payer and
  /// expected amount.
  Future<Result<IncomeSuggestion>> call(String alertId) => attempt(() async {
    final alert = unwrap(await _alerts.get(alertId));
    final salary = unwrap(
      await _incomes.getAll(),
    ).where((i) => i.kind == IncomeKind.salary).firstOrNull;
    return IncomeClassifier.suggest(
      alert.parsed,
      salaryPayerKeys: salary?.payerKeys ?? const [],
      expectedSalary: salary?.expectedAmount,
    );
  });
}
