import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/ports/permission_gateway.dart';

/// Shows the notification permission prompt (screen 06).
final class RequestNotificationPermission {
  /// Creates the use case.
  const new(this._gateway);

  final PermissionGateway _gateway;

  /// Runs it.
  Future<Result<PermissionState>> call() =>
      _gateway.request(AppPermission.notifications);
}
