import 'package:equatable/equatable.dart';

/// A notification captured on the phone, before parsing. Its [text] is
/// personal data: never log it without `redact()`.
final class IncomingAlertText with Equatable {
  /// Creates a capture. Throws an [ArgumentError] unless [receivedAt] is UTC.
  new({
    required this.packageName,
    required this.text,
    required this.receivedAt,
  }) {
    if (!receivedAt.isUtc) {
      throw ArgumentError.value(receivedAt, 'receivedAt', 'must be UTC');
    }
  }

  /// The Android package that posted it, e.g. the SMS app.
  final String packageName;

  /// The notification text.
  final String text;

  /// When the phone received it, in UTC.
  final DateTime receivedAt;

  @override
  List<Object?> get props => [packageName, text, receivedAt];
}
