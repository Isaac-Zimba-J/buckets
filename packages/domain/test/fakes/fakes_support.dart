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

/// In-memory [CategoryRepository] seeded with the default categories.
class InMemoryCategoryRepository implements CategoryRepository {
  /// Seeds the defaults, as first-run would.
  InMemoryCategoryRepository({bool seedDefaults = true}) {
    if (seedDefaults) {
      for (final c in Category.defaults) {
        store.items[c.name] = c;
      }
    }
  }

  final store = MemoryStore<Category>((c) => c.name);

  @override
  Future<Result<List<Category>>> getAll() =>
      store.run(() => store.items.values.toList());

  @override
  Future<Result<List<Category>>> getActive() =>
      store.run(() => store.items.values.where((c) => !c.archived).toList());

  @override
  Stream<List<Category>> watchAll() =>
      store.watch(() => store.items.values.toList());

  @override
  Future<Result<void>> add(Category category) =>
      store.run(() => store.put(category));

  @override
  Future<Result<void>> rename({required String from, required Category to}) =>
      store.run(
        () => store
          ..remove(from)
          ..put(to),
      );

  @override
  Future<Result<void>> setArchived(String name, {required bool archived}) =>
      store.run(() {
        final c = store.items[name];
        if (c != null) {
          store.put(archived ? c.archive() : c.unarchive());
        }
      });
}

/// A [DeviceTimeZone] returning a fixed id.
class ScriptedDeviceTimeZone implements DeviceTimeZone {
  ScriptedDeviceTimeZone([this.id = 'Africa/Lusaka']);

  String id;

  @override
  Future<Result<String>> current() async => Ok(id);
}

/// A [StorageManager] returning a fixed summary.
class ScriptedStorageManager implements StorageManager {
  ScriptedStorageManager([
    this.value = const StorageSummary(
      alertCount: 12,
      receiptCount: 3,
      databaseBytes: 204800,
    ),
  ]);

  StorageSummary value;

  @override
  Future<Result<StorageSummary>> summary() async => Ok(value);
}

/// A [DataWiper] that records whether it was asked to wipe.
class RecordingDataWiper implements DataWiper {
  int wiped = 0;

  @override
  Future<Result<void>> wipeEverything() async {
    wiped++;
    return const Ok(null);
  }
}
