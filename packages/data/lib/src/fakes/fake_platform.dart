import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// A [PermissionGateway] whose answers tests set.
class FakePermissionGateway implements PermissionGateway {
  /// Current states; missing means denied.
  final states = <AppPermission, PermissionState>{};

  /// Settings pages opened, in order.
  final opened = <AppPermission>[];

  /// What [request] changes a permission to.
  PermissionState grantOnRequest = PermissionState.granted;

  @override
  Future<Result<PermissionState>> status(AppPermission permission) async =>
      Ok(states[permission] ?? PermissionState.denied);

  @override
  Future<Result<PermissionState>> request(AppPermission permission) async =>
      Ok(states[permission] = grantOnRequest);

  @override
  Future<Result<void>> openSettings(AppPermission permission) async {
    opened.add(permission);
    return const Ok(null);
  }
}

/// A [Clock] fixed at [now] until a test moves it.
class FakeClock implements Clock {
  /// Starts at [now_].
  new(this.now_);

  /// The time `now()` returns; tests move it.
  DateTime now_;

  @override
  DateTime now() => now_;
}

/// Africa/Lusaka: UTC+2 all year.
class LusakaTimeZone implements LocalTimeZone {
  @override
  Duration offsetAt(DateTime utc) => const Duration(hours: 2);
}

/// A [PaymentAlertSource] with a queue tests fill.
class FakePaymentAlertSource implements PaymentAlertSource {
  /// Captures waiting to be drained.
  final queue = <IncomingAlertText>[];

  @override
  Future<Result<List<IncomingAlertText>>> drain() async {
    final drained = [...queue];
    queue.clear();
    return Ok(drained);
  }
}

/// An [ImageCapture] returning [path], or null as if cancelled.
class FakeImageCapture implements ImageCapture {
  /// The path to return; null means cancelled.
  String? path = '/private/receipt.jpg';

  /// Simulates the camera permission being refused.
  bool denied = false;

  @override
  Future<Result<String?>> capture(CaptureSource source) async => denied
      ? const Err(PermissionFailure('camera', 'Camera not allowed.'))
      : Ok(path);
}

/// A [TextRecognizer] returning [text].
class FakeTextRecognizer implements TextRecognizer {
  /// The text to return.
  String text = '';

  @override
  Future<Result<String>> recognize(String imagePath) async => Ok(text);
}

/// A [ReceiptTextParser] returning [draft] for any text.
class FakeReceiptTextParser implements ReceiptTextParser {
  /// The draft to return.
  ReceiptDraft draft = ReceiptDraft();

  @override
  ReceiptDraft parse(String text, {required Duration utcOffset}) => draft;
}

/// A [NotificationScheduler] that remembers the last schedule.
class FakeNotificationScheduler implements NotificationScheduler {
  /// The last schedule handed over.
  List<ScheduledNotification> scheduled = const [];

  @override
  Future<Result<void>> replaceAll(
    List<ScheduledNotification> notifications,
  ) async {
    scheduled = notifications;
    return const Ok(null);
  }

  @override
  Future<Result<void>> cancel(String id) async {
    scheduled = [...scheduled.where((n) => n.id != id)];
    return const Ok(null);
  }
}
