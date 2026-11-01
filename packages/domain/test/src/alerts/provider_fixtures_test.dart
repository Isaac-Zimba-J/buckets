import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fixture_support/fixtures.dart';

// Provider templates arrive in D-06a (MTN) and D-06b (Airtel) once redacted
// fixtures exist (DOMAIN §17). Until then each suite is skipped.
void main() {
  group('MTN MoMo', () => smsFixtureSuite('mtn', const SmsParser([])));
  group('Airtel Money', () => smsFixtureSuite('airtel', const SmsParser([])));
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
