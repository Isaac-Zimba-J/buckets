import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/policies/data_privacy_rules.dart';
import 'package:buckets_domain/src/settings/ports/data_wiper.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Wipes all data after the user types DELETE (SCREENS 27, R-PRIV-4).
final class DeleteAllData {
  /// Creates the use case.
  const new(this._wiper);

  final DataWiper _wiper;

  /// Confirms [typed] is the keyword, then wipes everything.
  Future<Result<void>> call(String typed) => attempt(() async {
    if (!DataPrivacyRules.confirmsDelete(typed)) {
      unwrap<void>(
        const Err(
          ValidationFailure('delete.notConfirmed', 'Type DELETE to confirm.'),
        ),
      );
    }
    unwrap(await _wiper.wipeEverything());
  });
}
