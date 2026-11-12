// Column getters describe themselves; each table is documented instead.
// ignore_for_file: public_member_api_docs

import 'package:buckets_domain/buckets_domain.dart'
    show AlertSource, BillStatus, FeeBandSource, FeeType;
import 'package:drift/drift.dart';

/// One bill in one pay cycle (DOMAIN R-BILL-6). Dates are `yyyy-MM-dd`.
@DataClassName('BillOccurrenceRow')
class BillOccurrences extends Table {
  TextColumn get id => text()();
  TextColumn get billId => text()();
  TextColumn get cycleStart => text()();
  TextColumn get dueDate => text()();
  IntColumn get expectedAmount => integer()();
  TextColumn get status => textEnum<BillStatus>()();
  IntColumn get paidAmount => integer().nullable()();
  DateTimeColumn get paidAt => dateTime().nullable()();
  TextColumn get accountId => text().nullable()();
  TextColumn get feeTransactionId => text().nullable()();
  TextColumn get proofRef => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  // One occurrence per bill per cycle.
  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {billId, cycleStart},
  ];
}

/// A provider and fee type that has fee rates (DOMAIN R-FEE-3); its bands
/// are in [FeeBands]. Kept so a tariff can exist with no bands.
@DataClassName('FeeTariffRow')
class FeeTariffs extends Table {
  TextColumn get provider => textEnum<AlertSource>()();
  TextColumn get feeType => textEnum<FeeType>()();

  @override
  Set<Column<Object>> get primaryKey => {provider, feeType};
}

/// The fee for amounts from [minAmount] to [maxAmount], ends included.
@DataClassName('FeeBandRow')
class FeeBands extends Table {
  TextColumn get provider => textEnum<AlertSource>()();
  TextColumn get feeType => textEnum<FeeType>()();
  IntColumn get minAmount => integer()();
  IntColumn get maxAmount => integer()();
  IntColumn get fee => integer()();
  TextColumn get source => textEnum<FeeBandSource>()();
  IntColumn get observations => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {provider, feeType, minAmount};
}
