import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';
import 'package:buckets_domain/src/bills/ports/bill_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Adds or edits a bill (screen 03). It is paid from Living unless another
/// bucket is chosen.
final class SaveBill {
  /// Creates the use case.
  const new(this._bills, this._buckets, this._ids);

  final BillRepository _bills;
  final BucketRepository _buckets;
  final IdGenerator _ids;

  /// The saved bill. Pass [id] to edit an existing one.
  Future<Result<Bill>> call({
    required String name,
    required Money amount,
    required BillFrequency frequency,
    String? id,
    int? dueDay,
    DateTime? nextDueDate,
    String? paidFromBucketId,
    String? payeeAccountHint,
  }) => attempt(() async {
    final payer =
        paidFromBucketId ??
        unwrap(await _buckets.getAll())
            .firstWhere((b) => b.kind == BucketKind.living)
            .id;
    final bill = unwrap(
      Bill.create(
        id: id ?? _ids.newId(),
        name: name,
        amount: amount,
        frequency: frequency,
        dueDay: dueDay,
        nextDueDate: nextDueDate,
        paidFromBucketId: payer,
        payeeAccountHint: payeeAccountHint,
      ),
    );
    unwrap(await _bills.save(bill));
    return bill;
  });
}
