// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dao.dart';

// ignore_for_file: type=lint
mixin _$TransactionDaoMixin on DatabaseAccessor<BucketsDatabase> {
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $TransactionLinesTable get transactionLines =>
      attachedDatabase.transactionLines;
  TransactionDaoManager get managers => TransactionDaoManager(this);
}

class TransactionDaoManager {
  final _$TransactionDaoMixin _db;
  TransactionDaoManager(this._db);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$TransactionLinesTableTableManager get transactionLines =>
      $$TransactionLinesTableTableManager(
        _db.attachedDatabase,
        _db.transactionLines,
      );
}
