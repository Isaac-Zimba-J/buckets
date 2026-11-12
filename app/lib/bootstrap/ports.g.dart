// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ports.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// English strings outside a widget, for notification copy.

@ProviderFor(strings)
final stringsProvider = StringsProvider._();

/// English strings outside a widget, for notification copy.

final class StringsProvider
    extends
        $FunctionalProvider<
          AppLocalizations,
          AppLocalizations,
          AppLocalizations
        >
    with $Provider<AppLocalizations> {
  /// English strings outside a widget, for notification copy.
  StringsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stringsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stringsHash();

  @$internal
  @override
  $ProviderElement<AppLocalizations> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLocalizations create(Ref ref) {
    return strings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLocalizations value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLocalizations>(value),
    );
  }
}

String _$stringsHash() => r'f8902720bb7975ba41fac311cb7089b56d371736';

/// The one database file.

@ProviderFor(database)
final databaseProvider = DatabaseProvider._();

/// The one database file.

final class DatabaseProvider
    extends
        $FunctionalProvider<BucketsDatabase, BucketsDatabase, BucketsDatabase>
    with $Provider<BucketsDatabase> {
  /// The one database file.
  DatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseHash();

  @$internal
  @override
  $ProviderElement<BucketsDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BucketsDatabase create(Ref ref) {
    return database(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BucketsDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BucketsDatabase>(value),
    );
  }
}

String _$databaseHash() => r'f17db69a15ca4610ff503b1515ff43c00a5baffd';

/// The device time zone; `main()` overrides it after loading it.

@ProviderFor(localTimeZone)
final localTimeZoneProvider = LocalTimeZoneProvider._();

/// The device time zone; `main()` overrides it after loading it.

final class LocalTimeZoneProvider
    extends $FunctionalProvider<LocalTimeZone, LocalTimeZone, LocalTimeZone>
    with $Provider<LocalTimeZone> {
  /// The device time zone; `main()` overrides it after loading it.
  LocalTimeZoneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localTimeZoneProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localTimeZoneHash();

  @$internal
  @override
  $ProviderElement<LocalTimeZone> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalTimeZone create(Ref ref) {
    return localTimeZone(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalTimeZone value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalTimeZone>(value),
    );
  }
}

String _$localTimeZoneHash() => r'd17ecf17cef011f8d242d2865f7d728c86177310';

/// The only clock.

@ProviderFor(clock)
final clockProvider = ClockProvider._();

/// The only clock.

final class ClockProvider extends $FunctionalProvider<Clock, Clock, Clock>
    with $Provider<Clock> {
  /// The only clock.
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $ProviderElement<Clock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Clock create(Ref ref) {
    return clock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Clock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Clock>(value),
    );
  }
}

String _$clockHash() => r'55214d6539f7396a3ae1aa23b06eea79fdac0ebe';

/// The only ID source.

@ProviderFor(ids)
final idsProvider = IdsProvider._();

/// The only ID source.

final class IdsProvider
    extends $FunctionalProvider<IdGenerator, IdGenerator, IdGenerator>
    with $Provider<IdGenerator> {
  /// The only ID source.
  IdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'idsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$idsHash();

  @$internal
  @override
  $ProviderElement<IdGenerator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IdGenerator create(Ref ref) {
    return ids(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IdGenerator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IdGenerator>(value),
    );
  }
}

String _$idsHash() => r'9e91533e0053ac3cb05a6f479e89e9b3950f750f';

/// Accounts.

@ProviderFor(accountRepository)
final accountRepositoryProvider = AccountRepositoryProvider._();

/// Accounts.

final class AccountRepositoryProvider
    extends
        $FunctionalProvider<
          AccountRepository,
          AccountRepository,
          AccountRepository
        >
    with $Provider<AccountRepository> {
  /// Accounts.
  AccountRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountRepositoryHash();

  @$internal
  @override
  $ProviderElement<AccountRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountRepository create(Ref ref) {
    return accountRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountRepository>(value),
    );
  }
}

String _$accountRepositoryHash() => r'fd17b1524eb83d2287e1636d1ca3c3cb419b171e';

/// Buckets.

@ProviderFor(bucketRepository)
final bucketRepositoryProvider = BucketRepositoryProvider._();

