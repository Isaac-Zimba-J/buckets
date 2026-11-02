import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/ports/permission_gateway.dart';

/// The current state of a permission (screen 06).
final class GetPermissionStatus {
  /// Creates the use case.
  const GetPermissionStatus(this._gateway);

  final PermissionGateway _gateway;

  /// Runs it.
  Future<Result<PermissionState>> call(AppPermission permission) =>
      _gateway.status(permission);
}
