import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/receipts/ports/receipt_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/use_cases/spend_writer.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';
import 'package:buckets_domain/src/transactions/value_objects/transaction_line.dart';

/// Saves a reviewed receipt as a transaction, split across buckets
/// (screen 21, R-SPEND-1).
final class SaveReceipt {
  /// Creates the use case.
  const SaveReceipt(
    this._receipts,
    this._accounts,
    this._writer,
    this._ids,
    this._clock,
  );

  final ReceiptRepository _receipts;
  final AccountRepository _accounts;
  final SpendWriter _writer;
  final IdGenerator _ids;
  final Clock _clock;

  /// The transaction for [total] paid from [accountId] (default the
  /// spending account). [lines] split it across buckets and must add up to
  /// [total]; without lines it all comes from [bucketId].
  Future<Result<Transaction>> call({
    required String receiptId,
    required Money total,
    required Category category,
    required String bucketId,
    List<TransactionLine> lines = const [],
    String? accountId,
    DateTime? occurredAt,
  }) => attempt(() async {
    final receipt = unwrap(await _receipts.get(receiptId));
    final account =
        accountId ??
        unwrap(await _accounts.getAll()).firstWhere((a) => a.isSpending).id;
    return unwrap(
      await _writer.write(
        unwrap(
          Transaction.create(
            id: _ids.newId(),
            amount: total,
            bucketId: bucketId,
            category: category,
            accountId: account,
            occurredAt: occurredAt ?? receipt.draft.date?.value ?? _clock.now(),
            source: TransactionSource.receipt,
            receiptId: receipt.id,
            lines: lines,
          ),
        ),
      ),
    );
  });
}