/// Buckets.

final class BucketRepositoryProvider
    extends
        $FunctionalProvider<
          BucketRepository,
          BucketRepository,
          BucketRepository
        >
    with $Provider<BucketRepository> {
  /// Buckets.
  BucketRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bucketRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bucketRepositoryHash();

  @$internal
  @override
  $ProviderElement<BucketRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BucketRepository create(Ref ref) {
    return bucketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BucketRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BucketRepository>(value),
    );
  }
}

String _$bucketRepositoryHash() => r'1d3c3cdcc5c91bb39d14eac33d81e5893b3a6685';

/// Income sources.

@ProviderFor(incomeRepository)
final incomeRepositoryProvider = IncomeRepositoryProvider._();

/// Income sources.

final class IncomeRepositoryProvider
    extends
        $FunctionalProvider<
          IncomeRepository,
          IncomeRepository,
          IncomeRepository
        >
    with $Provider<IncomeRepository> {
  /// Income sources.
  IncomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomeRepositoryHash();

  @$internal
  @override
  $ProviderElement<IncomeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IncomeRepository create(Ref ref) {
    return incomeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncomeRepository>(value),
    );
  }
}

String _$incomeRepositoryHash() => r'5abe06f1797d0ec62d3904cb6c5d1800ecb99f5f';

/// Split profiles.

@ProviderFor(splitProfileRepository)
final splitProfileRepositoryProvider = SplitProfileRepositoryProvider._();

/// Split profiles.

final class SplitProfileRepositoryProvider
    extends
        $FunctionalProvider<
          SplitProfileRepository,
          SplitProfileRepository,
          SplitProfileRepository
        >
    with $Provider<SplitProfileRepository> {
  /// Split profiles.
  SplitProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splitProfileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splitProfileRepositoryHash();

  @$internal
  @override
  $ProviderElement<SplitProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SplitProfileRepository create(Ref ref) {
    return splitProfileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SplitProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SplitProfileRepository>(value),
    );
  }
}

String _$splitProfileRepositoryHash() =>
    r'503e183e7913fdff60a6915f8255a5e7c0320628';

/// Bills.

@ProviderFor(billRepository)
final billRepositoryProvider = BillRepositoryProvider._();

/// Bills.

final class BillRepositoryProvider
    extends $FunctionalProvider<BillRepository, BillRepository, BillRepository>
    with $Provider<BillRepository> {
  /// Bills.
  BillRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billRepositoryHash();

  @$internal
  @override
  $ProviderElement<BillRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BillRepository create(Ref ref) {
    return billRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BillRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BillRepository>(value),
    );
  }
}

String _$billRepositoryHash() => r'c082b6ed1bbde919b050d449fdbcefc5dc9eaa54';

/// Settings.

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

/// Settings.

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  /// Settings.
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'e4f4ff41f10f5339de9a41b0cdc4006d77c6dba7';

/// The ledger.

@ProviderFor(ledgerRepository)
final ledgerRepositoryProvider = LedgerRepositoryProvider._();

/// The ledger.

final class LedgerRepositoryProvider
    extends
        $FunctionalProvider<
          LedgerRepository,
          LedgerRepository,
          LedgerRepository
        >
    with $Provider<LedgerRepository> {
  /// The ledger.
  LedgerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ledgerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ledgerRepositoryHash();

  @$internal
  @override
  $ProviderElement<LedgerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LedgerRepository create(Ref ref) {
    return ledgerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LedgerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LedgerRepository>(value),
    );
  }
}

String _$ledgerRepositoryHash() => r'e5025d3284de645dbf905ce516be4efbd670c646';

/// Paydays.

@ProviderFor(paydayRepository)
final paydayRepositoryProvider = PaydayRepositoryProvider._();

/// Paydays.

final class PaydayRepositoryProvider
    extends
        $FunctionalProvider<
          PaydayRepository,
          PaydayRepository,
          PaydayRepository
        >
    with $Provider<PaydayRepository> {
  /// Paydays.
  PaydayRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paydayRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paydayRepositoryHash();

  @$internal
  @override
  $ProviderElement<PaydayRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PaydayRepository create(Ref ref) {
    return paydayRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaydayRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaydayRepository>(value),
    );
  }
}

