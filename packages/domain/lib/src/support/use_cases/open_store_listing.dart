import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/ports/system_settings_opener.dart';

/// Opens the app's store listing (SCREENS 32).
final class OpenStoreListing {
  /// Creates the use case.
  const new(this._opener);

  final SystemSettingsOpener _opener;

  /// Hands off to the store app.
  Future<Result<void>> call() => _opener.openStoreListing();
}
