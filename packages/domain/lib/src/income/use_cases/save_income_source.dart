import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/value_objects/match_key.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:buckets_domain/src/split/policies/default_splits.dart';
import 'package:buckets_domain/src/split/ports/split_profile_repository.dart';

/// Adds or edits an income source (screen 02). A new source gets its
/// default split (R-SPLIT-4/5); a side hustle defaults to irregular.
final class SaveIncomeSource {
  /// Creates the use case.
  const new(
    this._incomes,
    this._profiles,
    this._buckets,
    this._settings,
    this._ids,
  );

  final IncomeRepository _incomes;
  final SplitProfileRepository _profiles;
  final BucketRepository _buckets;
  final SettingsRepository _settings;
  final IdGenerator _ids;

  /// The saved source. Pass [id] to edit an existing one; [payerKeys]
  /// identify the payer in incoming messages (R-PARSE-5).
  Future<Result<IncomeSource>> call({
    required String name,
    required IncomeKind kind,
    required String landsInAccountId,
    String? id,
    Money? expectedAmount,
    PaySchedule? schedule,
    List<String>? payerKeys,
  }) => attempt(() async {
    final existing = id == null ? null : unwrap(await _incomes.get(id));
    final profileId =
        existing?.splitProfileId ?? unwrap(await _newProfile(kind)).id;
    final source = unwrap(
      IncomeSource.create(
        id: id ?? _ids.newId(),
        name: name,
        kind: kind,
        expectedAmount: expectedAmount,
        schedule:
            schedule ??
            (kind == IncomeKind.sideHustle
                ? const IrregularPay()
                : existing?.schedule ?? const MonthlyPay(0)),
        landsInAccountId: landsInAccountId,
        splitProfileId: profileId,
        deductBillsFirst: existing?.deductBillsFirst,
        payerKeys: payerKeys == null
            ? existing?.payerKeys ?? const []
            : unwrap(collect(payerKeys.map(MatchKey.create))),
      ),
    );
    unwrap(await _incomes.save(source));
    return source;
  });

  Future<Result<SplitProfile>> _newProfile(IncomeKind kind) =>
      attempt(() async {
        final buckets = unwrap(await _buckets.getAll());
        final fallback = unwrap(await _settings.get()).goalShareFallback;
        final allocations = unwrap(
          kind == IncomeKind.sideHustle
              ? DefaultSplits.sideHustle(buckets, goalShareFallback: fallback)
              : DefaultSplits.salary(buckets, goalShareFallback: fallback),
        );
        final profile = unwrap(
          SplitProfile.create(id: _ids.newId(), allocations: allocations),
        );
        unwrap(await _profiles.save(profile));
        return profile;
      });
}
