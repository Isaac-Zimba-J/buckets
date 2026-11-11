import 'package:buckets_core/buckets_core.dart';

/// Opens the user's email app with a pre-filled message (R-SUPPORT-1). The
/// app itself sends nothing; the user reviews and sends.
abstract interface class EmailComposer {
  /// Opens a draft to [to] with [subject] and [body]. Fails with
  /// `email.noApp` when the device has no email app.
  Future<Result<void>> compose({
    required String to,
    required String subject,
    required String body,
  });
}
