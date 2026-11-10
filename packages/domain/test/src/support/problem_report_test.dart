import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  const info = AppInfo(
    appVersion: '1.0.0',
    buildNumber: '42',
    androidVersion: '14',
    deviceModel: 'Tecno Spark 10',
  );

  group('ProblemReport.create', () {
    test('trims the text and keeps the category', () {
      final r = ok(
        ProblemReport.create(
          category: ProblemCategory.somethingWrong,
          text: '  The alarm did not ring  ',
        ),
      );
      expect(r.category, ProblemCategory.somethingWrong);
      expect(r.text, 'The alarm did not ring');
      expect(r.appInfo, isNull);
    });

    test('a blank text fails', () {
      expect(
        ProblemReport.create(category: ProblemCategory.idea, text: '   '),
        isErr('text.blank'),
      );
    });
  });

  group('ProblemReportBuilder.body (R-SUPPORT-2)', () {
    test('without app info, the body is just the user text', () {
      final r = ok(
        ProblemReport.create(
          category: ProblemCategory.question,
          text: 'How do I prove a transfer?',
        ),
      );
      expect(ProblemReportBuilder.body(r), 'How do I prove a transfer?');
    });

    test('with app info, only the four whitelisted facts are appended', () {
      final r = ok(
        ProblemReport.create(
          category: ProblemCategory.somethingWrong,
          text: 'Crash on open',
          appInfo: info,
        ),
      );
      final body = ProblemReportBuilder.body(r);
      expect(body, startsWith('Crash on open'));
      expect(body, contains('App version: 1.0.0 (42)'));
      expect(body, contains('Android: 14'));
      expect(body, contains('Device: Tecno Spark 10'));
      // Nothing else leaks: only the user's text plus the four facts.
      final lines = body
          .split('\n')
          .where((l) => l.trim().isNotEmpty && l.trim() != '---')
          .toList();
      expect(lines, [
        'Crash on open',
        'App version: 1.0.0 (42)',
        'Android: 14',
        'Device: Tecno Spark 10',
      ]);
    });

    test('subject is fixed', () {
      expect(ProblemReportBuilder.subject, 'Buckets — problem report');
    });
  });

  test('AppInfo equality is by value', () {
    expect(
      info,
      const AppInfo(
        appVersion: '1.0.0',
        buildNumber: '42',
        androidVersion: '14',
        deviceModel: 'Tecno Spark 10',
      ),
    );
  });
}
