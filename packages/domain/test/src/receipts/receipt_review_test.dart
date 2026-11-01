import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

ReceiptDraft draft({
  double totalConfidence = 0.95,
  int? total = 41250,
  List<int> items = const [25000, 16250],
}) => ReceiptDraft(
  total: total == null ? null : Scored(Money(total), totalConfidence),
  items: [for (final ngwee in items) ReceiptItem('item', Money(ngwee), 0.9)],
);

void main() {
  group('R-RECEIPT-2 review', () {
    test('items that sum to the total exactly are confident', () {
      final r = ReceiptReview.of(draft());
      expect(r.totalNeedsCheck, isFalse);
      expect(r.itemsMatchTotal, isTrue);
      expect(r.itemsTotal, const Money(41250));
      expect(r.difference, Money.zero);
    });

    test('total confidence below 0.8 asks to check the total', () {
      expect(
        ReceiptReview.of(draft(totalConfidence: 0.79)).totalNeedsCheck,
        isTrue,
      );
      expect(
        ReceiptReview.of(draft(totalConfidence: 0.8)).totalNeedsCheck,
        isFalse,
      );
    });

    test('items more than K 1 off the total ask to check it', () {
      expect(
        ReceiptReview.of(draft(items: [25000, 16149])).totalNeedsCheck,
        isTrue,
      ); // K 1.01 short
      expect(
        ReceiptReview.of(draft(items: [25000, 16350])).totalNeedsCheck,
        isFalse,
      ); // exactly K 1 over
      final within = ReceiptReview.of(draft(items: [25000, 16200]));
      expect(within.totalNeedsCheck, isFalse);
      expect(within.itemsMatchTotal, isFalse);
      expect(within.difference, const Money(-50));
    });

    test('no items: only confidence decides; no "adds up" message', () {
      final r = ReceiptReview.of(draft(items: const []));
      expect(r.totalNeedsCheck, isFalse);
      expect(r.itemsMatchTotal, isFalse);
    });

    test('a missing total always needs checking', () {
      final r = ReceiptReview.of(draft(total: null));
      expect(r.totalNeedsCheck, isTrue);
      expect(r.itemsMatchTotal, isFalse);
      expect(r.difference, isNull);
    });
  });
}
