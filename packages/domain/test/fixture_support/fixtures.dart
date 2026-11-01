import 'dart:convert';
import 'dart:io';

import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

/// One redacted message and what it must parse to (DOMAIN R-PARSE-1).
class SmsFixture {
  SmsFixture(this.name, this.text, this.expected);

  final String name;
  final String text;
  final Map<String, Object?> expected;
}

/// Loads `test/fixtures/sms/<provider>/<case>.txt` with its sibling
/// `<case>.expected.json`.
List<SmsFixture> loadSmsFixtures(String provider) {
  final dir = Directory('test/fixtures/sms/$provider');
  if (!dir.existsSync()) return [];
  final texts =
      dir
          .listSync()
          .whereType<File>()
          .where(
            (f) => f.path.endsWith('.txt'),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  return [
    for (final txt in texts)
      SmsFixture(
        txt.uri.pathSegments.last.replaceAll('.txt', ''),
        txt.readAsStringSync(),
        jsonDecode(
              File(
                txt.path.replaceAll('.txt', '.expected.json'),
              ).readAsStringSync(),
            )
            as Map<String, Object?>,
      ),
  ];
}

/// The parsed fields in the `.expected.json` shape: amounts in ngwee,
/// `occurredAt` as ISO-8601 UTC, `direction` as `out` / `in`.
Map<String, Object?> asExpectedJson(ParsedMessage p) => {
  'direction': switch (p.direction) {
    MessageDirection.outgoing => 'out',
    MessageDirection.incoming => 'in',
    null => null,
  },
  'amount': p.amount?.ngwee,
  'fee': p.fee?.ngwee,
  'counterparty': p.counterparty,
  'reference': p.reference,
  'occurredAt': p.occurredAt?.toIso8601String(),
  'balanceAfter': p.balanceAfter?.ngwee,
};

/// Every fixture of [provider] parses to its expected JSON with [parser].
/// Skipped while the provider has no fixtures (AGENTS.md §5).
void smsFixtureSuite(String provider, SmsParser parser) {
  final fixtures = loadSmsFixtures(provider);
  if (fixtures.isEmpty) {
    test('$provider fixtures parse', () {}, skip: 'needs fixtures');
    return;
  }
  for (final f in fixtures) {
    test('$provider/${f.name} parses', () {
      final parsed = parser.parse(f.text, utcOffset: const Duration(hours: 2));
      expect(asExpectedJson(parsed), f.expected);
    });
  }
}
