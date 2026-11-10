import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Profile.create', () {
    test('defaults: no name, Muli shani, Lusaka', () {
      final p = ok(Profile.create(createdAt: utc));
      expect(p.displayName, isNull);
      expect(p.greeting, Greeting.muliShani);
      expect(p.timeZone, 'Africa/Lusaka');
      expect(p.createdAt, utc);
    });

    test('trims the name and time zone', () {
      final p = ok(
        Profile.create(
          createdAt: utc,
          displayName: '  Isaac  ',
          timeZone: ' Africa/Lusaka ',
        ),
      );
      expect(p.displayName, 'Isaac');
      expect(p.timeZone, 'Africa/Lusaka');
    });

    test('a blank name is stored as null (R-PROFILE-2)', () {
      expect(
        ok(Profile.create(createdAt: utc, displayName: '   ')).displayName,
        isNull,
      );
      expect(
        ok(Profile.create(createdAt: utc, displayName: '')).displayName,
        isNull,
      );
    });

    test('name at the 30-character limit is allowed', () {
      final name = 'a' * 30;
      expect(
        ok(Profile.create(createdAt: utc, displayName: name)).displayName,
        name,
      );
    });

    test('name over 30 characters fails (R-PROFILE-1)', () {
      expect(
        Profile.create(createdAt: utc, displayName: 'a' * 31),
        isErr('displayName.tooLong'),
      );
    });

    test('a blank time zone fails', () {
      expect(
        Profile.create(createdAt: utc, timeZone: '  '),
        isErr('timeZone.blank'),
      );
    });

    test('a non-UTC createdAt fails (R-TIME-1)', () {
      expect(
        Profile.create(createdAt: DateTime(2026, 10, 30)),
        isErr('createdAt.notUtc'),
      );
    });
  });

  group('greetingLine (R-PROFILE-2)', () {
    test('the word alone when there is no name', () {
      expect(ok(Profile.create(createdAt: utc)).greetingLine, 'Muli shani');
      expect(
        ok(Profile.create(createdAt: utc, greeting: Greeting.hello))
            .greetingLine,
        'Hello',
      );
    });

    test('the word with the name when there is one', () {
      expect(
        ok(Profile.create(createdAt: utc, displayName: 'Isaac')).greetingLine,
        'Muli shani, Isaac',
      );
    });
  });

  group('avatarInitial (R-PROFILE-3)', () {
    test('first letter upper-cased when there is a name', () {
      expect(
        ok(Profile.create(createdAt: utc, displayName: 'isaac')).avatarInitial,
        'I',
      );
    });

    test('null when there is no name', () {
      expect(ok(Profile.create(createdAt: utc)).avatarInitial, isNull);
    });
  });

  group('copyWith', () {
    test('replaces fields and re-validates', () {
      final p = ok(Profile.create(createdAt: utc, displayName: 'Isaac'));
      expect(
        ok(p.copyWith(greeting: Greeting.mwaiseni)).greeting,
        Greeting.mwaiseni,
      );
      expect(p.copyWith(displayName: 'a' * 31), isErr('displayName.tooLong'));
    });

    test('an empty name clears it', () {
      final p = ok(Profile.create(createdAt: utc, displayName: 'Isaac'));
      expect(ok(p.copyWith(displayName: '')).displayName, isNull);
    });
  });

  test('equality is by value', () {
    expect(
      ok(Profile.create(createdAt: utc, displayName: 'Isaac')),
      ok(Profile.create(createdAt: utc, displayName: 'Isaac')),
    );
    expect(
      ok(Profile.create(createdAt: utc, displayName: 'Isaac')),
      isNot(ok(Profile.create(createdAt: utc, displayName: 'Mary'))),
    );
  });

  test('each greeting carries its word', () {
    expect(Greeting.muliShani.word, 'Muli shani');
    expect(Greeting.mwaiseni.word, 'Mwaiseni');
    expect(Greeting.hello.word, 'Hello');
  });
}
