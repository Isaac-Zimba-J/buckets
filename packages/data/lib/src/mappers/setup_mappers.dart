import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/mappers/results.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// Row ⇄ entity for setup aggregates. Pure conversion; entities are
/// rebuilt through their validating factories, so a corrupt row comes back
/// as an `Err` instead of a broken entity.
abstract final class SetupMappers {
  /// An account from its row and match keys (in position order).
  static Result<Account> account(
    AccountRow row,
    List<AccountMatchKeyRow> keys,
  ) => switch (collectAll([for (final k in keys) MatchKey.create(k.value)])) {
    Ok(:final value) => Account.create(
      id: row.id,
      name: row.name,
      kind: row.kind,
      matchKeys: value,
      isSpending: row.isSpending,
    ),
    Err(:final failure) => Err(failure),
  };

  /// The rows for [account].
  static (AccountsCompanion, List<AccountMatchKeysCompanion>) accountRows(
    Account account,
  ) => (
    AccountsCompanion.insert(
      id: account.id,
      name: account.name,
      kind: account.kind,
      isSpending: account.isSpending,
    ),
    [
      for (final (i, k) in account.matchKeys.indexed)
        AccountMatchKeysCompanion.insert(
          accountId: account.id,
          position: i,
          value: k.value,
        ),
    ],
  );

  /// A bucket from its row.
  static Result<Bucket> bucket(BucketRow row) => Bucket.create(
    id: row.id,
    name: row.name,
    kind: row.kind,
    color: row.color,
    accountId: row.accountId,
    isProtected: row.isProtected,
    sortOrder: row.sortOrder,
    archived: row.archived,
  );

  /// The row for [bucket].
  static BucketsCompanion bucketRow(Bucket bucket) => BucketsCompanion.insert(
    id: bucket.id,
    name: bucket.name,
    kind: bucket.kind,
    color: bucket.color,
    accountId: bucket.accountId,
    isProtected: bucket.isProtected,
    sortOrder: bucket.sortOrder,
    archived: bucket.archived,
  );

  /// An income source from its row and payer keys.
  static Result<IncomeSource> income(
    IncomeSourceRow row,
    List<IncomePayerKeyRow> keys,
  ) {
    final schedule = switch (row.scheduleKind) {
      'monthly' => MonthlyPay(row.scheduleDay ?? 0),
      'fortnightly' => FortnightlyPay(row.scheduleAnchor ?? DateTime(0)),
      _ => const IrregularPay(),
    };
    return switch (collectAll([
      for (final k in keys) MatchKey.create(k.value),
    ])) {
      Ok(:final value) => IncomeSource.create(
        id: row.id,
        name: row.name,
        kind: row.kind,
        schedule: schedule,
        landsInAccountId: row.landsInAccountId,
        splitProfileId: row.splitProfileId,
        expectedAmount: _money(row.expectedAmount),
        deductBillsFirst: row.deductBillsFirst,
        payerKeys: value,
      ),
      Err(:final failure) => Err(failure),
    };
  }

  /// The rows for [income].
  static (IncomeSourcesCompanion, List<IncomePayerKeysCompanion>) incomeRows(
    IncomeSource income,
  ) {
    final (kind, day, anchor) = switch (income.schedule) {
      MonthlyPay(:final dayOfMonth) => ('monthly', dayOfMonth, null),
      FortnightlyPay(:final anchor) => ('fortnightly', null, anchor),
      IrregularPay() => ('irregular', null, null),
    };
    return (
      IncomeSourcesCompanion.insert(
        id: income.id,
        name: income.name,
        kind: income.kind,
        expectedAmount: Value(income.expectedAmount?.ngwee),
        scheduleKind: kind,
        scheduleDay: Value(day),
        scheduleAnchor: Value(anchor),
        landsInAccountId: income.landsInAccountId,
        splitProfileId: income.splitProfileId,
        deductBillsFirst: income.deductBillsFirst,
      ),
      [
        for (final (i, k) in income.payerKeys.indexed)
          IncomePayerKeysCompanion.insert(
            incomeId: income.id,
            position: i,
            value: k.value,
          ),
      ],
    );
  }

  /// A split profile from its row and allocations (in position order).
  static Result<SplitProfile> splitProfile(
    SplitProfileRow row,
    List<SplitAllocationRow> allocations,
  ) => SplitProfile.create(
    id: row.id,
    allocations: [
      for (final a in allocations)
        Allocation(a.bucketId, BasisPoints(a.basisPoints)),
    ],
    holdUntilMonthEnd: row.holdUntilMonthEnd,
  );

