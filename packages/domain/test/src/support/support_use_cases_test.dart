import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_support.dart';
import '../../helpers.dart';

List<HelpArticle> _articles() => [
  ok(
    HelpArticle.create(
      id: 'payday',
      title: 'How payday works',
      body: 'Move your savings and prove each transfer.',
      keywords: ['savings', 'transfer'],
    ),
  ),
  ok(
    HelpArticle.create(
      id: 'receipts',
      title: 'Scanning receipts',
      body: 'Snap a photo and we read the total.',
      keywords: ['scan', 'ocr'],
    ),
  ),
];

void main() {
  group('help', () {
    late InMemoryHelpContentRepository help;
    setUp(() => help = InMemoryHelpContentRepository(_articles()));

    test('ListHelpArticles returns all, in order', () async {
      final list = ok(await ListHelpArticles(help)());
      expect(list.map((a) => a.id), ['payday', 'receipts']);
    });

    test('SearchHelp filters by title, body or keyword', () async {
      expect(ok(await SearchHelp(help)('transfer')).single.id, 'payday');
      expect(ok(await SearchHelp(help)('scan')).single.id, 'receipts');
      expect(ok(await SearchHelp(help)('   ')).length, 2); // blank → all
      expect(ok(await SearchHelp(help)('nothing')), isEmpty);
    });

    test('GetHelpArticle returns one or NotFound', () async {
      expect(
        ok(await GetHelpArticle(help)('payday')).title,
        'How payday works',
      );
      expect(await GetHelpArticle(help)('missing'), isErr('help.notFound'));
    });

    test('RecordArticleFeedback stores the verdict', () async {
      ok(await RecordArticleFeedback(help)('payday', helpful: true));
      expect(help.feedback['payday'], isTrue);
    });
  });

  group('problem report (R-SUPPORT)', () {
    late ScriptedAppInfoReader appInfo;
    late ScriptedEmailComposer email;
    setUp(() {
      appInfo = ScriptedAppInfoReader();
      email = ScriptedEmailComposer();
    });

    test('BuildProblemReport attaches app info only when asked', () async {
      final without = ok(
        await BuildProblemReport(appInfo)(
          category: ProblemCategory.idea,
          text: 'Add dark mode',
        ),
      );
      expect(without.appInfo, isNull);

      final with_ = ok(
        await BuildProblemReport(appInfo)(
          category: ProblemCategory.somethingWrong,
          text: 'Crash',
          includeAppInfo: true,
        ),
      );
      expect(with_.appInfo, isNotNull);
    });

    test('BuildProblemReport rejects blank text', () async {
      expect(
        await BuildProblemReport(appInfo)(
          category: ProblemCategory.idea,
          text: '  ',
        ),
        isErr('text.blank'),
      );
    });

    test('OpenEmailComposer opens the email app with the message', () async {
      final report = ok(
        await BuildProblemReport(appInfo)(
          category: ProblemCategory.somethingWrong,
          text: 'Crash on open',
          includeAppInfo: true,
        ),
      );
      ok(await OpenEmailComposer(email)(report, to: 'help@example.test'));
      expect(email.to, 'help@example.test');
      expect(email.subject, 'Buckets — problem report');
      expect(email.body, startsWith('Crash on open'));
      expect(email.body, contains('Device: Tecno Spark 10'));
    });

    test('OpenEmailComposer reports when there is no email app', () async {
      email.hasApp = false;
      final report = ok(
        await BuildProblemReport(appInfo)(
          category: ProblemCategory.question,
          text: 'Hi',
        ),
      );
      expect(
        await OpenEmailComposer(email)(report, to: 'help@example.test'),
        isErr('email.noApp'),
      );
    });
  });

  group('about & settings openers', () {
    test('GetAppInfo reads the four facts', () async {
      final info = ok(await GetAppInfo(ScriptedAppInfoReader())());
      expect(info.appVersion, '1.0.0');
      expect(info.deviceModel, 'Tecno Spark 10');
    });

    test('OpenStoreListing and OpenBatterySettings hand off', () async {
      final opener = ScriptedSystemSettingsOpener();
      ok(await OpenStoreListing(opener)());
      ok(await OpenBatterySettings(opener)());
      expect(opener.store, 1);
      expect(opener.battery, 1);
    });
  });
}
