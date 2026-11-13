import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fixture_support/fixtures.dart';

void main() {
  final parser = SmsParser(zambiaTemplates());
  group('MTN MoMo', () => smsFixtureSuite('mtn', parser));
  group('Airtel Money', () => smsFixtureSuite('airtel', parser));
  group('Bank', () => smsFixtureSuite('bank', const SmsParser([])));

  test('the expected-JSON shape maps every field', () {
    expect(asExpectedJson(ParsedMessage.unparsed), {
      'direction': null,
      'amount': null,
      'fee': null,
      'counterparty': null,
      'reference': null,
      'occurredAt': null,
      'balanceAfter': null,
    });
  });
}
