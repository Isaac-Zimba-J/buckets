import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_activity.dart';
import '../../helpers.dart';

MerchantRule rule(String id, String merchant) => MerchantRule(
  id: id,
  merchantKey: ok(MerchantKey.create(merchant)),
  category: Category.food,
  bucketId: 'living',
);

void main() {
  late InMemoryMerchantRuleRepository rules;
  setUp(() => rules = InMemoryMerchantRuleRepository());

  test('WatchMerchantRules emits the saved rules, sorted', () async {
    ok(await rules.save(rule('r1', 'Shoprite')));
    ok(await rules.save(rule('r2', 'Melissa')));
    final list = await WatchMerchantRules(rules)().first;
    expect(list.map((r) => r.id), ['r2', 'r1']); // melissa < shoprite
  });

  test('DeleteMerchantRule removes one', () async {
    ok(await rules.save(rule('r1', 'Shoprite')));
    ok(await rules.save(rule('r2', 'Melissa')));
    ok(await DeleteMerchantRule(rules)('r1'));
    expect(ok(await rules.getAll()).map((r) => r.id), ['r2']);
  });
}
