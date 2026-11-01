import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/value_objects/match_key.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';

/// What to suggest for a parsed message (R-PARSE-5).
enum IncomeSuggestion {
  /// "Salary landed".
  salaryLanded,

  /// "Side hustle money?" (screen 17).
  sideHustle,

  /// Not incoming money.
  notIncome,
}

/// Decides whether incoming money looks like salary (R-PARSE-5).
abstract final class IncomeClassifier {
  /// Salary when the counterparty matches [salaryPayerKeys] or the amount
  /// is within ±10% of [expectedSalary] (inclusive); otherwise side hustle.
  static IncomeSuggestion suggest(
    ParsedMessage parsed, {
    required List<MatchKey> salaryPayerKeys,
    required Money? expectedSalary,
  }) {
    if (parsed.direction != MessageDirection.incoming) {
      return IncomeSuggestion.notIncome;
    }
    final from = parsed.counterparty;
    if (from != null && salaryPayerKeys.any((k) => k.isFoundIn(from))) {
      return IncomeSuggestion.salaryLanded;
    }
    final amount = parsed.amount;
    if (amount != null &&
        expectedSalary != null &&
        (amount - expectedSalary).abs().ngwee * 10 <= expectedSalary.ngwee) {
      return IncomeSuggestion.salaryLanded;
    }
    return IncomeSuggestion.sideHustle;
  }
}