String _$paydayRepositoryHash() => r'ec7029c26f08566f95eb1ded55acf66ab5531582';

/// Side-hustle money held until month end.

@ProviderFor(heldIncomeRepository)
final heldIncomeRepositoryProvider = HeldIncomeRepositoryProvider._();

/// Side-hustle money held until month end.

final class HeldIncomeRepositoryProvider
    extends
        $FunctionalProvider<
          HeldIncomeRepository,
          HeldIncomeRepository,
          HeldIncomeRepository
        >
    with $Provider<HeldIncomeRepository> {
  /// Side-hustle money held until month end.
  HeldIncomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'heldIncomeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$heldIncomeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HeldIncomeRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HeldIncomeRepository create(Ref ref) {
    return heldIncomeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HeldIncomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HeldIncomeRepository>(value),
    );
  }
}

String _$heldIncomeRepositoryHash() =>
    r'debf72f05e15566f5b1b805375907df0c0a2f660';

/// Goals.

@ProviderFor(goalRepository)
final goalRepositoryProvider = GoalRepositoryProvider._();

/// Goals.

final class GoalRepositoryProvider
    extends $FunctionalProvider<GoalRepository, GoalRepository, GoalRepository>
    with $Provider<GoalRepository> {
  /// Goals.
  GoalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalRepositoryHash();

  @$internal
  @override
  $ProviderElement<GoalRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoalRepository create(Ref ref) {
    return goalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoalRepository>(value),
    );
  }
}

String _$goalRepositoryHash() => r'204901b7efea091cca5223f4b79c83f60fb236a8';

/// Check-ins.

@ProviderFor(checkInRepository)
final checkInRepositoryProvider = CheckInRepositoryProvider._();

/// Check-ins.

final class CheckInRepositoryProvider
    extends
        $FunctionalProvider<
          CheckInRepository,
          CheckInRepository,
          CheckInRepository
        >
    with $Provider<CheckInRepository> {
  /// Check-ins.
  CheckInRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInRepositoryHash();

  @$internal
  @override
  $ProviderElement<CheckInRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckInRepository create(Ref ref) {
    return checkInRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckInRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckInRepository>(value),
    );
  }
}

String _$checkInRepositoryHash() => r'6da9a98e1bbf5ba7aa29608fbb66ca9e10495313';

/// Payment alerts.

@ProviderFor(alertRepository)
final alertRepositoryProvider = AlertRepositoryProvider._();

/// Payment alerts.

final class AlertRepositoryProvider
    extends
        $FunctionalProvider<AlertRepository, AlertRepository, AlertRepository>
    with $Provider<AlertRepository> {
  /// Payment alerts.
  AlertRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alertRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alertRepositoryHash();

  @$internal
  @override
  $ProviderElement<AlertRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AlertRepository create(Ref ref) {
    return alertRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlertRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlertRepository>(value),
    );
  }
}

String _$alertRepositoryHash() => r'67a43ac2bf0879c5bea1daaea45b0a65f3dec28d';

/// Transactions and withdrawals.

@ProviderFor(transactionRepository)
final transactionRepositoryProvider = TransactionRepositoryProvider._();

/// Transactions and withdrawals.

final class TransactionRepositoryProvider
    extends
        $FunctionalProvider<
          TransactionRepository,
          TransactionRepository,
          TransactionRepository
        >
    with $Provider<TransactionRepository> {
  /// Transactions and withdrawals.
  TransactionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRepositoryHash();

  @$internal
  @override
  $ProviderElement<TransactionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRepository create(Ref ref) {
    return transactionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRepository>(value),
    );
  }
}

String _$transactionRepositoryHash() =>
    r'7b121427395a681ee5420b795e579161f00cb671';

/// Merchant rules.

@ProviderFor(merchantRuleRepository)
final merchantRuleRepositoryProvider = MerchantRuleRepositoryProvider._();

/// Merchant rules.

final class MerchantRuleRepositoryProvider
    extends
        $FunctionalProvider<
          MerchantRuleRepository,
          MerchantRuleRepository,
          MerchantRuleRepository
        >
    with $Provider<MerchantRuleRepository> {
  /// Merchant rules.
  MerchantRuleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'merchantRuleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$merchantRuleRepositoryHash();

  @$internal
  @override
  $ProviderElement<MerchantRuleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MerchantRuleRepository create(Ref ref) {
    return merchantRuleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MerchantRuleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MerchantRuleRepository>(value),
    );
  }
}

