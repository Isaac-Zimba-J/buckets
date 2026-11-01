import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

const lusaka = Duration(hours: 2);

// Synthetic formats for testing the engine only. Real provider templates are
// written from redacted fixtures (AGENTS.md §5, DOMAIN R-PARSE-1).
DateTime? testDate(String raw, Duration utcOffset) {
  final m = RegExp(
    r'^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})$',
  ).firstMatch(raw);
  if (m == null) return null;
  final [y, mo, d, h, mi] = [for (var i = 1; i <= 5; i++) int.parse(m[i]!)];
  final wall = DateTime.utc(y, mo, d, h, mi);
  // DateTime rolls impossible dates over; reject them instead.
  if (wall.month != mo ||
      wall.day != d ||
      wall.hour != h ||
      wall.minute != mi) {
    return null;
  }
  return wall.subtract(utcOffset);
}

final paid = MessageTemplate(
  source: AlertSource.unknown,
  name: 'test-paid',
  direction: MessageDirection.outgoing,
  pattern: RegExp(
    r'^TEST PAID K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
    r'FEE K(?<fee>[\d,.]+) REF (?<reference>\w+) AT (?<date>[\d\- :]+)'
    r'(?: BAL K(?<balance>[\d,.]+))?$',
  ),
  parseDate: testDate,
);

final received = MessageTemplate(
  source: AlertSource.bank,
  name: 'test-received',
  direction: MessageDirection.incoming,
  pattern: RegExp(r'^TEST GOT K(?<amount>[\d,.]+) FROM (?<counterparty>.+)$'),
);

void main() {
  final parser = SmsParser([paid, received]);

  group('R-PARSE-3 amounts', () {
    test('decimal strings become ngwee without floating point', () {
      expect(SmsParser.parseAmount('1,540.00'), const Money(154000));
      expect(SmsParser.parseAmount('412.5'), const Money(41250));
      expect(SmsParser.parseAmount('1540'), const Money(154000));
      expect(SmsParser.parseAmount('0.07'), const Money(7));
      expect(SmsParser.parseAmount('12,345,678.99'), const Money(1234567899));
    });

    test('anything else is null', () {
      for (final bad in ['', '1.234', '1,54.00', 'K10', '1..0', '-5', ',100']) {
        expect(SmsParser.parseAmount(bad), isNull, reason: bad);
      }
    });
  });

  group('template engine', () {
    test('reads every named group of the first matching template', () {
      final p = parser.parse(
        'TEST PAID K185.00 TO [MERCHANT NAME] FEE K2.50 REF ZX98YW76 '
        'AT 2026-10-30 09:15 BAL K1,204.10',
        utcOffset: lusaka,
      );
      expect(p.direction, MessageDirection.outgoing);
      expect(p.amount, const Money(18500));
      expect(p.fee, const Money(250));
      expect(p.counterparty, '[MERCHANT NAME]');
      expect(p.reference, 'ZX98YW76');
      expect(p.occurredAt, DateTime.utc(2026, 10, 30, 7, 15));
      expect(p.balanceAfter, const Money(120410));
      expect(p.confidence, 1);
    });

    test('confidence drops for each declared field that did not parse', () {
      final p = parser.parse(
        'TEST PAID K185.00 TO [NAME] FEE K2.5.0 REF AB12 AT 2026-13-99 99:99',
        utcOffset: lusaka,
      );
      expect(p.amount, const Money(18500));
      expect(p.fee, isNull);
      expect(p.occurredAt, isNull);
      expect(p.balanceAfter, isNull);
      // 7 fields declared, 4 read.
      expect(p.confidence, closeTo(4 / 7, 1e-9));
    });

    test('fields a template does not declare stay null', () {
      final p = parser.parse('TEST GOT K2,000 FROM [NAME]', utcOffset: lusaka);
      expect(p.direction, MessageDirection.incoming);
      expect(p.amount, const Money(200000));
      expect(p.reference, isNull);
      expect(p.confidence, 1);
    });

    test('limits templates to a source when given', () {
      expect(
        parser
            .parse(
              'TEST GOT K2,000 FROM [NAME]',
              utcOffset: lusaka,
              source: AlertSource.mtnMomo,
            )
            .confidence,
        0,
      );
      expect(
        parser
            .parse(
              'TEST GOT K2,000 FROM [NAME]',
              utcOffset: lusaka,
              source: AlertSource.bank,
            )
            .amount,
        const Money(200000),
      );
    });

    test('trims surrounding whitespace before matching', () {
      expect(
        parser.parse('  TEST GOT K5 FROM [NAME]\n', utcOffset: lusaka).amount,
        const Money(500),
      );
    });
  });

  test('R-PARSE-2 a throwing or non-UTC date parser gives a null date', () {
    MessageTemplate dated(DateParser parse) => MessageTemplate(
      source: AlertSource.unknown,
      name: 'dated',
      direction: MessageDirection.outgoing,
      pattern: RegExp(r'^D (?<date>.+)$'),
      parseDate: parse,
    );
    final cases = <DateParser>[
      (raw, _) => throw const FormatException('bad'),
      (raw, _) => throw RangeError('bad'),
      (raw, _) => DateTime(2026),
    ];
    for (final parse in cases) {
      final p = SmsParser([dated(parse)]).parse('D x', utcOffset: lusaka);
      expect(p.occurredAt, isNull);
      expect(p.confidence, closeTo(1 / 2, 1e-9));
    }
  });

  test('R-PARSE-2 unparseable text returns unparsed, never throws', () {
    for (final text in ['', 'hello', 'TEST PAID nonsense', '\u0000']) {
      expect(
        parser.parse(text, utcOffset: lusaka),
        ParsedMessage.unparsed,
        reason: text,
      );
    }
    expect(
      const SmsParser([]).parse('x', utcOffset: lusaka),
      ParsedMessage.unparsed,
    );
  });
}
