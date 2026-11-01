import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('ParsedMessage', () {
    test('R-PARSE-2 unparsed has null fields and confidence 0', () {
      const p = ParsedMessage.unparsed;
      expect(p.confidence, 0);
      expect(
        [p.direction, p.amount, p.fee, p.counterparty, p.reference],
        everyElement(isNull),
      );
      expect([p.occurredAt, p.balanceAfter], everyElement(isNull));
    });

    test('confidence is between 0 and 1', () {
      expect(
        ParsedMessage(
          direction: MessageDirection.outgoing,
          amount: const Money(154000),
          confidence: 1,
        ).amount,
        const Money(154000),
      );
      expect(() => ParsedMessage(confidence: 1.1), throwsRangeError);
      expect(() => ParsedMessage(confidence: -0.1), throwsRangeError);
    });
  });

  group('PaymentAlert', () {
    test('starts new and keeps the raw text', () {
      final a = ok(
        PaymentAlert.create(
          id: 'al',
          rawText: '[MESSAGE]',
          source: AlertSource.mtnMomo,
          receivedAt: utc,
          parsed: ParsedMessage.unparsed,
        ),
      );
      expect(a.status, AlertStatus.newAlert);
      expect(a.rawText, '[MESSAGE]');
    });

    test('R-TIME-1 receivedAt is UTC', () {
      expect(
        PaymentAlert.create(
          id: 'al',
          rawText: null,
          source: AlertSource.unknown,
          receivedAt: DateTime(2026),
          parsed: ParsedMessage.unparsed,
        ),
        isErr('receivedAt.notUtc'),
      );
    });
  });
}
