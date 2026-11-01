import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Account account(String id, {bool spending = false, AccountKind? kind}) => ok(
  Account.create(
    id: id,
    name: 'Account $id',
    kind: kind ?? AccountKind.bank,
    isSpending: spending,
  ),
);

void main() {
  group('Account', () {
    test('trims the name and keeps match keys', () {
      final key = ok(MatchKey.create('4521'));
      final a = ok(
        Account.create(
          id: 'a',
          name: '  Zanaco  ',
          kind: AccountKind.bank,
          matchKeys: [key],
        ),
      );
      expect(a.name, 'Zanaco');
      expect(a.matchKeys, [key]);
      expect(a.isSpending, isFalse);
    });

    test('rejects a blank name', () {
      expect(
        Account.create(id: 'a', name: ' ', kind: AccountKind.bank),
        isErr('name.blank'),
      );
    });

    test('R-ACC-2 cash in hand is a cash account', () {
      const cash = Account.cashInHand(id: 'c');
      expect(cash.kind, AccountKind.cash);
      expect(cash.name, 'Cash in hand');
      expect(cash, const Account.cashInHand(id: 'c'));
    });
  });

  group('MatchKey', () {
    test('R-ACC-3 is compared case-insensitively after collapsing spaces', () {
      final key = ok(MatchKey.create('  Chanda   MWILA '));
      expect(key.value, 'chanda mwila');
      expect(key.isFoundIn('Sent to CHANDA  Mwila on 30/10'), isTrue);
      expect(key.isFoundIn('Sent to Chanda Banda'), isFalse);
    });

    test('R-ACC-3 needs at least 3 characters', () {
      expect(MatchKey.create('  ab  '), isErr('matchKey.tooShort'));
      expect(MatchKey.create('a b'), isA<Ok<MatchKey>>());
    });
  });

  group('AccountRules', () {
    const cash = Account.cashInHand(id: 'cash');

    test('R-ACC-1 exactly one spending account', () {
      final valid = [account('a', spending: true), account('b'), cash];
      expect(ok(AccountRules.validate(valid)), valid);
      expect(
        AccountRules.validate([account('a'), cash]),
        isErr('accounts.noSpending'),
      );
      expect(
        AccountRules.validate([
          account('a', spending: true),
          account('b', spending: true),
          cash,
        ]),
        isErr('accounts.manySpending'),
      );
    });

    test('R-ACC-2 a cash account always exists', () {
      expect(
        AccountRules.validate([account('a', spending: true)]),
        isErr('accounts.noCash'),
      );
    });
  });
}
