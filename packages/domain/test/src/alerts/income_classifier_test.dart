import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

ParsedMessage incoming(int kwacha, [String? from]) => ParsedMessage(
  confidence: 1,
  direction: MessageDirection.incoming,
  amount: Money.kwacha(kwacha),
  counterparty: from,
);

void main() {
  final payer = [ok(MatchKey.create('[EMPLOYER]'))];
  IncomeSuggestion suggest(ParsedMessage p) => IncomeClassifier.suggest(
    p,
    salaryPayerKeys: payer,
    expectedSalary: const Money.kwacha(12000),
  );

  test('R-PARSE-5 salary when the payer matches', () {
    expect(
      suggest(incoming(500, 'From [employer] Ltd')),
      IncomeSuggestion.salaryLanded,
    );
  });

  test('R-PARSE-5 salary when within ±10% of expected, inclusive', () {
    expect(suggest(incoming(10800)), IncomeSuggestion.salaryLanded);
    expect(suggest(incoming(13200)), IncomeSuggestion.salaryLanded);
    expect(
      suggest(incoming(12000, '[SOMEONE]')),
      IncomeSuggestion.salaryLanded,
    );
  });

  test('R-PARSE-5 otherwise side hustle', () {
    expect(suggest(incoming(10799)), IncomeSuggestion.sideHustle);
    expect(suggest(incoming(13201, '[CUSTOMER]')), IncomeSuggestion.sideHustle);
    expect(
      IncomeClassifier.suggest(
        incoming(12000),
        salaryPayerKeys: const [],
        expectedSalary: null,
      ),
      IncomeSuggestion.sideHustle,
    );
  });

  test('outgoing or unknown direction is not income', () {
    expect(
      suggest(
        ParsedMessage(confidence: 1, direction: MessageDirection.outgoing),
      ),
      IncomeSuggestion.notIncome,
    );
    expect(suggest(ParsedMessage.unparsed), IncomeSuggestion.notIncome);
  });
}
