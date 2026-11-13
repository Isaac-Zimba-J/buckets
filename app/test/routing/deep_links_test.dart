import 'package:buckets/routing/deep_links.dart';
import 'package:buckets/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final cases = {
    'buckets://payday/p1': '/payday/p1',
    'buckets://alert/a1': '/alert/a1',
    'buckets://checkin': '/checkin',
    'buckets://plan/wish/w1': '/plan?tab=wishes&wish=w1',
    'buckets://plan/bills': '/plan/bills',
    'buckets://plan/bills/b1/pay': '/plan/bills/b1/pay',
    'buckets://bucket/b1': '/bucket/b1',
    'buckets://payday': Routes.home,
    'buckets://nowhere/x': Routes.home,
    'https://payday/p1': Routes.home,
  };
  for (final MapEntry(:key, :value) in cases.entries) {
    test('$key → $value', () {
      expect(locationForDeepLink(Uri.parse(key)), value);
    });
  }

  test('a payload that does not parse opens Home', () {
    expect(locationForPayload('::not a uri'), Routes.home);
  });

  test('setup paths', () {
    expect(Routes.isSetup(Routes.welcome), isTrue);
    expect(Routes.isSetup(Routes.setupSplit('i')), isTrue);
    expect(Routes.isSetup(Routes.meIncome), isFalse);
    expect(Routes.isSetup('/setupx'), isFalse);
  });
}