  /// The rows for [profile].
  static (SplitProfilesCompanion, List<SplitAllocationsCompanion>)
  splitProfileRows(SplitProfile profile) => (
    SplitProfilesCompanion.insert(
      id: profile.id,
      holdUntilMonthEnd: profile.holdUntilMonthEnd,
    ),
    [
      for (final (i, a) in profile.allocations.indexed)
        SplitAllocationsCompanion.insert(
          profileId: profile.id,
          position: i,
          bucketId: a.bucketId,
          basisPoints: a.bp.value,
        ),
    ],
  );

  /// A bill from its row.
  static Result<Bill> bill(BillRow row) => Bill.create(
    id: row.id,
    name: row.name,
    amount: Money(row.amount),
    frequency: BillFrequency.everyNMonths(row.frequencyMonths),
    paidFromBucketId: row.paidFromBucketId,
    dueDay: row.dueDay,
    nextDueDate: row.nextDueDate,
    payeeAccountHint: row.payeeAccountHint,
  );

  /// The row for [bill].
  static BillsCompanion billRow(Bill bill) => BillsCompanion.insert(
    id: bill.id,
    name: bill.name,
    amount: bill.amount.ngwee,
    frequencyMonths: bill.frequency.months,
    dueDay: Value(bill.dueDay),
    nextDueDate: Value(bill.nextDueDate),
    paidFromBucketId: bill.paidFromBucketId,
    payeeAccountHint: Value(bill.payeeAccountHint),
  );

  /// Settings from the settings row.
  static Result<Settings> settings(SettingsRow row) => Settings.create(
    timeZone: row.timeZone,
    quietHours: QuietHours(
      _time(row.quietStartMinutes),
      _time(row.quietEndMinutes),
    ),
    snoozeLimit: row.snoozeLimit,
    coolingOffThreshold: Money(row.coolingOffThreshold),
    coolingOffHours: row.coolingOffHours,
    checkInDay: row.checkInDay,
    checkInTime: _time(row.checkInMinutes),
    appLock: row.appLock,
    lockTimeout: row.lockTimeout,
    hideAmounts: row.hideAmounts,
    billReminders: row.billReminders,
    autoFile: row.autoFile,
    goalShareFallback: row.goalShareFallback,
    setupCompletedAt: row.setupCompletedAt,
  );

  /// The single settings row for [settings].
  static SettingsRowsCompanion settingsRow(Settings settings) =>
      SettingsRowsCompanion.insert(
        id: const Value(1),
        timeZone: settings.timeZone,
        quietStartMinutes: settings.quietHours.start.minutesOfDay,
        quietEndMinutes: settings.quietHours.end.minutesOfDay,
        snoozeLimit: settings.snoozeLimit,
        coolingOffThreshold: settings.coolingOffThreshold.ngwee,
        coolingOffHours: settings.coolingOffHours,
        checkInDay: settings.checkInDay,
        checkInMinutes: settings.checkInTime.minutesOfDay,
        appLock: settings.appLock,
        lockTimeout: Value(settings.lockTimeout),
        hideAmounts: Value(settings.hideAmounts),
        billReminders: Value(settings.billReminders),
        autoFile: settings.autoFile,
        goalShareFallback: settings.goalShareFallback,
        setupCompletedAt: Value(settings.setupCompletedAt),
      );

  /// The profile from its row.
  static Result<Profile> profile(ProfileRow row) => Profile.create(
    createdAt: row.createdAt,
    displayName: row.displayName,
    greeting: row.greeting,
    timeZone: row.timeZone,
  );

  /// The single profile row for [profile].
  static ProfilesCompanion profileRow(Profile profile) =>
      ProfilesCompanion.insert(
        id: const Value(1),
        displayName: Value(profile.displayName),
        greeting: profile.greeting,
        timeZone: profile.timeZone,
        createdAt: profile.createdAt,
      );

  /// A category from its row.
  static Result<Category> category(CategoryRow row) => Category.fromStored(
    name: row.name,
    isDefault: row.isDefault,
    archived: row.archived,
  );

  /// The row for [category].
  static CategoriesCompanion categoryRow(Category category) =>
      CategoriesCompanion.insert(
        name: category.name,
        isDefault: Value(category.isDefault),
        archived: Value(category.archived),
      );

  static LocalTime _time(int minutes) => LocalTime(minutes ~/ 60, minutes % 60);

  static Money? _money(int? ngwee) => ngwee == null ? null : Money(ngwee);
}
