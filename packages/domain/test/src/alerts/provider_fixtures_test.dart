import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fixture_support/fixtures.dart';

// Provider templates are added only from redacted owner-provided fixtures
// (DOMAIN §17).
void main() {
  group(
    'MTN MoMo',
    () => smsFixtureSuite('mtn', SmsParser(mtnMessageTemplates)),
  );
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
