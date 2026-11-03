import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/ports/permission_gateway.dart';

/// Opens the system page for reading payment notifications (screen 06).
final class OpenNotificationAccessSettings {
  /// Creates the use case.
  const new(this._gateway);

  final PermissionGateway _gateway;

  /// Runs it.
  Future<Result<void>> call() =>
      _gateway.openSettings(AppPermission.notificationAccess);
}
