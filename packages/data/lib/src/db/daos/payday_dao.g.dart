// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payday_dao.dart';

// ignore_for_file: type=lint
mixin _$PaydayDaoMixin on DatabaseAccessor<BucketsDatabase> {
  $PaydaysTable get paydays => attachedDatabase.paydays;
  $TransfersTable get transfers => attachedDatabase.transfers;
  $TransferProofRefsTable get transferProofRefs =>
      attachedDatabase.transferProofRefs;
  PaydayDaoManager get managers => PaydayDaoManager(this);
}

class PaydayDaoManager {
  final _$PaydayDaoMixin _db;
  PaydayDaoManager(this._db);
  $$PaydaysTableTableManager get paydays =>
      $$PaydaysTableTableManager(_db.attachedDatabase, _db.paydays);
  $$TransfersTableTableManager get transfers =>
      $$TransfersTableTableManager(_db.attachedDatabase, _db.transfers);
  $$TransferProofRefsTableTableManager get transferProofRefs =>
      $$TransferProofRefsTableTableManager(
        _db.attachedDatabase,
        _db.transferProofRefs,
      );
}
