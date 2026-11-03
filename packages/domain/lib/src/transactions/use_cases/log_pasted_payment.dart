import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/use_cases/categorize_alert.dart';
import 'package:buckets_domain/src/transactions/use_cases/spend_writer.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Logs a payment from a pasted message (screen 19, paste tab).
final class LogPastedPayment {
  /// Creates the use case.
  const new(this._accounts, this._writer, this._ids, this._clock);

  final AccountRepository _accounts;
  final SpendWriter _writer;
  final IdGenerator _ids;
  final Clock _clock;

  /// The saved transaction from [parsed]; [amount] overrides a missing or
  /// wrong amount; the fee is its own transaction.
  Future<Result<Transaction>> call({
    required ParsedMessage parsed,
    required Category category,
    required String bucketId,
    AlertSource source = AlertSource.unknown,
    Money? amount,
    String? note,
  }) => attempt(() async {
    final money = amount ?? parsed.amount;
    if (money == null) {
      unwrap<void>(
        const Err(ValidationFailure('amount.missing', 'Enter the amount.')),
      );
    }
    final account = CategorizeAlert.accountFor(
      source,
      unwrap(await _accounts.getAll()),
    );
    return unwrap<Transaction>(
      await _writer.write(
        unwrap(
          Transaction.create(
            id: _ids.newId(),
            amount: money!,
            bucketId: bucketId,
            category: category,
            accountId: account.id,
            occurredAt: parsed.occurredAt ?? _clock.now(),
            source: TransactionSource.pasted,
            note: note,
          ),
        ),
        fee: parsed.fee,
      ),
    );
  });
}
