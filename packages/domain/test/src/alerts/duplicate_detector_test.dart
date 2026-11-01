import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

PaymentAlert alert(
  String id, {
  AlertSource source = AlertSource.mtnMomo,
  String? reference,
  Money? amount = const Money(18500),
  String? counterparty = '[MERCHANT]',
  DateTime? at,
}) => ok(
  PaymentAlert.create(
    id: id,
    rawText: null,
    source: source,
    receivedAt: utc,
    parsed: ParsedMessage(
      confidence: 1,
      reference: reference,
      amount: amount,
      counterparty: counterparty,
      occurredAt: at ?? utc,
    ),
  ),
);

void main() {
  group('R-PARSE-4 with a reference', () {
    test('same provider and reference is a duplicate', () {
      final a = alert('a', reference: 'ZX98');
      expect(
        DuplicateDetector.findDuplicate(alert('b', reference: 'ZX98'), [a]),
        a,
      );
    });

    test('a different provider or reference is not', () {
      final a = alert('a', reference: 'ZX98');
      expect(
        DuplicateDetector.findDuplicate(
          alert('b', reference: 'ZX98', source: AlertSource.airtelMoney),
          [a],
        ),
        isNull,
      );
      expect(
        DuplicateDetector.findDuplicate(alert('b', reference: 'QQ11'), [a]),
        isNull,
      );
    });

    test('an alert is never its own duplicate', () {
      final a = alert('a', reference: 'ZX98');
      expect(DuplicateDetector.findDuplicate(a, [a]), isNull);
    });
  });

  group('R-PARSE-4 without a reference', () {
    final base = alert('a');

    test('same amount and counterparty within 2 minutes', () {
      for (final offset in [
        Duration.zero,
        const Duration(minutes: 2),
        const Duration(minutes: -2),
      ]) {
        expect(
          DuplicateDetector.findDuplicate(alert('b', at: utc.add(offset)), [
            base,
          ]),
          base,
          reason: '$offset',
        );
      }
    });

    test('counterparty is compared ignoring case and spacing', () {
      expect(
        DuplicateDetector.findDuplicate(
          alert('b', counterparty: '  [merchant] '),
          [base],
        ),
        base,
      );
    });

    test('more than 2 minutes, another amount or counterparty is not', () {
      for (final other in [
        alert('b', at: utc.add(const Duration(minutes: 2, seconds: 1))),
        alert('b', amount: const Money(18600)),
        alert('b', counterparty: '[OTHER]'),
      ]) {
        expect(DuplicateDetector.findDuplicate(other, [base]), isNull);
      }
    });

    test('missing fields are never matched', () {
      expect(
        DuplicateDetector.findDuplicate(alert('b', amount: null), [
          alert('a', amount: null),
        ]),
        isNull,
      );
      expect(
        DuplicateDetector.findDuplicate(
          ok(
            PaymentAlert.create(
              id: 'b',
              rawText: null,
              source: AlertSource.unknown,
              receivedAt: utc,
              parsed: ParsedMessage.unparsed,
            ),
          ),
          [base],
        ),
        isNull,
      );
    });
  });
}