String _$merchantRuleRepositoryHash() =>
    r'b2dbefb64db54f7d1fe86afd567fa1967d645d38';

/// Scanned receipts.

@ProviderFor(receiptRepository)
final receiptRepositoryProvider = ReceiptRepositoryProvider._();

/// Scanned receipts.

final class ReceiptRepositoryProvider
    extends
        $FunctionalProvider<
          ReceiptRepository,
          ReceiptRepository,
          ReceiptRepository
        >
    with $Provider<ReceiptRepository> {
  /// Scanned receipts.
  ReceiptRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReceiptRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReceiptRepository create(Ref ref) {
    return receiptRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReceiptRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReceiptRepository>(value),
    );
  }
}

String _$receiptRepositoryHash() => r'254f3fa08db2f6eb7ab3a13c62de7cdd589ee759';

/// Planned purchases and wishes.

@ProviderFor(planningRepository)
final planningRepositoryProvider = PlanningRepositoryProvider._();

/// Planned purchases and wishes.

final class PlanningRepositoryProvider
    extends
        $FunctionalProvider<
          PlanningRepository,
          PlanningRepository,
          PlanningRepository
        >
    with $Provider<PlanningRepository> {
  /// Planned purchases and wishes.
  PlanningRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planningRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planningRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlanningRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlanningRepository create(Ref ref) {
    return planningRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlanningRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlanningRepository>(value),
    );
  }
}

String _$planningRepositoryHash() =>
    r'186476e66a20b31fb753efbae5b59d8629e207f2';

/// The native payment-notification listener (DA-08).

@ProviderFor(androidAlertSource)
final androidAlertSourceProvider = AndroidAlertSourceProvider._();

/// The native payment-notification listener (DA-08).

final class AndroidAlertSourceProvider
    extends
        $FunctionalProvider<
          AndroidPaymentAlertSource,
          AndroidPaymentAlertSource,
          AndroidPaymentAlertSource
        >
    with $Provider<AndroidPaymentAlertSource> {
  /// The native payment-notification listener (DA-08).
  AndroidAlertSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'androidAlertSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$androidAlertSourceHash();

  @$internal
  @override
  $ProviderElement<AndroidPaymentAlertSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AndroidPaymentAlertSource create(Ref ref) {
    return androidAlertSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AndroidPaymentAlertSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AndroidPaymentAlertSource>(value),
    );
  }
}

String _$androidAlertSourceHash() =>
    r'b67dfc788427b2e0e0bfe9e53a341058130f94da';

/// Captured payment notifications.

@ProviderFor(paymentAlertSource)
final paymentAlertSourceProvider = PaymentAlertSourceProvider._();

/// Captured payment notifications.

final class PaymentAlertSourceProvider
    extends
        $FunctionalProvider<
          PaymentAlertSource,
          PaymentAlertSource,
          PaymentAlertSource
        >
    with $Provider<PaymentAlertSource> {
  /// Captured payment notifications.
  PaymentAlertSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentAlertSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentAlertSourceHash();

  @$internal
  @override
  $ProviderElement<PaymentAlertSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PaymentAlertSource create(Ref ref) {
    return paymentAlertSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentAlertSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentAlertSource>(value),
    );
  }
}

String _$paymentAlertSourceHash() =>
    r'c77f7230f2c5a4ea05354301f7e9a78433f6fd69';

/// The local notifications plugin.

@ProviderFor(notificationsApi)
final notificationsApiProvider = NotificationsApiProvider._();

/// The local notifications plugin.

final class NotificationsApiProvider
    extends
        $FunctionalProvider<
          NotificationsApi,
          NotificationsApi,
          NotificationsApi
        >
    with $Provider<NotificationsApi> {
  /// The local notifications plugin.
  NotificationsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsApiHash();

  @$internal
  @override
  $ProviderElement<NotificationsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationsApi create(Ref ref) {
    return notificationsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsApi>(value),
    );
  }
}

