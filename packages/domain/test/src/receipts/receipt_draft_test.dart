import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

void main() {
  test('every field carries a confidence', () {
    final draft = ReceiptDraft(
      merchant: Scored('[MERCHANT NAME]', 0.9),
      total: Scored(const Money(41250), 0.7),
      items: [ReceiptItem('Bread', const Money(2500), 0.95)],
    );
    expect(draft.merchant!.value, '[MERCHANT NAME]');
    expect(draft.total!.confidence, 0.7);
    expect(draft.date, isNull);
    expect(draft.items.single.name, 'Bread');
    expect(
      draft,
      ReceiptDraft(
        merchant: Scored('[MERCHANT NAME]', 0.9),
        total: Scored(const Money(41250), 0.7),
        items: [ReceiptItem('Bread', const Money(2500), 0.95)],
      ),
    );
  });

  test('confidence is between 0 and 1', () {
    expect(() => Scored('x', 2), throwsRangeError);
    expect(() => ReceiptItem('x', Money.zero, -1), throwsRangeError);
  });
}
