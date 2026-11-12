import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/mappers/results.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// Row ⇄ entity for bill occurrences and fee rates. Entities are rebuilt
/// through their validating factories, so a corrupt row is an `Err`.
abstract final class BillFeeMappers {
  /// `yyyy-MM-dd`, which also sorts correctly as text.
  static String date(LocalDate d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  static LocalDate? _parse(String text) {
    final p = text.split('-').map(int.tryParse).toList();
    return p.length == 3 && !p.contains(null)
        ? LocalDate(p[0]!, p[1]!, p[2]!)
        : null;
  }

  /// An occurrence from its row.
  static Result<BillOccurrence> occurrence(BillOccurrenceRow r) {
    final cycle = _parse(r.cycleStart);
    final due = _parse(r.dueDate);
    if (cycle == null || due == null) {
      return const Err(
        StorageFailure('storage', 'A bill date was unreadable.'),
      );
    }
    return BillOccurrence.create(
      id: r.id,
      billId: r.billId,
      cycleStart: cycle,
      dueDate: due,
      expectedAmount: Money(r.expectedAmount),
      status: r.status,
      paidAmount: r.paidAmount == null ? null : Money(r.paidAmount!),
      paidAt: r.paidAt,
      accountId: r.accountId,
      feeTransactionId: r.feeTransactionId,
      proofRef: r.proofRef,
    );
  }

  /// The row for [o].
  static BillOccurrencesCompanion occurrenceRow(BillOccurrence o) =>
      BillOccurrencesCompanion.insert(
        id: o.id,
        billId: o.billId,
        cycleStart: date(o.cycleStart),
        dueDate: date(o.dueDate),
        expectedAmount: o.expectedAmount.ngwee,
        status: o.status,
        paidAmount: Value(o.paidAmount?.ngwee),
        paidAt: Value(o.paidAt),
        accountId: Value(o.accountId),
        feeTransactionId: Value(o.feeTransactionId),
        proofRef: Value(o.proofRef),
      );

  /// A tariff from its header and its band rows.
  static Result<FeeTariff> tariff(FeeTariffRow t, List<FeeBandRow> bands) {
    final built = collectAll([
      for (final b in bands)
        if (b.provider == t.provider && b.feeType == t.feeType)
          FeeBand.create(
            minAmount: Money(b.minAmount),
            maxAmount: Money(b.maxAmount),
            fee: Money(b.fee),
            source: b.source,
            observations: b.observations,
          ),
    ]);
    return switch (built) {
      Ok(:final value) => FeeTariff.create(
        provider: t.provider,
        feeType: t.feeType,
        bands: value,
      ),
      Err(:final failure) => Err(failure),
    };
  }

  /// The header row for [t].
  static FeeTariffsCompanion tariffRow(FeeTariff t) =>
      FeeTariffsCompanion.insert(provider: t.provider, feeType: t.feeType);

  /// The band rows for [t].
  static List<FeeBandsCompanion> bandRows(FeeTariff t) => [
    for (final b in t.bands)
      FeeBandsCompanion.insert(
        provider: t.provider,
        feeType: t.feeType,
        minAmount: b.minAmount.ngwee,
        maxAmount: b.maxAmount.ngwee,
        fee: b.fee.ngwee,
        source: b.source,
        observations: Value(b.observations),
      ),
  ];
}