String _$notificationsApiHash() => r'2e479de5580a11fef0c5d431aa4b0a3d0c94213c';

/// Shows and schedules notifications.

@ProviderFor(notificationScheduler)
final notificationSchedulerProvider = NotificationSchedulerProvider._();

/// Shows and schedules notifications.

final class NotificationSchedulerProvider
    extends
        $FunctionalProvider<
          NotificationScheduler,
          NotificationScheduler,
          NotificationScheduler
        >
    with $Provider<NotificationScheduler> {
  /// Shows and schedules notifications.
  NotificationSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationSchedulerHash();

  @$internal
  @override
  $ProviderElement<NotificationScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationScheduler create(Ref ref) {
    return notificationScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationScheduler>(value),
    );
  }
}

String _$notificationSchedulerHash() =>
    r'8f83853889018b8361f671f56e59ccf4aad67f6b';

/// Permissions (screen 06).

@ProviderFor(permissionGateway)
final permissionGatewayProvider = PermissionGatewayProvider._();

/// Permissions (screen 06).

final class PermissionGatewayProvider
    extends
        $FunctionalProvider<
          PermissionGateway,
          PermissionGateway,
          PermissionGateway
        >
    with $Provider<PermissionGateway> {
  /// Permissions (screen 06).
  PermissionGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'permissionGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$permissionGatewayHash();

  @$internal
  @override
  $ProviderElement<PermissionGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PermissionGateway create(Ref ref) {
    return permissionGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PermissionGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PermissionGateway>(value),
    );
  }
}

String _$permissionGatewayHash() => r'e1217dca0efa9f904329427a371fb8c46e5eb11f';

/// On-device OCR.

@ProviderFor(textRecognizer)
final textRecognizerProvider = TextRecognizerProvider._();

/// On-device OCR.

final class TextRecognizerProvider
    extends $FunctionalProvider<TextRecognizer, TextRecognizer, TextRecognizer>
    with $Provider<TextRecognizer> {
  /// On-device OCR.
  TextRecognizerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'textRecognizerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$textRecognizerHash();

  @$internal
  @override
  $ProviderElement<TextRecognizer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TextRecognizer create(Ref ref) {
    return textRecognizer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TextRecognizer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TextRecognizer>(value),
    );
  }
}

String _$textRecognizerHash() => r'fa181d5c8dd1718a2f080826434b9525cceb096e';

/// Receipt OCR text parser: blocked on receipt fixtures (Open question 10).

@ProviderFor(receiptTextParser)
final receiptTextParserProvider = ReceiptTextParserProvider._();

/// Receipt OCR text parser: blocked on receipt fixtures (Open question 10).

final class ReceiptTextParserProvider
    extends
        $FunctionalProvider<
          ReceiptTextParser,
          ReceiptTextParser,
          ReceiptTextParser
        >
    with $Provider<ReceiptTextParser> {
  /// Receipt OCR text parser: blocked on receipt fixtures (Open question 10).
  ReceiptTextParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptTextParserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptTextParserHash();

  @$internal
  @override
  $ProviderElement<ReceiptTextParser> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReceiptTextParser create(Ref ref) {
    return receiptTextParser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReceiptTextParser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReceiptTextParser>(value),
    );
  }
}

String _$receiptTextParserHash() => r'67eb5aa05e5303a66dca9bb08309f7b132251cb5';

/// Camera and gallery.

@ProviderFor(imageCapture)
final imageCaptureProvider = ImageCaptureProvider._();

/// Camera and gallery.

final class ImageCaptureProvider
    extends $FunctionalProvider<ImageCapture, ImageCapture, ImageCapture>
    with $Provider<ImageCapture> {
  /// Camera and gallery.
  ImageCaptureProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageCaptureProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageCaptureHash();

  @$internal
  @override
  $ProviderElement<ImageCapture> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ImageCapture create(Ref ref) {
    return imageCapture(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageCapture value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageCapture>(value),
    );
  }
}

String _$imageCaptureHash() => r'b36a88acc6affd76ee0fade74bac8c10a9b06495';

/// The app lock.

@ProviderFor(appLock)
final appLockProvider = AppLockProvider._();

/// The app lock.

