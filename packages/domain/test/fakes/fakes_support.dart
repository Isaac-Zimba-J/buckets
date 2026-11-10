import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

import 'fakes.dart';

/// In-memory [ProfileRepository].
class InMemoryProfileRepository implements ProfileRepository {
  final store = MemoryStore<Profile>((_) => 'profile');

  @override
  Future<Result<Profile?>> get() async => store.failing
      ? const Err(StorageFailure('storage', 'Storage failed.'))
      : Ok(store.items['profile']);

  @override
  Future<Result<void>> save(Profile profile) =>
      store.run(() => store.put(profile));

  @override
  Stream<Profile?> watch() => store.watch(() => store.items['profile']);
}

/// In-memory [HelpContentRepository] over a fixed article list.
class InMemoryHelpContentRepository implements HelpContentRepository {
  InMemoryHelpContentRepository(this._articles);

  final List<HelpArticle> _articles;

  /// Feedback recorded, keyed by article id.
  final feedback = <String, bool>{};

  @override
  Future<Result<List<HelpArticle>>> all() async => Ok(_articles);

  @override
  Future<Result<HelpArticle?>> get(String id) async {
    for (final a in _articles) {
      if (a.id == id) return Ok(a);
    }
    return const Ok(null);
  }

  @override
  Future<Result<void>> recordFeedback(
    String articleId, {
    required bool helpful,
  }) async {
    feedback[articleId] = helpful;
    return const Ok(null);
  }
}

/// A [EmailComposer] that records the last draft, or reports no email app.
class ScriptedEmailComposer implements EmailComposer {
  bool hasApp = true;
  String? to;
  String? subject;
  String? body;

  @override
  Future<Result<void>> compose({
    required String to,
    required String subject,
    required String body,
  }) async {
    if (!hasApp) {
      return const Err(PlatformFailure('email.noApp', 'No email app.'));
    }
    this.to = to;
    this.subject = subject;
    this.body = body;
    return const Ok(null);
  }
}

/// A [SystemSettingsOpener] that counts which screens were opened.
class ScriptedSystemSettingsOpener implements SystemSettingsOpener {
  int notificationAccess = 0;
  int battery = 0;
  int store = 0;

  @override
  Future<Result<void>> openNotificationAccess() async {
    notificationAccess++;
    return const Ok(null);
  }

  @override
  Future<Result<void>> openBatterySettings() async {
    battery++;
    return const Ok(null);
  }

  @override
  Future<Result<void>> openStoreListing() async {
    store++;
    return const Ok(null);
  }
}

/// An [AppInfoReader] returning a fixed [AppInfo].
class ScriptedAppInfoReader implements AppInfoReader {
  ScriptedAppInfoReader([
    this.info = const AppInfo(
      appVersion: '1.0.0',
      buildNumber: '42',
      androidVersion: '14',
      deviceModel: 'Tecno Spark 10',
    ),
  ]);

  AppInfo info;
  bool failing = false;

  @override
  Future<Result<AppInfo>> read() async => failing
      ? const Err(PlatformFailure('appInfo.unavailable', 'No app info.'))
      : Ok(info);
}
