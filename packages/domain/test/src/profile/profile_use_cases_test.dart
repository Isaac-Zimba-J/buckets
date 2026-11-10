import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_support.dart';
import '../../helpers.dart';

void main() {
  late InMemoryProfileRepository profiles;
  setUp(() => profiles = InMemoryProfileRepository());

  group('SaveProfile', () {
    test('creates a profile with the given fields', () async {
      final saved = ok(
        await SaveProfile(profiles)(
          now: utc,
          displayName: 'Isaac',
          greeting: Greeting.mwaiseni,
        ),
      );
      expect(saved.displayName, 'Isaac');
      expect(saved.greeting, Greeting.mwaiseni);
      expect(saved.createdAt, utc);
      expect(ok(await profiles.get())!.displayName, 'Isaac');
    });

    test('a blank name is allowed and stored as null (R-PROFILE-2)', () async {
      final saved = ok(await SaveProfile(profiles)(now: utc, displayName: ' '));
      expect(saved.displayName, isNull);
    });

    test('keeps the original createdAt on later edits', () async {
      await SaveProfile(profiles)(now: utc, displayName: 'Isaac');
      final later = utc.add(const Duration(days: 30));
      final edited = ok(
        await SaveProfile(profiles)(now: later, displayName: 'Isaac M'),
      );
      expect(edited.createdAt, utc);
      expect(edited.displayName, 'Isaac M');
    });

    test('rejects a name over 30 characters', () async {
      expect(
        await SaveProfile(profiles)(now: utc, displayName: 'a' * 31),
        isErr('displayName.tooLong'),
      );
    });
  });

  group('WatchProfileSummary', () {
    test('emits a default summary when no profile is set', () async {
      final summary = await WatchProfileSummary(profiles)().first;
      expect(summary.displayName, isNull);
      expect(summary.avatarInitial, isNull);
      expect(summary.greeting, Greeting.muliShani);
    });

    test('reflects the saved profile', () async {
      await SaveProfile(profiles)(now: utc, displayName: 'isaac');
      final summary = await WatchProfileSummary(profiles)().first;
      expect(summary.displayName, 'isaac');
      expect(summary.avatarInitial, 'I');
    });
  });
}