final class AppLockProvider
    extends $FunctionalProvider<AppLock, AppLock, AppLock>
    with $Provider<AppLock> {
  /// The app lock.
  AppLockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockHash();

  @$internal
  @override
  $ProviderElement<AppLock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLock create(Ref ref) {
    return appLock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLock>(value),
    );
  }
}

String _$appLockHash() => r'be3f8ebd4976f75ccbb6ba17a0f25280d658f88f';

/// The local profile.

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

/// The local profile.

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  /// The local profile.
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'19993b908971567f5e7dc1a7fc48318dbed68fb0';

/// Spending categories.

@ProviderFor(categoryRepository)
final categoryRepositoryProvider = CategoryRepositoryProvider._();

/// Spending categories.

final class CategoryRepositoryProvider
    extends
        $FunctionalProvider<
          CategoryRepository,
          CategoryRepository,
          CategoryRepository
        >
    with $Provider<CategoryRepository> {
  /// Spending categories.
  CategoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoryRepository create(Ref ref) {
    return categoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryRepository>(value),
    );
  }
}

String _$categoryRepositoryHash() =>
    r'4894c76a94ade9464980212e81063edc44f21daf';

/// Bundled help content.

@ProviderFor(helpContentRepository)
final helpContentRepositoryProvider = HelpContentRepositoryProvider._();

/// Bundled help content.

final class HelpContentRepositoryProvider
    extends
        $FunctionalProvider<
          HelpContentRepository,
          HelpContentRepository,
          HelpContentRepository
        >
    with $Provider<HelpContentRepository> {
  /// Bundled help content.
  HelpContentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'helpContentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$helpContentRepositoryHash();

  @$internal
  @override
  $ProviderElement<HelpContentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HelpContentRepository create(Ref ref) {
    return helpContentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HelpContentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HelpContentRepository>(value),
    );
  }
}

String _$helpContentRepositoryHash() =>
    r'7cc058f7c29d5ee48de9e211d25d391a97580880';

/// On-device storage facts (Data & privacy).

@ProviderFor(storageManager)
final storageManagerProvider = StorageManagerProvider._();

/// On-device storage facts (Data & privacy).

final class StorageManagerProvider
    extends $FunctionalProvider<StorageManager, StorageManager, StorageManager>
    with $Provider<StorageManager> {
  /// On-device storage facts (Data & privacy).
  StorageManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageManagerHash();

  @$internal
  @override
  $ProviderElement<StorageManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StorageManager create(Ref ref) {
    return storageManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageManager>(value),
    );
  }
}

String _$storageManagerHash() => r'cf463d2547b9d2b33a5002261581f4e46bca5ef1';

/// Wipes all data for Delete all data (R-PRIV-4).

@ProviderFor(dataWiper)
final dataWiperProvider = DataWiperProvider._();

/// Wipes all data for Delete all data (R-PRIV-4).

final class DataWiperProvider
    extends $FunctionalProvider<DataWiper, DataWiper, DataWiper>
    with $Provider<DataWiper> {
  /// Wipes all data for Delete all data (R-PRIV-4).
  DataWiperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataWiperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataWiperHash();

  @$internal
  @override
  $ProviderElement<DataWiper> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DataWiper create(Ref ref) {
    return dataWiper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataWiper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataWiper>(value),
    );
  }
}

String _$dataWiperHash() => r'6bdd2c198861f2143c2ed7e65f007be9d400bd71';

/// The device time zone id (About you).

@ProviderFor(deviceTimeZone)
final deviceTimeZoneProvider = DeviceTimeZoneProvider._();

/// The device time zone id (About you).

final class DeviceTimeZoneProvider
    extends $FunctionalProvider<DeviceTimeZone, DeviceTimeZone, DeviceTimeZone>
    with $Provider<DeviceTimeZone> {
  /// The device time zone id (About you).
  DeviceTimeZoneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceTimeZoneProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceTimeZoneHash();

  @$internal
  @override
  $ProviderElement<DeviceTimeZone> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeviceTimeZone create(Ref ref) {
    return deviceTimeZone(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceTimeZone value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceTimeZone>(value),
    );
  }
}

