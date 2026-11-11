import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/support/help_content.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// In-memory [HelpContentRepository] over the bundled articles, for tests and
/// demo mode. Feedback is kept in memory.
class InMemoryHelpContentRepository implements HelpContentRepository {
  /// Feedback recorded, keyed by article id.
  final feedback = <String, bool>{};

  @override
  Future<Result<List<HelpArticle>>> all() async => Ok(helpArticles);

  @override
  Future<Result<HelpArticle?>> get(String id) async {
    for (final a in helpArticles) {
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

/// A [StorageManager] with a fixed summary.
class FakeStorageManager implements StorageManager {
  /// What [summary] returns.
  StorageSummary value = const StorageSummary(
    alertCount: 0,
    receiptCount: 0,
    databaseBytes: 0,
  );

  @override
  Future<Result<StorageSummary>> summary() async => Ok(value);
}

/// A [DataWiper] that records how often it was asked to wipe.
class FakeDataWiper implements DataWiper {
  /// How many times [wipeEverything] ran.
  int wiped = 0;

  @override
  Future<Result<void>> wipeEverything() async {
    wiped++;
    return const Ok(null);
  }
}

/// An [EmailComposer] that records the last draft.
class FakeEmailComposer implements EmailComposer {
  /// Whether an email app is available.
  bool hasApp = true;

  /// The last draft's recipient.
  String? to;

  /// The last draft's subject.
  String? subject;

  /// The last draft's body.
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
class FakeSystemSettingsOpener implements SystemSettingsOpener {
  /// How many times notification access was opened.
  int notificationAccess = 0;

  /// How many times battery settings were opened.
  int battery = 0;

  /// How many times the store listing was opened.
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

/// An [AppInfoReader] with fixed facts.
class FakeAppInfoReader implements AppInfoReader {
  /// What [read] returns.
  AppInfo value = const AppInfo(
    appVersion: '1.0.0',
    buildNumber: '1',
    androidVersion: '14',
    deviceModel: 'Test device',
  );

  @override
  Future<Result<AppInfo>> read() async => Ok(value);
}

/// A [DeviceTimeZone] with a fixed id.
class FakeDeviceTimeZone implements DeviceTimeZone {
  /// The zone [current] returns.
  String id = 'Africa/Lusaka';

  @override
  Future<Result<String>> current() async => Ok(id);
}
