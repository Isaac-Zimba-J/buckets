import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  HelpArticle article({List<String> keywords = const []}) => ok(
    HelpArticle.create(
      id: 'payday',
      title: 'How payday works',
      body: 'On payday, move your savings and prove each transfer.',
      keywords: keywords,
    ),
  );

  group('HelpArticle.create', () {
    test('trims fields', () {
      final a = ok(
        HelpArticle.create(id: '  payday ', title: '  Title ', body: '  Body '),
      );
      expect(a.id, 'payday');
      expect(a.title, 'Title');
      expect(a.body, 'Body');
    });

    test('lower-cases keywords and drops blanks', () {
      expect(article(keywords: ['Save', '  ', 'TRANSFER']).keywords, [
        'save',
        'transfer',
      ]);
    });

    test('a blank id, title or body fails', () {
      expect(
        HelpArticle.create(id: ' ', title: 'T', body: 'B'),
        isErr('id.blank'),
      );
      expect(
        HelpArticle.create(id: 'i', title: ' ', body: 'B'),
        isErr('title.blank'),
      );
      expect(
        HelpArticle.create(id: 'i', title: 'T', body: ' '),
        isErr('body.blank'),
      );
    });
  });

  group('matches', () {
    test('matches on title, body or keyword, case-insensitively', () {
      final a = article(keywords: ['savings']);
      expect(a.matches('PAYDAY'), isTrue); // title
      expect(a.matches('prove'), isTrue); // body
      expect(a.matches('Savings'), isTrue); // keyword
    });

    test('no match for other words', () {
      expect(article().matches('receipt'), isFalse);
    });

    test('a blank query never matches', () {
      expect(article().matches('   '), isFalse);
    });
  });

  test('equality is by value', () {
    expect(article(), article());
    expect(article(keywords: ['a']), isNot(article(keywords: ['b'])));
  });

  group('steps + metadata', () {
    test('an article with steps also matches on step text', () {
      final a = ok(
        HelpArticle.create(
          id: 'why',
          title: "Why aren't my payments showing?",
          body: 'Buckets reads payment alerts. If they stop...',
          steps: const [
            HelpStep(
              title: 'Notification access is off',
              body: 'Buckets needs it to see alerts.',
              actionKind: HelpStepActionKind.openNotificationAccess,
              actionLabel: 'Open settings',
            ),
            HelpStep(
              title: 'Battery saver closed Buckets',
              body: 'Set battery use to Unrestricted.',
              actionKind: HelpStepActionKind.openBatterySettings,
              actionLabel: 'Open settings',
            ),
          ],
          topic: 'MoMo & Airtel alerts',
          isCommonQuestion: true,
        ),
      );
      expect(a.steps, hasLength(2));
      expect(a.isCommonQuestion, isTrue);
      expect(a.topic, 'MoMo & Airtel alerts');
      // Matches on body + step title + step body.
      expect(a.matches('notification'), isTrue);
      expect(a.matches('battery'), isTrue);
    });

    test('defaults: no steps, not a common question, no topic', () {
      final a = article();
      expect(a.steps, isEmpty);
      expect(a.isCommonQuestion, isFalse);
      expect(a.topic, isNull);
    });
  });
}
