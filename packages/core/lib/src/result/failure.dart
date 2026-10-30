/// An expected problem, returned inside an `Err` rather than thrown.
///
/// [message] must be safe to show and log: it never contains raw message
/// text, account numbers, names or other personal data.
sealed class Failure {
  /// Creates a failure with a machine [code] and a safe [message].
  const Failure(this.code, this.message);

  /// A stable machine-readable code, e.g. `billsExceedIncome`.
  final String code;

  /// A safe, human-readable description.
  final String message;

  @override
  String toString() => 'Failure($code): $message';
}

/// Input broke a rule.
final class ValidationFailure extends Failure {
  /// Creates a validation failure.
  const ValidationFailure(super.code, super.message);
}

/// Something that was asked for does not exist.
final class NotFoundFailure extends Failure {
  /// Creates a not-found failure.
  const NotFoundFailure(super.code, super.message);
}

/// The request clashes with existing state, e.g. a reused reference.
final class ConflictFailure extends Failure {
  /// Creates a conflict failure.
  const ConflictFailure(super.code, super.message);
}

/// Reading or writing local storage failed.
final class StorageFailure extends Failure {
  /// Creates a storage failure.
  const StorageFailure(super.code, super.message);
}

/// A platform capability (OCR, notifications, camera) failed.
final class PlatformFailure extends Failure {
  /// Creates a platform failure.
  const PlatformFailure(super.code, super.message);
}

/// The user has not granted a permission the action needs.
final class PermissionFailure extends Failure {
  /// Creates a permission failure.
  const PermissionFailure(super.code, super.message);
}
