import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/policies/ledger_policy.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/entities/transfer.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:buckets_domain/src/split/ports/split_profile_repository.dart';
import 'package:buckets_domain/src/split/value_objects/allocation.dart';

/// Removes a user-created bucket (R-BUCKET-6): moves its money out, hands
/// its split share to the fallback bucket, then archives it.
final class ArchiveBucket {
  /// Creates the use case.
  const new({
    required this.buckets,
    required this.ledger,
    required this.paydays,
    required this.incomes,
    required this.profiles,
    required this.settings,
    required this.ids,
    required this.clock,
  });

  /// Buckets.
  final BucketRepository buckets;

  /// The ledger.
  final LedgerRepository ledger;

  /// Paydays, to block removal while a transfer is open.
  final PaydayRepository paydays;

  /// Income sources, to find the split profiles to fix.
  final IncomeRepository incomes;

  /// Split profiles.
  final SplitProfileRepository profiles;

  /// Settings, for the fallback bucket kind.
  final SettingsRepository settings;

  /// IDs.
  final IdGenerator ids;

  /// The clock.
  final Clock clock;

  /// Removes [bucketId]. When it holds money, [moveTo] must name the bucket
  /// to receive it. Fails when the bucket is a default one, is overspent,
  /// or has an unproven payday transfer.
  Future<Result<void>> call({required String bucketId, String? moveTo}) =>
      attempt(() async {
        final all = unwrap(await buckets.getAll());
        final bucket = all.firstWhere((b) => b.id == bucketId);
        if (!bucket.isRemovable) {
          unwrap<void>(
            const Err(
              ValidationFailure(
                'bucket.notRemovable',
                "This bucket can't be removed.",
              ),
            ),
          );
        }
        if (unwrap(await _hasOpenTransfer(bucketId))) {
          unwrap<void>(
            const Err(
              ConflictFailure(
                'bucket.transferOpen',
                'Finish this payday before removing the bucket.',
              ),
            ),
          );
        }
        final entries = unwrap(await ledger.getEntries());
        final balance = BalanceCalculator.balance(entries, bucketId);
        if (balance.isNegative) {
          unwrap<void>(
            const Err(
              ConflictFailure(
                'bucket.overspent',
                'Cover what this bucket owes before removing it.',
              ),
            ),
          );
        }
        if (balance.isPositive) {
          final dest = moveTo;
          if (dest == null) {
            unwrap<void>(
              const Err(
                ValidationFailure(
                  'moveTo.missing',
                  'Choose where this money should go.',
                ),
              ),
            );
          }
          final move = unwrap(
            LedgerPolicy.move(
              ids: ids,
              fromBucketId: bucketId,
              toBucketId: dest!,
              amount: balance,
              at: clock.now(),
            ),
          );
          unwrap(await ledger.append(move));
        }
        await _handOverSplit(bucketId);
        unwrap(await buckets.saveAll([bucket.archive()]));
      });

  Future<Result<bool>> _hasOpenTransfer(String bucketId) => attempt(() async {
    final open = unwrap(await paydays.getAll())
        .where((p) => p.status == PaydayStatus.open);
    bool unproven(Transfer t) =>
        t.status == TransferStatus.pending ||
        t.status == TransferStatus.partial;
    return open.any(
      (p) => p.transfers.any((t) => t.bucketId == bucketId && unproven(t)),
    );
  });

  /// Reassigns the bucket's allocations to the `goalShareFallback` bucket
  /// in every split profile (R-BUCKET-6, future paydays only).
  Future<void> _handOverSplit(String bucketId) async {
    final fallbackKind = unwrap(await settings.get()).goalShareFallback;
    final fallback = unwrap(await buckets.getAll())
        .firstWhere((b) => b.kind == fallbackKind);
    final profileIds = {
      for (final i in unwrap(await incomes.getAll())) i.splitProfileId,
    };
    for (final id in profileIds) {
      final profile = unwrap(await profiles.get(id));
      if (!profile.allocations.any((a) => a.bucketId == bucketId)) continue;
      unwrap(await profiles.save(_reassign(profile, bucketId, fallback.id)));
    }
  }

  SplitProfile _reassign(SplitProfile profile, String from, String to) {
    var toBp = 0;
    final kept = <Allocation>[];
    for (final a in profile.allocations) {
      if (a.bucketId == from || a.bucketId == to) {
        toBp += a.bp.value;
      } else {
        kept.add(a);
      }
    }
    return unwrap(
      SplitProfile.create(
        id: profile.id,
        allocations: [...kept, Allocation(to, BasisPoints(toBp))],
        holdUntilMonthEnd: profile.holdUntilMonthEnd,
      ),
    );
  }
}
