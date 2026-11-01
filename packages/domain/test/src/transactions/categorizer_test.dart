import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  test('R-SPEND-3 the merchant key comes from the counterparty', () {
    expect(
      Categorizer.merchantKeyOf(
        ParsedMessage(confidence: 1, counterparty: 'SHOPRITE #0423 Cairo Rd'),
      ),
      ok(MerchantKey.create('shoprite cairo rd')),
    );
    expect(Categorizer.merchantKeyOf(ParsedMessage.unparsed), isNull);
    expect(
      Categorizer.merchantKeyOf(
        ParsedMessage(confidence: 1, counterparty: '0977'),
      ),
      isNull,
    );
  });

  test('R-SPEND-3 "always file" creates a rule on the normalized key', () {
    final rule = ok(
      Categorizer.newRule(
        id: 'r',
        counterparty: 'ZESCO Ltd 01',
        category: Category.bill,
        bucketId: 'living',
      ),
    );
    expect(rule.merchantKey.value, 'zesco ltd');
    expect(rule.category, Category.bill);
    expect(
      Categorizer.newRule(
        id: 'r',
        counterparty: '123',
        category: Category.bill,
        bucketId: 'living',
      ),
      isErr('merchantKey.empty'),
    );
  });

  group('R-SPEND-3 suggestion', () {
    final rule = MerchantRule(
      id: 'r',
      merchantKey: ok(MerchantKey.create('zesco')),
      category: Category.bill,
      bucketId: 'living',
    );

    test('a matching rule pre-fills but still shows the sort sheet', () {
      final s = Categorizer.suggest(rule, autoFile: false);
      expect(s.category, Category.bill);
      expect(s.bucketId, 'living');
      expect(s.fileAutomatically, isFalse);
    });

    test('files automatically only when auto-file is on', () {
      expect(
        Categorizer.suggest(rule, autoFile: true).fileAutomatically,
        isTrue,
      );
    });

    test('no rule, no pre-fill', () {
      final s = Categorizer.suggest(null, autoFile: true);
      expect(s.category, isNull);
      expect(s.bucketId, isNull);
      expect(s.fileAutomatically, isFalse);
      expect(s, Categorizer.suggest(null, autoFile: false));
    });
  });
}
