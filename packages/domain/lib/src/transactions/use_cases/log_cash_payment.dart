import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/use_cases/spend_writer.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Logs a cash payment from Cash in hand (screen 19, R-SPEND-4).
final class LogCashPayment {
  /// Creates the use case.
  const new(this._accounts, this._writer, this._ids, this._clock);

  final AccountRepository _accounts;
  final SpendWriter _writer;
  final IdGenerator _ids;
  final Clock _clock;

  /// The saved transaction; [occurredAt] defaults to now.
  Future<Result<Transaction>> call({
    required Money amount,
    required Category category,
    required String bucketId,
    DateTime? occurredAt,
    String? note,
    String? billId,
  }) => attempt(() async {
    final cash = unwrap(await _accounts.getAll())
        .firstWhere((a) => a.kind == AccountKind.cash);
    return unwrap<Transaction>(
      await _writer.write(
        unwrap(
          Transaction.create(
            id: _ids.newId(),
            amount: amount,
            bucketId: bucketId,
            category: category,
            accountId: cash.id,
            occurredAt: occurredAt ?? _clock.now(),
            source: TransactionSource.cash,
            note: note,
            billId: billId,
          ),
        ),
      ),
    );
  });
}
