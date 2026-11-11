import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/help/presentation/controllers/help_article_controller.dart';
import 'package:buckets/features/help/presentation/controllers/help_controller.dart';
import 'package:buckets/features/help/presentation/controllers/report_controller.dart';
import 'package:buckets/features/me/presentation/controllers/about_controller.dart';
import 'package:buckets/features/me/presentation/controllers/data_privacy_controller.dart';
import 'package:buckets/features/me/presentation/controllers/rules_controller.dart';
import 'package:buckets/features/me/presentation/controllers/security_controller.dart';
import 'package:buckets/features/me/presentation/controllers/settings_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/profile_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

Future<T> next<T>(
  ProviderContainer c,
  ProviderListenable<AsyncValue<T>> p,
) async {
  c.listen(p, (_, _) {});
  for (var i = 0; i < 100; i++) {
    final v = c.read(p);
    if (v case AsyncData(:final value) when !v.isLoading) return value;
    if (v case AsyncError(:final error)) fail('$p failed: $error');
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('no value for $p');
}

void main() {
  late ProviderContainer c;
  setUp(() {
    c = ProviderContainer(overrides: fakePortOverrides());
    addTearDown(c.dispose);
  });

  Future<Settings> settings() async =>
      (await c.read(settingsRepositoryProvider).get()).orThrow();

  group('ProfileController (01b)', () {
    test('starts empty with Muli shani, saves a name', () async {
      final initial = await next(c, profileControllerProvider);
      expect(initial.displayName, '');
      expect(initial.greeting, Greeting.muliShani);

      final ctrl = c.read(profileControllerProvider.notifier)
        ..setName('Isaac')
        ..setGreeting(Greeting.mwaiseni);
      expect(await ctrl.save(), isTrue);

      final saved = (await c.read(profileRepositoryProvider).get()).orThrow();
      expect(saved!.displayName, 'Isaac');
      expect(saved.greeting, Greeting.mwaiseni);
    });
  });

  group('SettingsController (25)', () {
    test('toggles bill reminders', () async {
      final state = await next(c, settingsControllerProvider);
      expect(state.settings.billReminders, isTrue);
      expect(
        await c
            .read(settingsControllerProvider.notifier)
            .setBillReminders(enabled: false),
        isTrue,
      );
      expect((await settings()).billReminders, isFalse);
    });
  });

  group('SecurityController (26)', () {
    test('no screen lock → app lock refused; timeout saves', () async {
      final state = await next(c, securityControllerProvider);
      expect(state.lockAvailable, isFalse); // the open-lock fake
      // Can't turn on without a screen lock (R-SEC-1).
      expect(
        await c
            .read(securityControllerProvider.notifier)
            .setAppLock(enabled: true),
        isFalse,
      );
      expect(
        await c
            .read(securityControllerProvider.notifier)
            .setLockTimeout(LockTimeout.fiveMinutes),
        isTrue,
      );
      expect((await settings()).lockTimeout, LockTimeout.fiveMinutes);
    });
  });

  group('DataPrivacyController (27)', () {
    test('shows storage and clears alert history', () async {
      final state = await next(c, dataPrivacyControllerProvider);
      expect(state.storage.alertCount, 0);
      expect(
        await c
            .read(dataPrivacyControllerProvider.notifier)
            .clearAlertHistory(),
        isTrue,
      );
    });
  });

  group('RulesController (28)', () {
    test('lists seeded categories and adds one', () async {
      final state = await next(c, rulesControllerProvider);
      expect(state.categories.map((x) => x.name), contains('Food'));
      expect(
        await c.read(rulesControllerProvider.notifier).add('Snacks'),
        isTrue,
      );
      expect(
        (await c.read(categoryRepositoryProvider).getAll()).orThrow().map(
          (x) => x.name,
        ),
        contains('Snacks'),
      );
    });

    test('rejects archiving a built-in category', () async {
      await next(c, rulesControllerProvider);
      expect(
        await c
            .read(rulesControllerProvider.notifier)
            .setArchived('Food', archived: true),
        isFalse,
      );
    });
  });

  group('HelpController (29)', () {
    test('lists then filters articles', () async {
      final all = await next(c, helpControllerProvider);
      expect(all.results, isNotEmpty);
      await c.read(helpControllerProvider.notifier).search('receipt');
      final filtered = c.read(helpControllerProvider).requireValue;
      expect(filtered.results.map((a) => a.id), contains('scanning-receipts'));
      expect(filtered.query, 'receipt');
    });
  });

  group('HelpArticleController (30)', () {
    test('loads an article and records feedback', () async {
      final p = helpArticleControllerProvider('app-lock');
      final state = await next(c, p);
      expect(state.article.title, 'Locking the app');
      expect(state.feedbackGiven, isFalse);
      await c.read(p.notifier).recordFeedback(helpful: true);
      expect(c.read(p).requireValue.feedbackGiven, isTrue);
    });
  });

  group('ReportController (31)', () {
    test('sends opens the email app with the report', () async {
      final ctrl = c.read(reportControllerProvider.notifier)
        ..setText('The alarm did not ring')
        ..setIncludeAppInfo(include: true);
      expect(await ctrl.send(), isTrue);
      expect(c.read(reportControllerProvider).sent, isTrue);

      final email = c.read(emailComposerProvider) as FakeEmailComposer;
      expect(email.body, startsWith('The alarm did not ring'));
      expect(email.body, contains('Device:'));
    });

    test('blank text fails', () async {
      expect(await c.read(reportControllerProvider.notifier).send(), isFalse);
      expect(c.read(reportControllerProvider).errorCode, 'text.blank');
    });
  });

  group('AboutController (32)', () {
    test('shows the app info', () async {
      final info = await next(c, aboutControllerProvider);
      expect(info.appVersion, '1.0.0');
    });
  });
}
