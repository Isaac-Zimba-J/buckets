import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bucket_accounts_controller.freezed.dart';
part 'bucket_accounts_controller.g.dart';

/// Screen 05 Where buckets live.
@freezed
abstract class BucketAccountsState with _$BucketAccountsState {
  /// Buckets with their accounts; [someUnassigned] shows "Choose" badges.
  const factory BucketAccountsState({
    required List<BucketAccountVm> buckets,
    required List<AccountVm> accounts,
    required bool someUnassigned,
    String? errorCode,
  }) = _BucketAccountsState;
}

/// Screen 05 Where buckets live.
@riverpod
class BucketAccountsController extends _$BucketAccountsController {
  @override
  Future<BucketAccountsState> build() async {
    final rows = (await ref.watch(listBucketsWithAccountsProvider)()).orThrow();
    final accounts = (await ref.watch(accountRepositoryProvider).getAll())
        .orThrow();
    return BucketAccountsState(
      buckets: rows.map(BucketAccountVm.of).toList(),
      accounts: [
        for (final a in accounts)
          if (a.kind != AccountKind.cash) AccountVm.of(a),
      ],
      someUnassigned: rows.any((r) => r.account == null),
    );
  }

  /// Puts [bucketId]'s money in [accountId].
  Future<bool> assign(String bucketId, String accountId) async => await _after(
    await ref.read(assignBucketAccountProvider)(bucketId, accountId),
  );

  /// Adds or edits an account; a match key under 3 characters sets
  /// `errorCode` (R-ACC-3).
  Future<bool> saveAccount({
    required String name,
    required AccountKind kind,
    List<String> matchKeys = const [],
    bool isSpending = false,
    String? id,
  }) async => await _after(
    await ref.read(saveAccountProvider)(
      id: id,
      name: name,
      kind: kind,
      matchKeys: matchKeys,
      isSpending: isSpending,
    ),
  );

  Future<bool> _after(Result<Object?> result) async {
    final current = await future;
    switch (result) {
      case Ok():
        ref.invalidateSelf();
        await future;
        return true;
      case Err(:final failure):
        state = AsyncData(current.copyWith(errorCode: failure.code));
        return false;
    }
  }
}
