import 'dart:async';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// Pending learned fee changes, kept in memory. They are lost when the app
/// closes; the same message re-offers the change next time it is seen.
/// shortcut: not persisted, move to a Drift table if users lose changes.
class InMemoryPendingFeeChanges implements PendingFeeChanges {
  final _items = <String, PendingFeeChange>{};
  final _changes = StreamController<void>.broadcast();

  String _key(AlertSource p, FeeType t, Money min) =>
      '${p.name}/${t.name}/${min.ngwee}';

  List<PendingFeeChange> get _all => _items.values.toList();

  @override
  Future<Result<void>> add(PendingFeeChange change) async {
    _items[_key(
          change.provider,
          change.feeType,
          change.change.band.minAmount,
        )] =
        change;
    _changes.add(null);
    return const Ok(null);
  }

  @override
  Future<Result<void>> remove({
    required AlertSource provider,
    required FeeType feeType,
    required Money min,
  }) async {
    _items.remove(_key(provider, feeType, min));
    _changes.add(null);
    return const Ok(null);
  }

  @override
  Stream<List<PendingFeeChange>> watchAll() {
    late StreamController<List<PendingFeeChange>> out;
    StreamSubscription<void>? sub;
    out = StreamController(
      onListen: () {
        out.add(_all);
        sub = _changes.stream.listen((_) => out.add(_all));
      },
      onCancel: () => sub?.cancel(),
    );
    return out.stream;
  }
}
