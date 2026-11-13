import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart' show ok;

// Builds a minimal in-memory ledger stub backed by a list.
class _Ledger implements LedgerRepository {
  _Ledger(this._entries);

  final List<LedgerEntry> _entries;

  @override
  Future<Result<void>> append(List<LedgerEntry> entries) async {
    _entries.addAll(entries);
    return const Ok(null);
  }

  @override
  Future<Result<List<LedgerEntry>>> getEntries({
    String? bucketId,
    DateWindow? window,
  }) async => Ok(List.unmodifiable(_entries));

  @override
  Stream<List<LedgerEntry>> watchEntries({
    String? bucketId,
    DateWindow? window,
  }) => Stream.value(List.unmodifiable(_entries));
}

LedgerEntry _spend(String id, DateTime at, int ngwee, [String? bucketId]) =>
    ok(LedgerEntry.create(
      id: id,
      occurredAt: at,
      kind: LedgerEntryKind.spend,
      bucketId: bucketId ?? 'b1',
      amount: Money(-ngwee),
    ));

LedgerEntry _reversal(String id, DateTime at, String reversesId,
        [int ngwee = 0]) =>
    ok(LedgerEntry.create(
      id: id,
      occurredAt: at,
      kind: LedgerEntryKind.reversal,
      bucketId: 'b1',
      amount: Money(ngwee),
      reversesEntryId: reversesId,
    ));

void main() {
  group('WatchSpendHistory', () {
    test('groups spend entries by calendar month, most recent first', () async {
      final oct = DateTime.utc(2026, 10, 15, 8);
      final nov = DateTime.utc(2026, 11, 3, 10);
      final entries = [
        _spend('e1', oct, 50000), // K 500 in Oct
        _spend('e2', oct, 30000), // K 300 in Oct
        _spend('e3', nov, 20000), // K 200 in Nov
      ];
      final history = await WatchSpendHistory(_Ledger(entries)).call().first;

      expect(history.months, hasLength(2));
      expect(history.months[0].year, 2026);
      expect(history.months[0].month, 11);
      expect(history.months[0].total, const Money(20000));
      expect(history.months[1].year, 2026);
      expect(history.months[1].month, 10);
      expect(history.months[1].total, const Money(80000));
      expect(history.allTime, const Money(100000));
    });

    test('reversed spend entries are netted out', () async {
      final at = DateTime.utc(2026, 10, 10, 8);
      final entries = [
        _spend('e1', at, 60000),
        _spend('e2', at, 40000),
        _reversal('r1', at, 'e2'), // cancels e2
      ];
      final history = await WatchSpendHistory(_Ledger(entries)).call().first;

      expect(history.months, hasLength(1));
      expect(history.months[0].total, const Money(60000));
      expect(history.allTime, const Money(60000));
    });

    test('empty ledger returns empty history with zero all-time', () async {
      final history = await WatchSpendHistory(_Ledger([])).call().first;
      expect(history.months, isEmpty);
      expect(history.allTime, Money.zero);
    });
  });
}