String _$deviceTimeZoneHash() => r'016cff8dd6a987fccd0ab3fc669a2209a5498ad5';

/// Opens the email app for a problem report.

@ProviderFor(emailComposer)
final emailComposerProvider = EmailComposerProvider._();

/// Opens the email app for a problem report.

final class EmailComposerProvider
    extends $FunctionalProvider<EmailComposer, EmailComposer, EmailComposer>
    with $Provider<EmailComposer> {
  /// Opens the email app for a problem report.
  EmailComposerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailComposerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailComposerHash();

  @$internal
  @override
  $ProviderElement<EmailComposer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EmailComposer create(Ref ref) {
    return emailComposer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailComposer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailComposer>(value),
    );
  }
}

String _$emailComposerHash() => r'2b03df42e4cb5536e1b550ad91a47f55df905983';

/// Opens system and store screens from help and about.

@ProviderFor(systemSettingsOpener)
final systemSettingsOpenerProvider = SystemSettingsOpenerProvider._();

/// Opens system and store screens from help and about.

final class SystemSettingsOpenerProvider
    extends
        $FunctionalProvider<
          SystemSettingsOpener,
          SystemSettingsOpener,
          SystemSettingsOpener
        >
    with $Provider<SystemSettingsOpener> {
  /// Opens system and store screens from help and about.
  SystemSettingsOpenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemSettingsOpenerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemSettingsOpenerHash();

  @$internal
  @override
  $ProviderElement<SystemSettingsOpener> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SystemSettingsOpener create(Ref ref) {
    return systemSettingsOpener(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemSettingsOpener value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemSettingsOpener>(value),
    );
  }
}

String _$systemSettingsOpenerHash() =>
    r'964573e7794ea2e267ad98b566148a0f4d8beaaa';

/// Reads the whitelisted app and device facts.

@ProviderFor(appInfoReader)
final appInfoReaderProvider = AppInfoReaderProvider._();

/// Reads the whitelisted app and device facts.

final class AppInfoReaderProvider
    extends $FunctionalProvider<AppInfoReader, AppInfoReader, AppInfoReader>
    with $Provider<AppInfoReader> {
  /// Reads the whitelisted app and device facts.
  AppInfoReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInfoReaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInfoReaderHash();

  @$internal
  @override
  $ProviderElement<AppInfoReader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppInfoReader create(Ref ref) {
    return appInfoReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppInfoReader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppInfoReader>(value),
    );
  }
}

String _$appInfoReaderHash() => r'7db2c0f26e46847feeb30ca4ca97a562b728a648';

/// SMS templates: none until fixtures exist (D-06a/b, Open question 1).

@ProviderFor(smsParser)
final smsParserProvider = SmsParserProvider._();

/// SMS templates: none until fixtures exist (D-06a/b, Open question 1).

final class SmsParserProvider
    extends $FunctionalProvider<SmsParser, SmsParser, SmsParser>
    with $Provider<SmsParser> {
  /// SMS templates: none until fixtures exist (D-06a/b, Open question 1).
  SmsParserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsParserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsParserHash();

  @$internal
  @override
  $ProviderElement<SmsParser> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SmsParser create(Ref ref) {
    return smsParser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmsParser value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmsParser>(value),
    );
  }
}

String _$smsParserHash() => r'bc98299a7fcdfba297eec02d306adde370e131bd';

/// Android package → provider for captured notifications (Open question 2).

@ProviderFor(packageSources)
final packageSourcesProvider = PackageSourcesProvider._();

/// Android package → provider for captured notifications (Open question 2).

final class PackageSourcesProvider
    extends
        $FunctionalProvider<
          Map<String, AlertSource>,
          Map<String, AlertSource>,
          Map<String, AlertSource>
        >
    with $Provider<Map<String, AlertSource>> {
  /// Android package → provider for captured notifications (Open question 2).
  PackageSourcesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packageSourcesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packageSourcesHash();

  @$internal
  @override
  $ProviderElement<Map<String, AlertSource>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, AlertSource> create(Ref ref) {
    return packageSources(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, AlertSource> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, AlertSource>>(value),
    );
  }
}

String _$packageSourcesHash() => r'1f370f2db870d90827ee33513b0cc5bfeecd49b5';
