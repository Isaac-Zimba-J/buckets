// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buckets_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountKind>($AccountsTable.$converterkind);
  static const VerificationMeta _isSpendingMeta = const VerificationMeta(
    'isSpending',
  );
  @override
  late final GeneratedColumn<bool> isSpending = GeneratedColumn<bool>(
    'is_spending',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_spending" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, kind, isSpending];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_spending')) {
      context.handle(
        _isSpendingMeta,
        isSpending.isAcceptableOrUnknown(data['is_spending']!, _isSpendingMeta),
      );
    } else if (isInserting) {
      context.missing(_isSpendingMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $AccountsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      isSpending: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_spending'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountKind, String, String> $converterkind =
      const EnumNameConverter<AccountKind>(AccountKind.values);
}

class AccountRow extends DataClass implements Insertable<AccountRow> {
  final String id;
  final String name;
  final AccountKind kind;
  final bool isSpending;
  const AccountRow({
    required this.id,
    required this.name,
    required this.kind,
    required this.isSpending,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<String>($AccountsTable.$converterkind.toSql(kind));
    }
    map['is_spending'] = Variable<bool>(isSpending);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      isSpending: Value(isSpending),
    );
  }

  factory AccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: $AccountsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      isSpending: serializer.fromJson<bool>(json['isSpending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(
        $AccountsTable.$converterkind.toJson(kind),
      ),
      'isSpending': serializer.toJson<bool>(isSpending),
    };
  }

  AccountRow copyWith({
    String? id,
    String? name,
    AccountKind? kind,
    bool? isSpending,
  }) => AccountRow(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    isSpending: isSpending ?? this.isSpending,
  );
  AccountRow copyWithCompanion(AccountsCompanion data) {
    return AccountRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      isSpending: data.isSpending.present
          ? data.isSpending.value
          : this.isSpending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('isSpending: $isSpending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, kind, isSpending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.isSpending == this.isSpending);
}

class AccountsCompanion extends UpdateCompanion<AccountRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<AccountKind> kind;
  final Value<bool> isSpending;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.isSpending = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String name,
    required AccountKind kind,
    required bool isSpending,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind),
       isSpending = Value(isSpending);
  static Insertable<AccountRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<bool>? isSpending,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (isSpending != null) 'is_spending': isSpending,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<AccountKind>? kind,
    Value<bool>? isSpending,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      isSpending: isSpending ?? this.isSpending,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $AccountsTable.$converterkind.toSql(kind.value),
      );
    }
    if (isSpending.present) {
      map['is_spending'] = Variable<bool>(isSpending.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('isSpending: $isSpending, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountMatchKeysTable extends AccountMatchKeys
    with TableInfo<$AccountMatchKeysTable, AccountMatchKeyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountMatchKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [accountId, position, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_match_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountMatchKeyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, position};
  @override
  AccountMatchKeyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountMatchKeyRow(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AccountMatchKeysTable createAlias(String alias) {
    return $AccountMatchKeysTable(attachedDatabase, alias);
  }
}

class AccountMatchKeyRow extends DataClass
    implements Insertable<AccountMatchKeyRow> {
  final String accountId;
  final int position;
  final String value;
  const AccountMatchKeyRow({
    required this.accountId,
    required this.position,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['position'] = Variable<int>(position);
    map['value'] = Variable<String>(value);
    return map;
  }

  AccountMatchKeysCompanion toCompanion(bool nullToAbsent) {
    return AccountMatchKeysCompanion(
      accountId: Value(accountId),
      position: Value(position),
      value: Value(value),
    );
  }

  factory AccountMatchKeyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountMatchKeyRow(
      accountId: serializer.fromJson<String>(json['accountId']),
      position: serializer.fromJson<int>(json['position']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'position': serializer.toJson<int>(position),
      'value': serializer.toJson<String>(value),
    };
  }

  AccountMatchKeyRow copyWith({
    String? accountId,
    int? position,
    String? value,
  }) => AccountMatchKeyRow(
    accountId: accountId ?? this.accountId,
    position: position ?? this.position,
    value: value ?? this.value,
  );
  AccountMatchKeyRow copyWithCompanion(AccountMatchKeysCompanion data) {
    return AccountMatchKeyRow(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      position: data.position.present ? data.position.value : this.position,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountMatchKeyRow(')
          ..write('accountId: $accountId, ')
          ..write('position: $position, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, position, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountMatchKeyRow &&
          other.accountId == this.accountId &&
          other.position == this.position &&
          other.value == this.value);
}

class AccountMatchKeysCompanion extends UpdateCompanion<AccountMatchKeyRow> {
  final Value<String> accountId;
  final Value<int> position;
  final Value<String> value;
  final Value<int> rowid;
  const AccountMatchKeysCompanion({
    this.accountId = const Value.absent(),
    this.position = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountMatchKeysCompanion.insert({
    required String accountId,
    required int position,
    required String value,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       position = Value(position),
       value = Value(value);
  static Insertable<AccountMatchKeyRow> custom({
    Expression<String>? accountId,
    Expression<int>? position,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (position != null) 'position': position,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountMatchKeysCompanion copyWith({
    Value<String>? accountId,
    Value<int>? position,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AccountMatchKeysCompanion(
      accountId: accountId ?? this.accountId,
      position: position ?? this.position,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountMatchKeysCompanion(')
          ..write('accountId: $accountId, ')
          ..write('position: $position, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BucketsTable extends Buckets with TableInfo<$BucketsTable, BucketRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BucketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BucketKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BucketKind>($BucketsTable.$converterkind);
  @override
  late final GeneratedColumnWithTypeConverter<BucketColor, String> color =
      GeneratedColumn<String>(
        'color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BucketColor>($BucketsTable.$convertercolor);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isProtectedMeta = const VerificationMeta(
    'isProtected',
  );
  @override
  late final GeneratedColumn<bool> isProtected = GeneratedColumn<bool>(
    'is_protected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_protected" IN (0, 1))',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    color,
    accountId,
    isProtected,
    sortOrder,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buckets';
  @override
  VerificationContext validateIntegrity(
    Insertable<BucketRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('is_protected')) {
      context.handle(
        _isProtectedMeta,
        isProtected.isAcceptableOrUnknown(
          data['is_protected']!,
          _isProtectedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isProtectedMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    } else if (isInserting) {
      context.missing(_archivedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BucketRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BucketRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $BucketsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      color: $BucketsTable.$convertercolor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}color'],
        )!,
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      isProtected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_protected'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $BucketsTable createAlias(String alias) {
    return $BucketsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BucketKind, String, String> $converterkind =
      const EnumNameConverter<BucketKind>(BucketKind.values);
  static JsonTypeConverter2<BucketColor, String, String> $convertercolor =
      const EnumNameConverter<BucketColor>(BucketColor.values);
}

class BucketRow extends DataClass implements Insertable<BucketRow> {
  final String id;
  final String name;
  final BucketKind kind;
  final BucketColor color;
  final String accountId;
  final bool isProtected;
  final int sortOrder;
  final bool archived;
  const BucketRow({
    required this.id,
    required this.name,
    required this.kind,
    required this.color,
    required this.accountId,
    required this.isProtected,
    required this.sortOrder,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<String>($BucketsTable.$converterkind.toSql(kind));
    }
    {
      map['color'] = Variable<String>(
        $BucketsTable.$convertercolor.toSql(color),
      );
    }
    map['account_id'] = Variable<String>(accountId);
    map['is_protected'] = Variable<bool>(isProtected);
    map['sort_order'] = Variable<int>(sortOrder);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  BucketsCompanion toCompanion(bool nullToAbsent) {
    return BucketsCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      color: Value(color),
      accountId: Value(accountId),
      isProtected: Value(isProtected),
      sortOrder: Value(sortOrder),
      archived: Value(archived),
    );
  }

  factory BucketRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BucketRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: $BucketsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      color: $BucketsTable.$convertercolor.fromJson(
        serializer.fromJson<String>(json['color']),
      ),
      accountId: serializer.fromJson<String>(json['accountId']),
      isProtected: serializer.fromJson<bool>(json['isProtected']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(
        $BucketsTable.$converterkind.toJson(kind),
      ),
      'color': serializer.toJson<String>(
        $BucketsTable.$convertercolor.toJson(color),
      ),
      'accountId': serializer.toJson<String>(accountId),
      'isProtected': serializer.toJson<bool>(isProtected),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  BucketRow copyWith({
    String? id,
    String? name,
    BucketKind? kind,
    BucketColor? color,
    String? accountId,
    bool? isProtected,
    int? sortOrder,
    bool? archived,
  }) => BucketRow(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    color: color ?? this.color,
    accountId: accountId ?? this.accountId,
    isProtected: isProtected ?? this.isProtected,
    sortOrder: sortOrder ?? this.sortOrder,
    archived: archived ?? this.archived,
  );
  BucketRow copyWithCompanion(BucketsCompanion data) {
    return BucketRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      color: data.color.present ? data.color.value : this.color,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      isProtected: data.isProtected.present
          ? data.isProtected.value
          : this.isProtected,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BucketRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('color: $color, ')
          ..write('accountId: $accountId, ')
          ..write('isProtected: $isProtected, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    kind,
    color,
    accountId,
    isProtected,
    sortOrder,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BucketRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.color == this.color &&
          other.accountId == this.accountId &&
          other.isProtected == this.isProtected &&
          other.sortOrder == this.sortOrder &&
          other.archived == this.archived);
}

class BucketsCompanion extends UpdateCompanion<BucketRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<BucketKind> kind;
  final Value<BucketColor> color;
  final Value<String> accountId;
  final Value<bool> isProtected;
  final Value<int> sortOrder;
  final Value<bool> archived;
  final Value<int> rowid;
  const BucketsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.color = const Value.absent(),
    this.accountId = const Value.absent(),
    this.isProtected = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BucketsCompanion.insert({
    required String id,
    required String name,
    required BucketKind kind,
    required BucketColor color,
    required String accountId,
    required bool isProtected,
    required int sortOrder,
    required bool archived,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind),
       color = Value(color),
       accountId = Value(accountId),
       isProtected = Value(isProtected),
       sortOrder = Value(sortOrder),
       archived = Value(archived);
  static Insertable<BucketRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? color,
    Expression<String>? accountId,
    Expression<bool>? isProtected,
    Expression<int>? sortOrder,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (color != null) 'color': color,
      if (accountId != null) 'account_id': accountId,
      if (isProtected != null) 'is_protected': isProtected,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BucketsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<BucketKind>? kind,
    Value<BucketColor>? color,
    Value<String>? accountId,
    Value<bool>? isProtected,
    Value<int>? sortOrder,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return BucketsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      color: color ?? this.color,
      accountId: accountId ?? this.accountId,
      isProtected: isProtected ?? this.isProtected,
      sortOrder: sortOrder ?? this.sortOrder,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $BucketsTable.$converterkind.toSql(kind.value),
      );
    }
    if (color.present) {
      map['color'] = Variable<String>(
        $BucketsTable.$convertercolor.toSql(color.value),
      );
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (isProtected.present) {
      map['is_protected'] = Variable<bool>(isProtected.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BucketsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('color: $color, ')
          ..write('accountId: $accountId, ')
          ..write('isProtected: $isProtected, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomeSourcesTable extends IncomeSources
    with TableInfo<$IncomeSourcesTable, IncomeSourceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<IncomeKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<IncomeKind>($IncomeSourcesTable.$converterkind);
  static const VerificationMeta _expectedAmountMeta = const VerificationMeta(
    'expectedAmount',
  );
  @override
  late final GeneratedColumn<int> expectedAmount = GeneratedColumn<int>(
    'expected_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduleKindMeta = const VerificationMeta(
    'scheduleKind',
  );
  @override
  late final GeneratedColumn<String> scheduleKind = GeneratedColumn<String>(
    'schedule_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduleDayMeta = const VerificationMeta(
    'scheduleDay',
  );
  @override
  late final GeneratedColumn<int> scheduleDay = GeneratedColumn<int>(
    'schedule_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduleAnchorMeta = const VerificationMeta(
    'scheduleAnchor',
  );
  @override
  late final GeneratedColumn<DateTime> scheduleAnchor =
      GeneratedColumn<DateTime>(
        'schedule_anchor',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _landsInAccountIdMeta = const VerificationMeta(
    'landsInAccountId',
  );
  @override
  late final GeneratedColumn<String> landsInAccountId = GeneratedColumn<String>(
    'lands_in_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _splitProfileIdMeta = const VerificationMeta(
    'splitProfileId',
  );
  @override
  late final GeneratedColumn<String> splitProfileId = GeneratedColumn<String>(
    'split_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deductBillsFirstMeta = const VerificationMeta(
    'deductBillsFirst',
  );
  @override
  late final GeneratedColumn<bool> deductBillsFirst = GeneratedColumn<bool>(
    'deduct_bills_first',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deduct_bills_first" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    expectedAmount,
    scheduleKind,
    scheduleDay,
    scheduleAnchor,
    landsInAccountId,
    splitProfileId,
    deductBillsFirst,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncomeSourceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('expected_amount')) {
      context.handle(
        _expectedAmountMeta,
        expectedAmount.isAcceptableOrUnknown(
          data['expected_amount']!,
          _expectedAmountMeta,
        ),
      );
    }
    if (data.containsKey('schedule_kind')) {
      context.handle(
        _scheduleKindMeta,
        scheduleKind.isAcceptableOrUnknown(
          data['schedule_kind']!,
          _scheduleKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduleKindMeta);
    }
    if (data.containsKey('schedule_day')) {
      context.handle(
        _scheduleDayMeta,
        scheduleDay.isAcceptableOrUnknown(
          data['schedule_day']!,
          _scheduleDayMeta,
        ),
      );
    }
    if (data.containsKey('schedule_anchor')) {
      context.handle(
        _scheduleAnchorMeta,
        scheduleAnchor.isAcceptableOrUnknown(
          data['schedule_anchor']!,
          _scheduleAnchorMeta,
        ),
      );
    }
    if (data.containsKey('lands_in_account_id')) {
      context.handle(
        _landsInAccountIdMeta,
        landsInAccountId.isAcceptableOrUnknown(
          data['lands_in_account_id']!,
          _landsInAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_landsInAccountIdMeta);
    }
    if (data.containsKey('split_profile_id')) {
      context.handle(
        _splitProfileIdMeta,
        splitProfileId.isAcceptableOrUnknown(
          data['split_profile_id']!,
          _splitProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_splitProfileIdMeta);
    }
    if (data.containsKey('deduct_bills_first')) {
      context.handle(
        _deductBillsFirstMeta,
        deductBillsFirst.isAcceptableOrUnknown(
          data['deduct_bills_first']!,
          _deductBillsFirstMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deductBillsFirstMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeSourceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeSourceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $IncomeSourcesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      expectedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_amount'],
      ),
      scheduleKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_kind'],
      )!,
      scheduleDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schedule_day'],
      ),
      scheduleAnchor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}schedule_anchor'],
      ),
      landsInAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lands_in_account_id'],
      )!,
      splitProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}split_profile_id'],
      )!,
      deductBillsFirst: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deduct_bills_first'],
      )!,
    );
  }

  @override
  $IncomeSourcesTable createAlias(String alias) {
    return $IncomeSourcesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<IncomeKind, String, String> $converterkind =
      const EnumNameConverter<IncomeKind>(IncomeKind.values);
}

class IncomeSourceRow extends DataClass implements Insertable<IncomeSourceRow> {
  final String id;
  final String name;
  final IncomeKind kind;
  final int? expectedAmount;
  final String scheduleKind;
  final int? scheduleDay;
  final DateTime? scheduleAnchor;
  final String landsInAccountId;
  final String splitProfileId;
  final bool deductBillsFirst;
  const IncomeSourceRow({
    required this.id,
    required this.name,
    required this.kind,
    this.expectedAmount,
    required this.scheduleKind,
    this.scheduleDay,
    this.scheduleAnchor,
    required this.landsInAccountId,
    required this.splitProfileId,
    required this.deductBillsFirst,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<String>(
        $IncomeSourcesTable.$converterkind.toSql(kind),
      );
    }
    if (!nullToAbsent || expectedAmount != null) {
      map['expected_amount'] = Variable<int>(expectedAmount);
    }
    map['schedule_kind'] = Variable<String>(scheduleKind);
    if (!nullToAbsent || scheduleDay != null) {
      map['schedule_day'] = Variable<int>(scheduleDay);
    }
    if (!nullToAbsent || scheduleAnchor != null) {
      map['schedule_anchor'] = Variable<DateTime>(scheduleAnchor);
    }
    map['lands_in_account_id'] = Variable<String>(landsInAccountId);
    map['split_profile_id'] = Variable<String>(splitProfileId);
    map['deduct_bills_first'] = Variable<bool>(deductBillsFirst);
    return map;
  }

  IncomeSourcesCompanion toCompanion(bool nullToAbsent) {
    return IncomeSourcesCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      expectedAmount: expectedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedAmount),
      scheduleKind: Value(scheduleKind),
      scheduleDay: scheduleDay == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleDay),
      scheduleAnchor: scheduleAnchor == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleAnchor),
      landsInAccountId: Value(landsInAccountId),
      splitProfileId: Value(splitProfileId),
      deductBillsFirst: Value(deductBillsFirst),
    );
  }

  factory IncomeSourceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeSourceRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: $IncomeSourcesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      expectedAmount: serializer.fromJson<int?>(json['expectedAmount']),
      scheduleKind: serializer.fromJson<String>(json['scheduleKind']),
      scheduleDay: serializer.fromJson<int?>(json['scheduleDay']),
      scheduleAnchor: serializer.fromJson<DateTime?>(json['scheduleAnchor']),
      landsInAccountId: serializer.fromJson<String>(json['landsInAccountId']),
      splitProfileId: serializer.fromJson<String>(json['splitProfileId']),
      deductBillsFirst: serializer.fromJson<bool>(json['deductBillsFirst']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(
        $IncomeSourcesTable.$converterkind.toJson(kind),
      ),
      'expectedAmount': serializer.toJson<int?>(expectedAmount),
      'scheduleKind': serializer.toJson<String>(scheduleKind),
      'scheduleDay': serializer.toJson<int?>(scheduleDay),
      'scheduleAnchor': serializer.toJson<DateTime?>(scheduleAnchor),
      'landsInAccountId': serializer.toJson<String>(landsInAccountId),
      'splitProfileId': serializer.toJson<String>(splitProfileId),
      'deductBillsFirst': serializer.toJson<bool>(deductBillsFirst),
    };
  }

  IncomeSourceRow copyWith({
    String? id,
    String? name,
    IncomeKind? kind,
    Value<int?> expectedAmount = const Value.absent(),
    String? scheduleKind,
    Value<int?> scheduleDay = const Value.absent(),
    Value<DateTime?> scheduleAnchor = const Value.absent(),
    String? landsInAccountId,
    String? splitProfileId,
    bool? deductBillsFirst,
  }) => IncomeSourceRow(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    expectedAmount: expectedAmount.present
        ? expectedAmount.value
        : this.expectedAmount,
    scheduleKind: scheduleKind ?? this.scheduleKind,
    scheduleDay: scheduleDay.present ? scheduleDay.value : this.scheduleDay,
    scheduleAnchor: scheduleAnchor.present
        ? scheduleAnchor.value
        : this.scheduleAnchor,
    landsInAccountId: landsInAccountId ?? this.landsInAccountId,
    splitProfileId: splitProfileId ?? this.splitProfileId,
    deductBillsFirst: deductBillsFirst ?? this.deductBillsFirst,
  );
  IncomeSourceRow copyWithCompanion(IncomeSourcesCompanion data) {
    return IncomeSourceRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      expectedAmount: data.expectedAmount.present
          ? data.expectedAmount.value
          : this.expectedAmount,
      scheduleKind: data.scheduleKind.present
          ? data.scheduleKind.value
          : this.scheduleKind,
      scheduleDay: data.scheduleDay.present
          ? data.scheduleDay.value
          : this.scheduleDay,
      scheduleAnchor: data.scheduleAnchor.present
          ? data.scheduleAnchor.value
          : this.scheduleAnchor,
      landsInAccountId: data.landsInAccountId.present
          ? data.landsInAccountId.value
          : this.landsInAccountId,
      splitProfileId: data.splitProfileId.present
          ? data.splitProfileId.value
          : this.splitProfileId,
      deductBillsFirst: data.deductBillsFirst.present
          ? data.deductBillsFirst.value
          : this.deductBillsFirst,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourceRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('scheduleKind: $scheduleKind, ')
          ..write('scheduleDay: $scheduleDay, ')
          ..write('scheduleAnchor: $scheduleAnchor, ')
          ..write('landsInAccountId: $landsInAccountId, ')
          ..write('splitProfileId: $splitProfileId, ')
          ..write('deductBillsFirst: $deductBillsFirst')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    kind,
    expectedAmount,
    scheduleKind,
    scheduleDay,
    scheduleAnchor,
    landsInAccountId,
    splitProfileId,
    deductBillsFirst,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeSourceRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.expectedAmount == this.expectedAmount &&
          other.scheduleKind == this.scheduleKind &&
          other.scheduleDay == this.scheduleDay &&
          other.scheduleAnchor == this.scheduleAnchor &&
          other.landsInAccountId == this.landsInAccountId &&
          other.splitProfileId == this.splitProfileId &&
          other.deductBillsFirst == this.deductBillsFirst);
}

class IncomeSourcesCompanion extends UpdateCompanion<IncomeSourceRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<IncomeKind> kind;
  final Value<int?> expectedAmount;
  final Value<String> scheduleKind;
  final Value<int?> scheduleDay;
  final Value<DateTime?> scheduleAnchor;
  final Value<String> landsInAccountId;
  final Value<String> splitProfileId;
  final Value<bool> deductBillsFirst;
  final Value<int> rowid;
  const IncomeSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.expectedAmount = const Value.absent(),
    this.scheduleKind = const Value.absent(),
    this.scheduleDay = const Value.absent(),
    this.scheduleAnchor = const Value.absent(),
    this.landsInAccountId = const Value.absent(),
    this.splitProfileId = const Value.absent(),
    this.deductBillsFirst = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomeSourcesCompanion.insert({
    required String id,
    required String name,
    required IncomeKind kind,
    this.expectedAmount = const Value.absent(),
    required String scheduleKind,
    this.scheduleDay = const Value.absent(),
    this.scheduleAnchor = const Value.absent(),
    required String landsInAccountId,
    required String splitProfileId,
    required bool deductBillsFirst,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       kind = Value(kind),
       scheduleKind = Value(scheduleKind),
       landsInAccountId = Value(landsInAccountId),
       splitProfileId = Value(splitProfileId),
       deductBillsFirst = Value(deductBillsFirst);
  static Insertable<IncomeSourceRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<int>? expectedAmount,
    Expression<String>? scheduleKind,
    Expression<int>? scheduleDay,
    Expression<DateTime>? scheduleAnchor,
    Expression<String>? landsInAccountId,
    Expression<String>? splitProfileId,
    Expression<bool>? deductBillsFirst,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (expectedAmount != null) 'expected_amount': expectedAmount,
      if (scheduleKind != null) 'schedule_kind': scheduleKind,
      if (scheduleDay != null) 'schedule_day': scheduleDay,
      if (scheduleAnchor != null) 'schedule_anchor': scheduleAnchor,
      if (landsInAccountId != null) 'lands_in_account_id': landsInAccountId,
      if (splitProfileId != null) 'split_profile_id': splitProfileId,
      if (deductBillsFirst != null) 'deduct_bills_first': deductBillsFirst,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomeSourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<IncomeKind>? kind,
    Value<int?>? expectedAmount,
    Value<String>? scheduleKind,
    Value<int?>? scheduleDay,
    Value<DateTime?>? scheduleAnchor,
    Value<String>? landsInAccountId,
    Value<String>? splitProfileId,
    Value<bool>? deductBillsFirst,
    Value<int>? rowid,
  }) {
    return IncomeSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      scheduleKind: scheduleKind ?? this.scheduleKind,
      scheduleDay: scheduleDay ?? this.scheduleDay,
      scheduleAnchor: scheduleAnchor ?? this.scheduleAnchor,
      landsInAccountId: landsInAccountId ?? this.landsInAccountId,
      splitProfileId: splitProfileId ?? this.splitProfileId,
      deductBillsFirst: deductBillsFirst ?? this.deductBillsFirst,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $IncomeSourcesTable.$converterkind.toSql(kind.value),
      );
    }
    if (expectedAmount.present) {
      map['expected_amount'] = Variable<int>(expectedAmount.value);
    }
    if (scheduleKind.present) {
      map['schedule_kind'] = Variable<String>(scheduleKind.value);
    }
    if (scheduleDay.present) {
      map['schedule_day'] = Variable<int>(scheduleDay.value);
    }
    if (scheduleAnchor.present) {
      map['schedule_anchor'] = Variable<DateTime>(scheduleAnchor.value);
    }
    if (landsInAccountId.present) {
      map['lands_in_account_id'] = Variable<String>(landsInAccountId.value);
    }
    if (splitProfileId.present) {
      map['split_profile_id'] = Variable<String>(splitProfileId.value);
    }
    if (deductBillsFirst.present) {
      map['deduct_bills_first'] = Variable<bool>(deductBillsFirst.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('scheduleKind: $scheduleKind, ')
          ..write('scheduleDay: $scheduleDay, ')
          ..write('scheduleAnchor: $scheduleAnchor, ')
          ..write('landsInAccountId: $landsInAccountId, ')
          ..write('splitProfileId: $splitProfileId, ')
          ..write('deductBillsFirst: $deductBillsFirst, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomePayerKeysTable extends IncomePayerKeys
    with TableInfo<$IncomePayerKeysTable, IncomePayerKeyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomePayerKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _incomeIdMeta = const VerificationMeta(
    'incomeId',
  );
  @override
  late final GeneratedColumn<String> incomeId = GeneratedColumn<String>(
    'income_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES income_sources (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [incomeId, position, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_payer_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncomePayerKeyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('income_id')) {
      context.handle(
        _incomeIdMeta,
        incomeId.isAcceptableOrUnknown(data['income_id']!, _incomeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_incomeIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {incomeId, position};
  @override
  IncomePayerKeyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomePayerKeyRow(
      incomeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}income_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $IncomePayerKeysTable createAlias(String alias) {
    return $IncomePayerKeysTable(attachedDatabase, alias);
  }
}

class IncomePayerKeyRow extends DataClass
    implements Insertable<IncomePayerKeyRow> {
  final String incomeId;
  final int position;
  final String value;
  const IncomePayerKeyRow({
    required this.incomeId,
    required this.position,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['income_id'] = Variable<String>(incomeId);
    map['position'] = Variable<int>(position);
    map['value'] = Variable<String>(value);
    return map;
  }

  IncomePayerKeysCompanion toCompanion(bool nullToAbsent) {
    return IncomePayerKeysCompanion(
      incomeId: Value(incomeId),
      position: Value(position),
      value: Value(value),
    );
  }

  factory IncomePayerKeyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomePayerKeyRow(
      incomeId: serializer.fromJson<String>(json['incomeId']),
      position: serializer.fromJson<int>(json['position']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'incomeId': serializer.toJson<String>(incomeId),
      'position': serializer.toJson<int>(position),
      'value': serializer.toJson<String>(value),
    };
  }

  IncomePayerKeyRow copyWith({
    String? incomeId,
    int? position,
    String? value,
  }) => IncomePayerKeyRow(
    incomeId: incomeId ?? this.incomeId,
    position: position ?? this.position,
    value: value ?? this.value,
  );
  IncomePayerKeyRow copyWithCompanion(IncomePayerKeysCompanion data) {
    return IncomePayerKeyRow(
      incomeId: data.incomeId.present ? data.incomeId.value : this.incomeId,
      position: data.position.present ? data.position.value : this.position,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomePayerKeyRow(')
          ..write('incomeId: $incomeId, ')
          ..write('position: $position, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(incomeId, position, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomePayerKeyRow &&
          other.incomeId == this.incomeId &&
          other.position == this.position &&
          other.value == this.value);
}

class IncomePayerKeysCompanion extends UpdateCompanion<IncomePayerKeyRow> {
  final Value<String> incomeId;
  final Value<int> position;
  final Value<String> value;
  final Value<int> rowid;
  const IncomePayerKeysCompanion({
    this.incomeId = const Value.absent(),
    this.position = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomePayerKeysCompanion.insert({
    required String incomeId,
    required int position,
    required String value,
    this.rowid = const Value.absent(),
  }) : incomeId = Value(incomeId),
       position = Value(position),
       value = Value(value);
  static Insertable<IncomePayerKeyRow> custom({
    Expression<String>? incomeId,
    Expression<int>? position,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (incomeId != null) 'income_id': incomeId,
      if (position != null) 'position': position,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomePayerKeysCompanion copyWith({
    Value<String>? incomeId,
    Value<int>? position,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return IncomePayerKeysCompanion(
      incomeId: incomeId ?? this.incomeId,
      position: position ?? this.position,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (incomeId.present) {
      map['income_id'] = Variable<String>(incomeId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomePayerKeysCompanion(')
          ..write('incomeId: $incomeId, ')
          ..write('position: $position, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SplitProfilesTable extends SplitProfiles
    with TableInfo<$SplitProfilesTable, SplitProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SplitProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _holdUntilMonthEndMeta = const VerificationMeta(
    'holdUntilMonthEnd',
  );
  @override
  late final GeneratedColumn<bool> holdUntilMonthEnd = GeneratedColumn<bool>(
    'hold_until_month_end',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hold_until_month_end" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, holdUntilMonthEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'split_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<SplitProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hold_until_month_end')) {
      context.handle(
        _holdUntilMonthEndMeta,
        holdUntilMonthEnd.isAcceptableOrUnknown(
          data['hold_until_month_end']!,
          _holdUntilMonthEndMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_holdUntilMonthEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SplitProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SplitProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      holdUntilMonthEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hold_until_month_end'],
      )!,
    );
  }

  @override
  $SplitProfilesTable createAlias(String alias) {
    return $SplitProfilesTable(attachedDatabase, alias);
  }
}

class SplitProfileRow extends DataClass implements Insertable<SplitProfileRow> {
  final String id;
  final bool holdUntilMonthEnd;
  const SplitProfileRow({required this.id, required this.holdUntilMonthEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['hold_until_month_end'] = Variable<bool>(holdUntilMonthEnd);
    return map;
  }

  SplitProfilesCompanion toCompanion(bool nullToAbsent) {
    return SplitProfilesCompanion(
      id: Value(id),
      holdUntilMonthEnd: Value(holdUntilMonthEnd),
    );
  }

  factory SplitProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SplitProfileRow(
      id: serializer.fromJson<String>(json['id']),
      holdUntilMonthEnd: serializer.fromJson<bool>(json['holdUntilMonthEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'holdUntilMonthEnd': serializer.toJson<bool>(holdUntilMonthEnd),
    };
  }

  SplitProfileRow copyWith({String? id, bool? holdUntilMonthEnd}) =>
      SplitProfileRow(
        id: id ?? this.id,
        holdUntilMonthEnd: holdUntilMonthEnd ?? this.holdUntilMonthEnd,
      );
  SplitProfileRow copyWithCompanion(SplitProfilesCompanion data) {
    return SplitProfileRow(
      id: data.id.present ? data.id.value : this.id,
      holdUntilMonthEnd: data.holdUntilMonthEnd.present
          ? data.holdUntilMonthEnd.value
          : this.holdUntilMonthEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SplitProfileRow(')
          ..write('id: $id, ')
          ..write('holdUntilMonthEnd: $holdUntilMonthEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, holdUntilMonthEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SplitProfileRow &&
          other.id == this.id &&
          other.holdUntilMonthEnd == this.holdUntilMonthEnd);
}

class SplitProfilesCompanion extends UpdateCompanion<SplitProfileRow> {
  final Value<String> id;
  final Value<bool> holdUntilMonthEnd;
  final Value<int> rowid;
  const SplitProfilesCompanion({
    this.id = const Value.absent(),
    this.holdUntilMonthEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SplitProfilesCompanion.insert({
    required String id,
    required bool holdUntilMonthEnd,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       holdUntilMonthEnd = Value(holdUntilMonthEnd);
  static Insertable<SplitProfileRow> custom({
    Expression<String>? id,
    Expression<bool>? holdUntilMonthEnd,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (holdUntilMonthEnd != null) 'hold_until_month_end': holdUntilMonthEnd,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SplitProfilesCompanion copyWith({
    Value<String>? id,
    Value<bool>? holdUntilMonthEnd,
    Value<int>? rowid,
  }) {
    return SplitProfilesCompanion(
      id: id ?? this.id,
      holdUntilMonthEnd: holdUntilMonthEnd ?? this.holdUntilMonthEnd,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (holdUntilMonthEnd.present) {
      map['hold_until_month_end'] = Variable<bool>(holdUntilMonthEnd.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SplitProfilesCompanion(')
          ..write('id: $id, ')
          ..write('holdUntilMonthEnd: $holdUntilMonthEnd, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SplitAllocationsTable extends SplitAllocations
    with TableInfo<$SplitAllocationsTable, SplitAllocationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SplitAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES split_profiles (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _basisPointsMeta = const VerificationMeta(
    'basisPoints',
  );
  @override
  late final GeneratedColumn<int> basisPoints = GeneratedColumn<int>(
    'basis_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    profileId,
    position,
    bucketId,
    basisPoints,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'split_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SplitAllocationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('basis_points')) {
      context.handle(
        _basisPointsMeta,
        basisPoints.isAcceptableOrUnknown(
          data['basis_points']!,
          _basisPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_basisPointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, position};
  @override
  SplitAllocationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SplitAllocationRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      basisPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}basis_points'],
      )!,
    );
  }

  @override
  $SplitAllocationsTable createAlias(String alias) {
    return $SplitAllocationsTable(attachedDatabase, alias);
  }
}

class SplitAllocationRow extends DataClass
    implements Insertable<SplitAllocationRow> {
  final String profileId;
  final int position;
  final String bucketId;
  final int basisPoints;
  const SplitAllocationRow({
    required this.profileId,
    required this.position,
    required this.bucketId,
    required this.basisPoints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['position'] = Variable<int>(position);
    map['bucket_id'] = Variable<String>(bucketId);
    map['basis_points'] = Variable<int>(basisPoints);
    return map;
  }

  SplitAllocationsCompanion toCompanion(bool nullToAbsent) {
    return SplitAllocationsCompanion(
      profileId: Value(profileId),
      position: Value(position),
      bucketId: Value(bucketId),
      basisPoints: Value(basisPoints),
    );
  }

  factory SplitAllocationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SplitAllocationRow(
      profileId: serializer.fromJson<String>(json['profileId']),
      position: serializer.fromJson<int>(json['position']),
      bucketId: serializer.fromJson<String>(json['bucketId']),
      basisPoints: serializer.fromJson<int>(json['basisPoints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'position': serializer.toJson<int>(position),
      'bucketId': serializer.toJson<String>(bucketId),
      'basisPoints': serializer.toJson<int>(basisPoints),
    };
  }

  SplitAllocationRow copyWith({
    String? profileId,
    int? position,
    String? bucketId,
    int? basisPoints,
  }) => SplitAllocationRow(
    profileId: profileId ?? this.profileId,
    position: position ?? this.position,
    bucketId: bucketId ?? this.bucketId,
    basisPoints: basisPoints ?? this.basisPoints,
  );
  SplitAllocationRow copyWithCompanion(SplitAllocationsCompanion data) {
    return SplitAllocationRow(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      position: data.position.present ? data.position.value : this.position,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      basisPoints: data.basisPoints.present
          ? data.basisPoints.value
          : this.basisPoints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SplitAllocationRow(')
          ..write('profileId: $profileId, ')
          ..write('position: $position, ')
          ..write('bucketId: $bucketId, ')
          ..write('basisPoints: $basisPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, position, bucketId, basisPoints);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SplitAllocationRow &&
          other.profileId == this.profileId &&
          other.position == this.position &&
          other.bucketId == this.bucketId &&
          other.basisPoints == this.basisPoints);
}

class SplitAllocationsCompanion extends UpdateCompanion<SplitAllocationRow> {
  final Value<String> profileId;
  final Value<int> position;
  final Value<String> bucketId;
  final Value<int> basisPoints;
  final Value<int> rowid;
  const SplitAllocationsCompanion({
    this.profileId = const Value.absent(),
    this.position = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.basisPoints = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SplitAllocationsCompanion.insert({
    required String profileId,
    required int position,
    required String bucketId,
    required int basisPoints,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       position = Value(position),
       bucketId = Value(bucketId),
       basisPoints = Value(basisPoints);
  static Insertable<SplitAllocationRow> custom({
    Expression<String>? profileId,
    Expression<int>? position,
    Expression<String>? bucketId,
    Expression<int>? basisPoints,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (position != null) 'position': position,
      if (bucketId != null) 'bucket_id': bucketId,
      if (basisPoints != null) 'basis_points': basisPoints,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SplitAllocationsCompanion copyWith({
    Value<String>? profileId,
    Value<int>? position,
    Value<String>? bucketId,
    Value<int>? basisPoints,
    Value<int>? rowid,
  }) {
    return SplitAllocationsCompanion(
      profileId: profileId ?? this.profileId,
      position: position ?? this.position,
      bucketId: bucketId ?? this.bucketId,
      basisPoints: basisPoints ?? this.basisPoints,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (basisPoints.present) {
      map['basis_points'] = Variable<int>(basisPoints.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SplitAllocationsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('position: $position, ')
          ..write('bucketId: $bucketId, ')
          ..write('basisPoints: $basisPoints, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, BillRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMonthsMeta = const VerificationMeta(
    'frequencyMonths',
  );
  @override
  late final GeneratedColumn<int> frequencyMonths = GeneratedColumn<int>(
    'frequency_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDayMeta = const VerificationMeta('dueDay');
  @override
  late final GeneratedColumn<int> dueDay = GeneratedColumn<int>(
    'due_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextDueDateMeta = const VerificationMeta(
    'nextDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
    'next_due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paidFromBucketIdMeta = const VerificationMeta(
    'paidFromBucketId',
  );
  @override
  late final GeneratedColumn<String> paidFromBucketId = GeneratedColumn<String>(
    'paid_from_bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payeeAccountHintMeta = const VerificationMeta(
    'payeeAccountHint',
  );
  @override
  late final GeneratedColumn<String> payeeAccountHint = GeneratedColumn<String>(
    'payee_account_hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    amount,
    frequencyMonths,
    dueDay,
    nextDueDate,
    paidFromBucketId,
    payeeAccountHint,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('frequency_months')) {
      context.handle(
        _frequencyMonthsMeta,
        frequencyMonths.isAcceptableOrUnknown(
          data['frequency_months']!,
          _frequencyMonthsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_frequencyMonthsMeta);
    }
    if (data.containsKey('due_day')) {
      context.handle(
        _dueDayMeta,
        dueDay.isAcceptableOrUnknown(data['due_day']!, _dueDayMeta),
      );
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
        _nextDueDateMeta,
        nextDueDate.isAcceptableOrUnknown(
          data['next_due_date']!,
          _nextDueDateMeta,
        ),
      );
    }
    if (data.containsKey('paid_from_bucket_id')) {
      context.handle(
        _paidFromBucketIdMeta,
        paidFromBucketId.isAcceptableOrUnknown(
          data['paid_from_bucket_id']!,
          _paidFromBucketIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paidFromBucketIdMeta);
    }
    if (data.containsKey('payee_account_hint')) {
      context.handle(
        _payeeAccountHintMeta,
        payeeAccountHint.isAcceptableOrUnknown(
          data['payee_account_hint']!,
          _payeeAccountHintMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      frequencyMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency_months'],
      )!,
      dueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_day'],
      ),
      nextDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due_date'],
      ),
      paidFromBucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_from_bucket_id'],
      )!,
      payeeAccountHint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payee_account_hint'],
      ),
    );
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(attachedDatabase, alias);
  }
}

class BillRow extends DataClass implements Insertable<BillRow> {
  final String id;
  final String name;
  final int amount;
  final int frequencyMonths;
  final int? dueDay;
  final DateTime? nextDueDate;
  final String paidFromBucketId;
  final String? payeeAccountHint;
  const BillRow({
    required this.id,
    required this.name,
    required this.amount,
    required this.frequencyMonths,
    this.dueDay,
    this.nextDueDate,
    required this.paidFromBucketId,
    this.payeeAccountHint,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['frequency_months'] = Variable<int>(frequencyMonths);
    if (!nullToAbsent || dueDay != null) {
      map['due_day'] = Variable<int>(dueDay);
    }
    if (!nullToAbsent || nextDueDate != null) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate);
    }
    map['paid_from_bucket_id'] = Variable<String>(paidFromBucketId);
    if (!nullToAbsent || payeeAccountHint != null) {
      map['payee_account_hint'] = Variable<String>(payeeAccountHint);
    }
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      name: Value(name),
      amount: Value(amount),
      frequencyMonths: Value(frequencyMonths),
      dueDay: dueDay == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDay),
      nextDueDate: nextDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextDueDate),
      paidFromBucketId: Value(paidFromBucketId),
      payeeAccountHint: payeeAccountHint == null && nullToAbsent
          ? const Value.absent()
          : Value(payeeAccountHint),
    );
  }

  factory BillRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      frequencyMonths: serializer.fromJson<int>(json['frequencyMonths']),
      dueDay: serializer.fromJson<int?>(json['dueDay']),
      nextDueDate: serializer.fromJson<DateTime?>(json['nextDueDate']),
      paidFromBucketId: serializer.fromJson<String>(json['paidFromBucketId']),
      payeeAccountHint: serializer.fromJson<String?>(json['payeeAccountHint']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
      'frequencyMonths': serializer.toJson<int>(frequencyMonths),
      'dueDay': serializer.toJson<int?>(dueDay),
      'nextDueDate': serializer.toJson<DateTime?>(nextDueDate),
      'paidFromBucketId': serializer.toJson<String>(paidFromBucketId),
      'payeeAccountHint': serializer.toJson<String?>(payeeAccountHint),
    };
  }

  BillRow copyWith({
    String? id,
    String? name,
    int? amount,
    int? frequencyMonths,
    Value<int?> dueDay = const Value.absent(),
    Value<DateTime?> nextDueDate = const Value.absent(),
    String? paidFromBucketId,
    Value<String?> payeeAccountHint = const Value.absent(),
  }) => BillRow(
    id: id ?? this.id,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    frequencyMonths: frequencyMonths ?? this.frequencyMonths,
    dueDay: dueDay.present ? dueDay.value : this.dueDay,
    nextDueDate: nextDueDate.present ? nextDueDate.value : this.nextDueDate,
    paidFromBucketId: paidFromBucketId ?? this.paidFromBucketId,
    payeeAccountHint: payeeAccountHint.present
        ? payeeAccountHint.value
        : this.payeeAccountHint,
  );
  BillRow copyWithCompanion(BillsCompanion data) {
    return BillRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      frequencyMonths: data.frequencyMonths.present
          ? data.frequencyMonths.value
          : this.frequencyMonths,
      dueDay: data.dueDay.present ? data.dueDay.value : this.dueDay,
      nextDueDate: data.nextDueDate.present
          ? data.nextDueDate.value
          : this.nextDueDate,
      paidFromBucketId: data.paidFromBucketId.present
          ? data.paidFromBucketId.value
          : this.paidFromBucketId,
      payeeAccountHint: data.payeeAccountHint.present
          ? data.payeeAccountHint.value
          : this.payeeAccountHint,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('frequencyMonths: $frequencyMonths, ')
          ..write('dueDay: $dueDay, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('paidFromBucketId: $paidFromBucketId, ')
          ..write('payeeAccountHint: $payeeAccountHint')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    amount,
    frequencyMonths,
    dueDay,
    nextDueDate,
    paidFromBucketId,
    payeeAccountHint,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.frequencyMonths == this.frequencyMonths &&
          other.dueDay == this.dueDay &&
          other.nextDueDate == this.nextDueDate &&
          other.paidFromBucketId == this.paidFromBucketId &&
          other.payeeAccountHint == this.payeeAccountHint);
}

class BillsCompanion extends UpdateCompanion<BillRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> amount;
  final Value<int> frequencyMonths;
  final Value<int?> dueDay;
  final Value<DateTime?> nextDueDate;
  final Value<String> paidFromBucketId;
  final Value<String?> payeeAccountHint;
  final Value<int> rowid;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.frequencyMonths = const Value.absent(),
    this.dueDay = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.paidFromBucketId = const Value.absent(),
    this.payeeAccountHint = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillsCompanion.insert({
    required String id,
    required String name,
    required int amount,
    required int frequencyMonths,
    this.dueDay = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    required String paidFromBucketId,
    this.payeeAccountHint = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       amount = Value(amount),
       frequencyMonths = Value(frequencyMonths),
       paidFromBucketId = Value(paidFromBucketId);
  static Insertable<BillRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<int>? frequencyMonths,
    Expression<int>? dueDay,
    Expression<DateTime>? nextDueDate,
    Expression<String>? paidFromBucketId,
    Expression<String>? payeeAccountHint,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (frequencyMonths != null) 'frequency_months': frequencyMonths,
      if (dueDay != null) 'due_day': dueDay,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (paidFromBucketId != null) 'paid_from_bucket_id': paidFromBucketId,
      if (payeeAccountHint != null) 'payee_account_hint': payeeAccountHint,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? amount,
    Value<int>? frequencyMonths,
    Value<int?>? dueDay,
    Value<DateTime?>? nextDueDate,
    Value<String>? paidFromBucketId,
    Value<String?>? payeeAccountHint,
    Value<int>? rowid,
  }) {
    return BillsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      frequencyMonths: frequencyMonths ?? this.frequencyMonths,
      dueDay: dueDay ?? this.dueDay,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      paidFromBucketId: paidFromBucketId ?? this.paidFromBucketId,
      payeeAccountHint: payeeAccountHint ?? this.payeeAccountHint,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (frequencyMonths.present) {
      map['frequency_months'] = Variable<int>(frequencyMonths.value);
    }
    if (dueDay.present) {
      map['due_day'] = Variable<int>(dueDay.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (paidFromBucketId.present) {
      map['paid_from_bucket_id'] = Variable<String>(paidFromBucketId.value);
    }
    if (payeeAccountHint.present) {
      map['payee_account_hint'] = Variable<String>(payeeAccountHint.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('frequencyMonths: $frequencyMonths, ')
          ..write('dueDay: $dueDay, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('paidFromBucketId: $paidFromBucketId, ')
          ..write('payeeAccountHint: $payeeAccountHint, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsRowsTable extends SettingsRows
    with TableInfo<$SettingsRowsTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeZoneMeta = const VerificationMeta(
    'timeZone',
  );
  @override
  late final GeneratedColumn<String> timeZone = GeneratedColumn<String>(
    'time_zone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quietStartMinutesMeta = const VerificationMeta(
    'quietStartMinutes',
  );
  @override
  late final GeneratedColumn<int> quietStartMinutes = GeneratedColumn<int>(
    'quiet_start_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quietEndMinutesMeta = const VerificationMeta(
    'quietEndMinutes',
  );
  @override
  late final GeneratedColumn<int> quietEndMinutes = GeneratedColumn<int>(
    'quiet_end_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snoozeLimitMeta = const VerificationMeta(
    'snoozeLimit',
  );
  @override
  late final GeneratedColumn<int> snoozeLimit = GeneratedColumn<int>(
    'snooze_limit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coolingOffThresholdMeta =
      const VerificationMeta('coolingOffThreshold');
  @override
  late final GeneratedColumn<int> coolingOffThreshold = GeneratedColumn<int>(
    'cooling_off_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coolingOffHoursMeta = const VerificationMeta(
    'coolingOffHours',
  );
  @override
  late final GeneratedColumn<int> coolingOffHours = GeneratedColumn<int>(
    'cooling_off_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInDayMeta = const VerificationMeta(
    'checkInDay',
  );
  @override
  late final GeneratedColumn<int> checkInDay = GeneratedColumn<int>(
    'check_in_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInMinutesMeta = const VerificationMeta(
    'checkInMinutes',
  );
  @override
  late final GeneratedColumn<int> checkInMinutes = GeneratedColumn<int>(
    'check_in_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appLockMeta = const VerificationMeta(
    'appLock',
  );
  @override
  late final GeneratedColumn<bool> appLock = GeneratedColumn<bool>(
    'app_lock',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("app_lock" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<LockTimeout, String> lockTimeout =
      GeneratedColumn<String>(
        'lock_timeout',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('oneMinute'),
      ).withConverter<LockTimeout>($SettingsRowsTable.$converterlockTimeout);
  static const VerificationMeta _hideAmountsMeta = const VerificationMeta(
    'hideAmounts',
  );
  @override
  late final GeneratedColumn<bool> hideAmounts = GeneratedColumn<bool>(
    'hide_amounts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hide_amounts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _billRemindersMeta = const VerificationMeta(
    'billReminders',
  );
  @override
  late final GeneratedColumn<bool> billReminders = GeneratedColumn<bool>(
    'bill_reminders',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bill_reminders" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _autoFileMeta = const VerificationMeta(
    'autoFile',
  );
  @override
  late final GeneratedColumn<bool> autoFile = GeneratedColumn<bool>(
    'auto_file',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_file" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<BucketKind, String>
  goalShareFallback = GeneratedColumn<String>(
    'goal_share_fallback',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<BucketKind>($SettingsRowsTable.$convertergoalShareFallback);
  static const VerificationMeta _setupCompletedAtMeta = const VerificationMeta(
    'setupCompletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> setupCompletedAt =
      GeneratedColumn<DateTime>(
        'setup_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timeZone,
    quietStartMinutes,
    quietEndMinutes,
    snoozeLimit,
    coolingOffThreshold,
    coolingOffHours,
    checkInDay,
    checkInMinutes,
    appLock,
    lockTimeout,
    hideAmounts,
    billReminders,
    autoFile,
    goalShareFallback,
    setupCompletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time_zone')) {
      context.handle(
        _timeZoneMeta,
        timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timeZoneMeta);
    }
    if (data.containsKey('quiet_start_minutes')) {
      context.handle(
        _quietStartMinutesMeta,
        quietStartMinutes.isAcceptableOrUnknown(
          data['quiet_start_minutes']!,
          _quietStartMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quietStartMinutesMeta);
    }
    if (data.containsKey('quiet_end_minutes')) {
      context.handle(
        _quietEndMinutesMeta,
        quietEndMinutes.isAcceptableOrUnknown(
          data['quiet_end_minutes']!,
          _quietEndMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quietEndMinutesMeta);
    }
    if (data.containsKey('snooze_limit')) {
      context.handle(
        _snoozeLimitMeta,
        snoozeLimit.isAcceptableOrUnknown(
          data['snooze_limit']!,
          _snoozeLimitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snoozeLimitMeta);
    }
    if (data.containsKey('cooling_off_threshold')) {
      context.handle(
        _coolingOffThresholdMeta,
        coolingOffThreshold.isAcceptableOrUnknown(
          data['cooling_off_threshold']!,
          _coolingOffThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coolingOffThresholdMeta);
    }
    if (data.containsKey('cooling_off_hours')) {
      context.handle(
        _coolingOffHoursMeta,
        coolingOffHours.isAcceptableOrUnknown(
          data['cooling_off_hours']!,
          _coolingOffHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coolingOffHoursMeta);
    }
    if (data.containsKey('check_in_day')) {
      context.handle(
        _checkInDayMeta,
        checkInDay.isAcceptableOrUnknown(
          data['check_in_day']!,
          _checkInDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checkInDayMeta);
    }
    if (data.containsKey('check_in_minutes')) {
      context.handle(
        _checkInMinutesMeta,
        checkInMinutes.isAcceptableOrUnknown(
          data['check_in_minutes']!,
          _checkInMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checkInMinutesMeta);
    }
    if (data.containsKey('app_lock')) {
      context.handle(
        _appLockMeta,
        appLock.isAcceptableOrUnknown(data['app_lock']!, _appLockMeta),
      );
    } else if (isInserting) {
      context.missing(_appLockMeta);
    }
    if (data.containsKey('hide_amounts')) {
      context.handle(
        _hideAmountsMeta,
        hideAmounts.isAcceptableOrUnknown(
          data['hide_amounts']!,
          _hideAmountsMeta,
        ),
      );
    }
    if (data.containsKey('bill_reminders')) {
      context.handle(
        _billRemindersMeta,
        billReminders.isAcceptableOrUnknown(
          data['bill_reminders']!,
          _billRemindersMeta,
        ),
      );
    }
    if (data.containsKey('auto_file')) {
      context.handle(
        _autoFileMeta,
        autoFile.isAcceptableOrUnknown(data['auto_file']!, _autoFileMeta),
      );
    } else if (isInserting) {
      context.missing(_autoFileMeta);
    }
    if (data.containsKey('setup_completed_at')) {
      context.handle(
        _setupCompletedAtMeta,
        setupCompletedAt.isAcceptableOrUnknown(
          data['setup_completed_at']!,
          _setupCompletedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timeZone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_zone'],
      )!,
      quietStartMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quiet_start_minutes'],
      )!,
      quietEndMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quiet_end_minutes'],
      )!,
      snoozeLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_limit'],
      )!,
      coolingOffThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cooling_off_threshold'],
      )!,
      coolingOffHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cooling_off_hours'],
      )!,
      checkInDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in_day'],
      )!,
      checkInMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in_minutes'],
      )!,
      appLock: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}app_lock'],
      )!,
      lockTimeout: $SettingsRowsTable.$converterlockTimeout.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}lock_timeout'],
        )!,
      ),
      hideAmounts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hide_amounts'],
      )!,
      billReminders: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bill_reminders'],
      )!,
      autoFile: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_file'],
      )!,
      goalShareFallback: $SettingsRowsTable.$convertergoalShareFallback.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}goal_share_fallback'],
        )!,
      ),
      setupCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}setup_completed_at'],
      ),
    );
  }

  @override
  $SettingsRowsTable createAlias(String alias) {
    return $SettingsRowsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LockTimeout, String, String> $converterlockTimeout =
      const EnumNameConverter<LockTimeout>(LockTimeout.values);
  static JsonTypeConverter2<BucketKind, String, String>
  $convertergoalShareFallback = const EnumNameConverter<BucketKind>(
    BucketKind.values,
  );
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final int id;
  final String timeZone;
  final int quietStartMinutes;
  final int quietEndMinutes;
  final int snoozeLimit;
  final int coolingOffThreshold;
  final int coolingOffHours;
  final int checkInDay;
  final int checkInMinutes;
  final bool appLock;
  final LockTimeout lockTimeout;
  final bool hideAmounts;
  final bool billReminders;
  final bool autoFile;
  final BucketKind goalShareFallback;
  final DateTime? setupCompletedAt;
  const SettingsRow({
    required this.id,
    required this.timeZone,
    required this.quietStartMinutes,
    required this.quietEndMinutes,
    required this.snoozeLimit,
    required this.coolingOffThreshold,
    required this.coolingOffHours,
    required this.checkInDay,
    required this.checkInMinutes,
    required this.appLock,
    required this.lockTimeout,
    required this.hideAmounts,
    required this.billReminders,
    required this.autoFile,
    required this.goalShareFallback,
    this.setupCompletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['time_zone'] = Variable<String>(timeZone);
    map['quiet_start_minutes'] = Variable<int>(quietStartMinutes);
    map['quiet_end_minutes'] = Variable<int>(quietEndMinutes);
    map['snooze_limit'] = Variable<int>(snoozeLimit);
    map['cooling_off_threshold'] = Variable<int>(coolingOffThreshold);
    map['cooling_off_hours'] = Variable<int>(coolingOffHours);
    map['check_in_day'] = Variable<int>(checkInDay);
    map['check_in_minutes'] = Variable<int>(checkInMinutes);
    map['app_lock'] = Variable<bool>(appLock);
    {
      map['lock_timeout'] = Variable<String>(
        $SettingsRowsTable.$converterlockTimeout.toSql(lockTimeout),
      );
    }
    map['hide_amounts'] = Variable<bool>(hideAmounts);
    map['bill_reminders'] = Variable<bool>(billReminders);
    map['auto_file'] = Variable<bool>(autoFile);
    {
      map['goal_share_fallback'] = Variable<String>(
        $SettingsRowsTable.$convertergoalShareFallback.toSql(goalShareFallback),
      );
    }
    if (!nullToAbsent || setupCompletedAt != null) {
      map['setup_completed_at'] = Variable<DateTime>(setupCompletedAt);
    }
    return map;
  }

  SettingsRowsCompanion toCompanion(bool nullToAbsent) {
    return SettingsRowsCompanion(
      id: Value(id),
      timeZone: Value(timeZone),
      quietStartMinutes: Value(quietStartMinutes),
      quietEndMinutes: Value(quietEndMinutes),
      snoozeLimit: Value(snoozeLimit),
      coolingOffThreshold: Value(coolingOffThreshold),
      coolingOffHours: Value(coolingOffHours),
      checkInDay: Value(checkInDay),
      checkInMinutes: Value(checkInMinutes),
      appLock: Value(appLock),
      lockTimeout: Value(lockTimeout),
      hideAmounts: Value(hideAmounts),
      billReminders: Value(billReminders),
      autoFile: Value(autoFile),
      goalShareFallback: Value(goalShareFallback),
      setupCompletedAt: setupCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(setupCompletedAt),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      timeZone: serializer.fromJson<String>(json['timeZone']),
      quietStartMinutes: serializer.fromJson<int>(json['quietStartMinutes']),
      quietEndMinutes: serializer.fromJson<int>(json['quietEndMinutes']),
      snoozeLimit: serializer.fromJson<int>(json['snoozeLimit']),
      coolingOffThreshold: serializer.fromJson<int>(
        json['coolingOffThreshold'],
      ),
      coolingOffHours: serializer.fromJson<int>(json['coolingOffHours']),
      checkInDay: serializer.fromJson<int>(json['checkInDay']),
      checkInMinutes: serializer.fromJson<int>(json['checkInMinutes']),
      appLock: serializer.fromJson<bool>(json['appLock']),
      lockTimeout: $SettingsRowsTable.$converterlockTimeout.fromJson(
        serializer.fromJson<String>(json['lockTimeout']),
      ),
      hideAmounts: serializer.fromJson<bool>(json['hideAmounts']),
      billReminders: serializer.fromJson<bool>(json['billReminders']),
      autoFile: serializer.fromJson<bool>(json['autoFile']),
      goalShareFallback: $SettingsRowsTable.$convertergoalShareFallback
          .fromJson(serializer.fromJson<String>(json['goalShareFallback'])),
      setupCompletedAt: serializer.fromJson<DateTime?>(
        json['setupCompletedAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timeZone': serializer.toJson<String>(timeZone),
      'quietStartMinutes': serializer.toJson<int>(quietStartMinutes),
      'quietEndMinutes': serializer.toJson<int>(quietEndMinutes),
      'snoozeLimit': serializer.toJson<int>(snoozeLimit),
      'coolingOffThreshold': serializer.toJson<int>(coolingOffThreshold),
      'coolingOffHours': serializer.toJson<int>(coolingOffHours),
      'checkInDay': serializer.toJson<int>(checkInDay),
      'checkInMinutes': serializer.toJson<int>(checkInMinutes),
      'appLock': serializer.toJson<bool>(appLock),
      'lockTimeout': serializer.toJson<String>(
        $SettingsRowsTable.$converterlockTimeout.toJson(lockTimeout),
      ),
      'hideAmounts': serializer.toJson<bool>(hideAmounts),
      'billReminders': serializer.toJson<bool>(billReminders),
      'autoFile': serializer.toJson<bool>(autoFile),
      'goalShareFallback': serializer.toJson<String>(
        $SettingsRowsTable.$convertergoalShareFallback.toJson(
          goalShareFallback,
        ),
      ),
      'setupCompletedAt': serializer.toJson<DateTime?>(setupCompletedAt),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? timeZone,
    int? quietStartMinutes,
    int? quietEndMinutes,
    int? snoozeLimit,
    int? coolingOffThreshold,
    int? coolingOffHours,
    int? checkInDay,
    int? checkInMinutes,
    bool? appLock,
    LockTimeout? lockTimeout,
    bool? hideAmounts,
    bool? billReminders,
    bool? autoFile,
    BucketKind? goalShareFallback,
    Value<DateTime?> setupCompletedAt = const Value.absent(),
  }) => SettingsRow(
    id: id ?? this.id,
    timeZone: timeZone ?? this.timeZone,
    quietStartMinutes: quietStartMinutes ?? this.quietStartMinutes,
    quietEndMinutes: quietEndMinutes ?? this.quietEndMinutes,
    snoozeLimit: snoozeLimit ?? this.snoozeLimit,
    coolingOffThreshold: coolingOffThreshold ?? this.coolingOffThreshold,
    coolingOffHours: coolingOffHours ?? this.coolingOffHours,
    checkInDay: checkInDay ?? this.checkInDay,
    checkInMinutes: checkInMinutes ?? this.checkInMinutes,
    appLock: appLock ?? this.appLock,
    lockTimeout: lockTimeout ?? this.lockTimeout,
    hideAmounts: hideAmounts ?? this.hideAmounts,
    billReminders: billReminders ?? this.billReminders,
    autoFile: autoFile ?? this.autoFile,
    goalShareFallback: goalShareFallback ?? this.goalShareFallback,
    setupCompletedAt: setupCompletedAt.present
        ? setupCompletedAt.value
        : this.setupCompletedAt,
  );
  SettingsRow copyWithCompanion(SettingsRowsCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      quietStartMinutes: data.quietStartMinutes.present
          ? data.quietStartMinutes.value
          : this.quietStartMinutes,
      quietEndMinutes: data.quietEndMinutes.present
          ? data.quietEndMinutes.value
          : this.quietEndMinutes,
      snoozeLimit: data.snoozeLimit.present
          ? data.snoozeLimit.value
          : this.snoozeLimit,
      coolingOffThreshold: data.coolingOffThreshold.present
          ? data.coolingOffThreshold.value
          : this.coolingOffThreshold,
      coolingOffHours: data.coolingOffHours.present
          ? data.coolingOffHours.value
          : this.coolingOffHours,
      checkInDay: data.checkInDay.present
          ? data.checkInDay.value
          : this.checkInDay,
      checkInMinutes: data.checkInMinutes.present
          ? data.checkInMinutes.value
          : this.checkInMinutes,
      appLock: data.appLock.present ? data.appLock.value : this.appLock,
      lockTimeout: data.lockTimeout.present
          ? data.lockTimeout.value
          : this.lockTimeout,
      hideAmounts: data.hideAmounts.present
          ? data.hideAmounts.value
          : this.hideAmounts,
      billReminders: data.billReminders.present
          ? data.billReminders.value
          : this.billReminders,
      autoFile: data.autoFile.present ? data.autoFile.value : this.autoFile,
      goalShareFallback: data.goalShareFallback.present
          ? data.goalShareFallback.value
          : this.goalShareFallback,
      setupCompletedAt: data.setupCompletedAt.present
          ? data.setupCompletedAt.value
          : this.setupCompletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('timeZone: $timeZone, ')
          ..write('quietStartMinutes: $quietStartMinutes, ')
          ..write('quietEndMinutes: $quietEndMinutes, ')
          ..write('snoozeLimit: $snoozeLimit, ')
          ..write('coolingOffThreshold: $coolingOffThreshold, ')
          ..write('coolingOffHours: $coolingOffHours, ')
          ..write('checkInDay: $checkInDay, ')
          ..write('checkInMinutes: $checkInMinutes, ')
          ..write('appLock: $appLock, ')
          ..write('lockTimeout: $lockTimeout, ')
          ..write('hideAmounts: $hideAmounts, ')
          ..write('billReminders: $billReminders, ')
          ..write('autoFile: $autoFile, ')
          ..write('goalShareFallback: $goalShareFallback, ')
          ..write('setupCompletedAt: $setupCompletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timeZone,
    quietStartMinutes,
    quietEndMinutes,
    snoozeLimit,
    coolingOffThreshold,
    coolingOffHours,
    checkInDay,
    checkInMinutes,
    appLock,
    lockTimeout,
    hideAmounts,
    billReminders,
    autoFile,
    goalShareFallback,
    setupCompletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.timeZone == this.timeZone &&
          other.quietStartMinutes == this.quietStartMinutes &&
          other.quietEndMinutes == this.quietEndMinutes &&
          other.snoozeLimit == this.snoozeLimit &&
          other.coolingOffThreshold == this.coolingOffThreshold &&
          other.coolingOffHours == this.coolingOffHours &&
          other.checkInDay == this.checkInDay &&
          other.checkInMinutes == this.checkInMinutes &&
          other.appLock == this.appLock &&
          other.lockTimeout == this.lockTimeout &&
          other.hideAmounts == this.hideAmounts &&
          other.billReminders == this.billReminders &&
          other.autoFile == this.autoFile &&
          other.goalShareFallback == this.goalShareFallback &&
          other.setupCompletedAt == this.setupCompletedAt);
}

class SettingsRowsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> timeZone;
  final Value<int> quietStartMinutes;
  final Value<int> quietEndMinutes;
  final Value<int> snoozeLimit;
  final Value<int> coolingOffThreshold;
  final Value<int> coolingOffHours;
  final Value<int> checkInDay;
  final Value<int> checkInMinutes;
  final Value<bool> appLock;
  final Value<LockTimeout> lockTimeout;
  final Value<bool> hideAmounts;
  final Value<bool> billReminders;
  final Value<bool> autoFile;
  final Value<BucketKind> goalShareFallback;
  final Value<DateTime?> setupCompletedAt;
  const SettingsRowsCompanion({
    this.id = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.quietStartMinutes = const Value.absent(),
    this.quietEndMinutes = const Value.absent(),
    this.snoozeLimit = const Value.absent(),
    this.coolingOffThreshold = const Value.absent(),
    this.coolingOffHours = const Value.absent(),
    this.checkInDay = const Value.absent(),
    this.checkInMinutes = const Value.absent(),
    this.appLock = const Value.absent(),
    this.lockTimeout = const Value.absent(),
    this.hideAmounts = const Value.absent(),
    this.billReminders = const Value.absent(),
    this.autoFile = const Value.absent(),
    this.goalShareFallback = const Value.absent(),
    this.setupCompletedAt = const Value.absent(),
  });
  SettingsRowsCompanion.insert({
    this.id = const Value.absent(),
    required String timeZone,
    required int quietStartMinutes,
    required int quietEndMinutes,
    required int snoozeLimit,
    required int coolingOffThreshold,
    required int coolingOffHours,
    required int checkInDay,
    required int checkInMinutes,
    required bool appLock,
    this.lockTimeout = const Value.absent(),
    this.hideAmounts = const Value.absent(),
    this.billReminders = const Value.absent(),
    required bool autoFile,
    required BucketKind goalShareFallback,
    this.setupCompletedAt = const Value.absent(),
  }) : timeZone = Value(timeZone),
       quietStartMinutes = Value(quietStartMinutes),
       quietEndMinutes = Value(quietEndMinutes),
       snoozeLimit = Value(snoozeLimit),
       coolingOffThreshold = Value(coolingOffThreshold),
       coolingOffHours = Value(coolingOffHours),
       checkInDay = Value(checkInDay),
       checkInMinutes = Value(checkInMinutes),
       appLock = Value(appLock),
       autoFile = Value(autoFile),
       goalShareFallback = Value(goalShareFallback);
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? timeZone,
    Expression<int>? quietStartMinutes,
    Expression<int>? quietEndMinutes,
    Expression<int>? snoozeLimit,
    Expression<int>? coolingOffThreshold,
    Expression<int>? coolingOffHours,
    Expression<int>? checkInDay,
    Expression<int>? checkInMinutes,
    Expression<bool>? appLock,
    Expression<String>? lockTimeout,
    Expression<bool>? hideAmounts,
    Expression<bool>? billReminders,
    Expression<bool>? autoFile,
    Expression<String>? goalShareFallback,
    Expression<DateTime>? setupCompletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timeZone != null) 'time_zone': timeZone,
      if (quietStartMinutes != null) 'quiet_start_minutes': quietStartMinutes,
      if (quietEndMinutes != null) 'quiet_end_minutes': quietEndMinutes,
      if (snoozeLimit != null) 'snooze_limit': snoozeLimit,
      if (coolingOffThreshold != null)
        'cooling_off_threshold': coolingOffThreshold,
      if (coolingOffHours != null) 'cooling_off_hours': coolingOffHours,
      if (checkInDay != null) 'check_in_day': checkInDay,
      if (checkInMinutes != null) 'check_in_minutes': checkInMinutes,
      if (appLock != null) 'app_lock': appLock,
      if (lockTimeout != null) 'lock_timeout': lockTimeout,
      if (hideAmounts != null) 'hide_amounts': hideAmounts,
      if (billReminders != null) 'bill_reminders': billReminders,
      if (autoFile != null) 'auto_file': autoFile,
      if (goalShareFallback != null) 'goal_share_fallback': goalShareFallback,
      if (setupCompletedAt != null) 'setup_completed_at': setupCompletedAt,
    });
  }

  SettingsRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? timeZone,
    Value<int>? quietStartMinutes,
    Value<int>? quietEndMinutes,
    Value<int>? snoozeLimit,
    Value<int>? coolingOffThreshold,
    Value<int>? coolingOffHours,
    Value<int>? checkInDay,
    Value<int>? checkInMinutes,
    Value<bool>? appLock,
    Value<LockTimeout>? lockTimeout,
    Value<bool>? hideAmounts,
    Value<bool>? billReminders,
    Value<bool>? autoFile,
    Value<BucketKind>? goalShareFallback,
    Value<DateTime?>? setupCompletedAt,
  }) {
    return SettingsRowsCompanion(
      id: id ?? this.id,
      timeZone: timeZone ?? this.timeZone,
      quietStartMinutes: quietStartMinutes ?? this.quietStartMinutes,
      quietEndMinutes: quietEndMinutes ?? this.quietEndMinutes,
      snoozeLimit: snoozeLimit ?? this.snoozeLimit,
      coolingOffThreshold: coolingOffThreshold ?? this.coolingOffThreshold,
      coolingOffHours: coolingOffHours ?? this.coolingOffHours,
      checkInDay: checkInDay ?? this.checkInDay,
      checkInMinutes: checkInMinutes ?? this.checkInMinutes,
      appLock: appLock ?? this.appLock,
      lockTimeout: lockTimeout ?? this.lockTimeout,
      hideAmounts: hideAmounts ?? this.hideAmounts,
      billReminders: billReminders ?? this.billReminders,
      autoFile: autoFile ?? this.autoFile,
      goalShareFallback: goalShareFallback ?? this.goalShareFallback,
      setupCompletedAt: setupCompletedAt ?? this.setupCompletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (quietStartMinutes.present) {
      map['quiet_start_minutes'] = Variable<int>(quietStartMinutes.value);
    }
    if (quietEndMinutes.present) {
      map['quiet_end_minutes'] = Variable<int>(quietEndMinutes.value);
    }
    if (snoozeLimit.present) {
      map['snooze_limit'] = Variable<int>(snoozeLimit.value);
    }
    if (coolingOffThreshold.present) {
      map['cooling_off_threshold'] = Variable<int>(coolingOffThreshold.value);
    }
    if (coolingOffHours.present) {
      map['cooling_off_hours'] = Variable<int>(coolingOffHours.value);
    }
    if (checkInDay.present) {
      map['check_in_day'] = Variable<int>(checkInDay.value);
    }
    if (checkInMinutes.present) {
      map['check_in_minutes'] = Variable<int>(checkInMinutes.value);
    }
    if (appLock.present) {
      map['app_lock'] = Variable<bool>(appLock.value);
    }
    if (lockTimeout.present) {
      map['lock_timeout'] = Variable<String>(
        $SettingsRowsTable.$converterlockTimeout.toSql(lockTimeout.value),
      );
    }
    if (hideAmounts.present) {
      map['hide_amounts'] = Variable<bool>(hideAmounts.value);
    }
    if (billReminders.present) {
      map['bill_reminders'] = Variable<bool>(billReminders.value);
    }
    if (autoFile.present) {
      map['auto_file'] = Variable<bool>(autoFile.value);
    }
    if (goalShareFallback.present) {
      map['goal_share_fallback'] = Variable<String>(
        $SettingsRowsTable.$convertergoalShareFallback.toSql(
          goalShareFallback.value,
        ),
      );
    }
    if (setupCompletedAt.present) {
      map['setup_completed_at'] = Variable<DateTime>(setupCompletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRowsCompanion(')
          ..write('id: $id, ')
          ..write('timeZone: $timeZone, ')
          ..write('quietStartMinutes: $quietStartMinutes, ')
          ..write('quietEndMinutes: $quietEndMinutes, ')
          ..write('snoozeLimit: $snoozeLimit, ')
          ..write('coolingOffThreshold: $coolingOffThreshold, ')
          ..write('coolingOffHours: $coolingOffHours, ')
          ..write('checkInDay: $checkInDay, ')
          ..write('checkInMinutes: $checkInMinutes, ')
          ..write('appLock: $appLock, ')
          ..write('lockTimeout: $lockTimeout, ')
          ..write('hideAmounts: $hideAmounts, ')
          ..write('billReminders: $billReminders, ')
          ..write('autoFile: $autoFile, ')
          ..write('goalShareFallback: $goalShareFallback, ')
          ..write('setupCompletedAt: $setupCompletedAt')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Greeting, String> greeting =
      GeneratedColumn<String>(
        'greeting',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Greeting>($ProfilesTable.$convertergreeting);
  static const VerificationMeta _timeZoneMeta = const VerificationMeta(
    'timeZone',
  );
  @override
  late final GeneratedColumn<String> timeZone = GeneratedColumn<String>(
    'time_zone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    greeting,
    timeZone,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('time_zone')) {
      context.handle(
        _timeZoneMeta,
        timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta),
      );
    } else if (isInserting) {
      context.missing(_timeZoneMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      greeting: $ProfilesTable.$convertergreeting.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}greeting'],
        )!,
      ),
      timeZone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_zone'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Greeting, String, String> $convertergreeting =
      const EnumNameConverter<Greeting>(Greeting.values);
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final int id;
  final String? displayName;
  final Greeting greeting;
  final String timeZone;
  final DateTime createdAt;
  const ProfileRow({
    required this.id,
    this.displayName,
    required this.greeting,
    required this.timeZone,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    {
      map['greeting'] = Variable<String>(
        $ProfilesTable.$convertergreeting.toSql(greeting),
      );
    }
    map['time_zone'] = Variable<String>(timeZone);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      greeting: Value(greeting),
      timeZone: Value(timeZone),
      createdAt: Value(createdAt),
    );
  }

  factory ProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      greeting: $ProfilesTable.$convertergreeting.fromJson(
        serializer.fromJson<String>(json['greeting']),
      ),
      timeZone: serializer.fromJson<String>(json['timeZone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'greeting': serializer.toJson<String>(
        $ProfilesTable.$convertergreeting.toJson(greeting),
      ),
      'timeZone': serializer.toJson<String>(timeZone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProfileRow copyWith({
    int? id,
    Value<String?> displayName = const Value.absent(),
    Greeting? greeting,
    String? timeZone,
    DateTime? createdAt,
  }) => ProfileRow(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    greeting: greeting ?? this.greeting,
    timeZone: timeZone ?? this.timeZone,
    createdAt: createdAt ?? this.createdAt,
  );
  ProfileRow copyWithCompanion(ProfilesCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      greeting: data.greeting.present ? data.greeting.value : this.greeting,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('greeting: $greeting, ')
          ..write('timeZone: $timeZone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, displayName, greeting, timeZone, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.greeting == this.greeting &&
          other.timeZone == this.timeZone &&
          other.createdAt == this.createdAt);
}

class ProfilesCompanion extends UpdateCompanion<ProfileRow> {
  final Value<int> id;
  final Value<String?> displayName;
  final Value<Greeting> greeting;
  final Value<String> timeZone;
  final Value<DateTime> createdAt;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.greeting = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    required Greeting greeting,
    required String timeZone,
    required DateTime createdAt,
  }) : greeting = Value(greeting),
       timeZone = Value(timeZone),
       createdAt = Value(createdAt);
  static Insertable<ProfileRow> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? greeting,
    Expression<String>? timeZone,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (greeting != null) 'greeting': greeting,
      if (timeZone != null) 'time_zone': timeZone,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String?>? displayName,
    Value<Greeting>? greeting,
    Value<String>? timeZone,
    Value<DateTime>? createdAt,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      greeting: greeting ?? this.greeting,
      timeZone: timeZone ?? this.timeZone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (greeting.present) {
      map['greeting'] = Variable<String>(
        $ProfilesTable.$convertergreeting.toSql(greeting.value),
      );
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('greeting: $greeting, ')
          ..write('timeZone: $timeZone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [name, isDefault, archived];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final String name;
  final bool isDefault;
  final bool archived;
  const CategoryRow({
    required this.name,
    required this.isDefault,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['is_default'] = Variable<bool>(isDefault);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      name: Value(name),
      isDefault: Value(isDefault),
      archived: Value(archived),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      name: serializer.fromJson<String>(json['name']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'isDefault': serializer.toJson<bool>(isDefault),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  CategoryRow copyWith({String? name, bool? isDefault, bool? archived}) =>
      CategoryRow(
        name: name ?? this.name,
        isDefault: isDefault ?? this.isDefault,
        archived: archived ?? this.archived,
      );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      name: data.name.present ? data.name.value : this.name,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, isDefault, archived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.name == this.name &&
          other.isDefault == this.isDefault &&
          other.archived == this.archived);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<String> name;
  final Value<bool> isDefault;
  final Value<bool> archived;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.name = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String name,
    this.isDefault = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CategoryRow> custom({
    Expression<String>? name,
    Expression<bool>? isDefault,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (isDefault != null) 'is_default': isDefault,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? name,
    Value<bool>? isDefault,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('name: $name, ')
          ..write('isDefault: $isDefault, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HelpFeedbacksTable extends HelpFeedbacks
    with TableInfo<$HelpFeedbacksTable, HelpFeedbackRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HelpFeedbacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _helpfulMeta = const VerificationMeta(
    'helpful',
  );
  @override
  late final GeneratedColumn<bool> helpful = GeneratedColumn<bool>(
    'helpful',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("helpful" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [articleId, helpful];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'help_feedback';
  @override
  VerificationContext validateIntegrity(
    Insertable<HelpFeedbackRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('helpful')) {
      context.handle(
        _helpfulMeta,
        helpful.isAcceptableOrUnknown(data['helpful']!, _helpfulMeta),
      );
    } else if (isInserting) {
      context.missing(_helpfulMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId};
  @override
  HelpFeedbackRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HelpFeedbackRow(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      helpful: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}helpful'],
      )!,
    );
  }

  @override
  $HelpFeedbacksTable createAlias(String alias) {
    return $HelpFeedbacksTable(attachedDatabase, alias);
  }
}

class HelpFeedbackRow extends DataClass implements Insertable<HelpFeedbackRow> {
  final String articleId;
  final bool helpful;
  const HelpFeedbackRow({required this.articleId, required this.helpful});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<String>(articleId);
    map['helpful'] = Variable<bool>(helpful);
    return map;
  }

  HelpFeedbacksCompanion toCompanion(bool nullToAbsent) {
    return HelpFeedbacksCompanion(
      articleId: Value(articleId),
      helpful: Value(helpful),
    );
  }

  factory HelpFeedbackRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HelpFeedbackRow(
      articleId: serializer.fromJson<String>(json['articleId']),
      helpful: serializer.fromJson<bool>(json['helpful']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<String>(articleId),
      'helpful': serializer.toJson<bool>(helpful),
    };
  }

  HelpFeedbackRow copyWith({String? articleId, bool? helpful}) =>
      HelpFeedbackRow(
        articleId: articleId ?? this.articleId,
        helpful: helpful ?? this.helpful,
      );
  HelpFeedbackRow copyWithCompanion(HelpFeedbacksCompanion data) {
    return HelpFeedbackRow(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      helpful: data.helpful.present ? data.helpful.value : this.helpful,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HelpFeedbackRow(')
          ..write('articleId: $articleId, ')
          ..write('helpful: $helpful')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(articleId, helpful);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HelpFeedbackRow &&
          other.articleId == this.articleId &&
          other.helpful == this.helpful);
}

class HelpFeedbacksCompanion extends UpdateCompanion<HelpFeedbackRow> {
  final Value<String> articleId;
  final Value<bool> helpful;
  final Value<int> rowid;
  const HelpFeedbacksCompanion({
    this.articleId = const Value.absent(),
    this.helpful = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HelpFeedbacksCompanion.insert({
    required String articleId,
    required bool helpful,
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId),
       helpful = Value(helpful);
  static Insertable<HelpFeedbackRow> custom({
    Expression<String>? articleId,
    Expression<bool>? helpful,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (helpful != null) 'helpful': helpful,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HelpFeedbacksCompanion copyWith({
    Value<String>? articleId,
    Value<bool>? helpful,
    Value<int>? rowid,
  }) {
    return HelpFeedbacksCompanion(
      articleId: articleId ?? this.articleId,
      helpful: helpful ?? this.helpful,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (helpful.present) {
      map['helpful'] = Variable<bool>(helpful.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HelpFeedbacksCompanion(')
          ..write('articleId: $articleId, ')
          ..write('helpful: $helpful, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LedgerEntriesTable extends LedgerEntries
    with TableInfo<$LedgerEntriesTable, LedgerEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LedgerEntryKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LedgerEntryKind>($LedgerEntriesTable.$converterkind);
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _counterBucketIdMeta = const VerificationMeta(
    'counterBucketId',
  );
  @override
  late final GeneratedColumn<String> counterBucketId = GeneratedColumn<String>(
    'counter_bucket_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paydayIdMeta = const VerificationMeta(
    'paydayId',
  );
  @override
  late final GeneratedColumn<String> paydayId = GeneratedColumn<String>(
    'payday_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferIdMeta = const VerificationMeta(
    'transferId',
  );
  @override
  late final GeneratedColumn<String> transferId = GeneratedColumn<String>(
    'transfer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alertIdMeta = const VerificationMeta(
    'alertId',
  );
  @override
  late final GeneratedColumn<String> alertId = GeneratedColumn<String>(
    'alert_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptIdMeta = const VerificationMeta(
    'receiptId',
  );
  @override
  late final GeneratedColumn<String> receiptId = GeneratedColumn<String>(
    'receipt_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carryOverIdMeta = const VerificationMeta(
    'carryOverId',
  );
  @override
  late final GeneratedColumn<String> carryOverId = GeneratedColumn<String>(
    'carry_over_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reversesEntryIdMeta = const VerificationMeta(
    'reversesEntryId',
  );
  @override
  late final GeneratedColumn<String> reversesEntryId = GeneratedColumn<String>(
    'reverses_entry_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    occurredAt,
    kind,
    bucketId,
    amount,
    counterBucketId,
    paydayId,
    transferId,
    alertId,
    transactionId,
    receiptId,
    billId,
    carryOverId,
    note,
    reversesEntryId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('counter_bucket_id')) {
      context.handle(
        _counterBucketIdMeta,
        counterBucketId.isAcceptableOrUnknown(
          data['counter_bucket_id']!,
          _counterBucketIdMeta,
        ),
      );
    }
    if (data.containsKey('payday_id')) {
      context.handle(
        _paydayIdMeta,
        paydayId.isAcceptableOrUnknown(data['payday_id']!, _paydayIdMeta),
      );
    }
    if (data.containsKey('transfer_id')) {
      context.handle(
        _transferIdMeta,
        transferId.isAcceptableOrUnknown(data['transfer_id']!, _transferIdMeta),
      );
    }
    if (data.containsKey('alert_id')) {
      context.handle(
        _alertIdMeta,
        alertId.isAcceptableOrUnknown(data['alert_id']!, _alertIdMeta),
      );
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('receipt_id')) {
      context.handle(
        _receiptIdMeta,
        receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta),
      );
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    }
    if (data.containsKey('carry_over_id')) {
      context.handle(
        _carryOverIdMeta,
        carryOverId.isAcceptableOrUnknown(
          data['carry_over_id']!,
          _carryOverIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('reverses_entry_id')) {
      context.handle(
        _reversesEntryIdMeta,
        reversesEntryId.isAcceptableOrUnknown(
          data['reverses_entry_id']!,
          _reversesEntryIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LedgerEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      kind: $LedgerEntriesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      counterBucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counter_bucket_id'],
      ),
      paydayId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payday_id'],
      ),
      transferId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_id'],
      ),
      alertId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_id'],
      ),
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
      receiptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_id'],
      ),
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      ),
      carryOverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}carry_over_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      reversesEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reverses_entry_id'],
      ),
    );
  }

  @override
  $LedgerEntriesTable createAlias(String alias) {
    return $LedgerEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LedgerEntryKind, String, String> $converterkind =
      const EnumNameConverter<LedgerEntryKind>(LedgerEntryKind.values);
}

class LedgerEntryRow extends DataClass implements Insertable<LedgerEntryRow> {
  final String id;
  final DateTime occurredAt;
  final LedgerEntryKind kind;
  final String bucketId;
  final int amount;
  final String? counterBucketId;
  final String? paydayId;
  final String? transferId;
  final String? alertId;
  final String? transactionId;
  final String? receiptId;
  final String? billId;
  final String? carryOverId;
  final String? note;
  final String? reversesEntryId;
  const LedgerEntryRow({
    required this.id,
    required this.occurredAt,
    required this.kind,
    required this.bucketId,
    required this.amount,
    this.counterBucketId,
    this.paydayId,
    this.transferId,
    this.alertId,
    this.transactionId,
    this.receiptId,
    this.billId,
    this.carryOverId,
    this.note,
    this.reversesEntryId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    {
      map['kind'] = Variable<String>(
        $LedgerEntriesTable.$converterkind.toSql(kind),
      );
    }
    map['bucket_id'] = Variable<String>(bucketId);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || counterBucketId != null) {
      map['counter_bucket_id'] = Variable<String>(counterBucketId);
    }
    if (!nullToAbsent || paydayId != null) {
      map['payday_id'] = Variable<String>(paydayId);
    }
    if (!nullToAbsent || transferId != null) {
      map['transfer_id'] = Variable<String>(transferId);
    }
    if (!nullToAbsent || alertId != null) {
      map['alert_id'] = Variable<String>(alertId);
    }
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    if (!nullToAbsent || receiptId != null) {
      map['receipt_id'] = Variable<String>(receiptId);
    }
    if (!nullToAbsent || billId != null) {
      map['bill_id'] = Variable<String>(billId);
    }
    if (!nullToAbsent || carryOverId != null) {
      map['carry_over_id'] = Variable<String>(carryOverId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || reversesEntryId != null) {
      map['reverses_entry_id'] = Variable<String>(reversesEntryId);
    }
    return map;
  }

  LedgerEntriesCompanion toCompanion(bool nullToAbsent) {
    return LedgerEntriesCompanion(
      id: Value(id),
      occurredAt: Value(occurredAt),
      kind: Value(kind),
      bucketId: Value(bucketId),
      amount: Value(amount),
      counterBucketId: counterBucketId == null && nullToAbsent
          ? const Value.absent()
          : Value(counterBucketId),
      paydayId: paydayId == null && nullToAbsent
          ? const Value.absent()
          : Value(paydayId),
      transferId: transferId == null && nullToAbsent
          ? const Value.absent()
          : Value(transferId),
      alertId: alertId == null && nullToAbsent
          ? const Value.absent()
          : Value(alertId),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      receiptId: receiptId == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptId),
      billId: billId == null && nullToAbsent
          ? const Value.absent()
          : Value(billId),
      carryOverId: carryOverId == null && nullToAbsent
          ? const Value.absent()
          : Value(carryOverId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      reversesEntryId: reversesEntryId == null && nullToAbsent
          ? const Value.absent()
          : Value(reversesEntryId),
    );
  }

  factory LedgerEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerEntryRow(
      id: serializer.fromJson<String>(json['id']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      kind: $LedgerEntriesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      bucketId: serializer.fromJson<String>(json['bucketId']),
      amount: serializer.fromJson<int>(json['amount']),
      counterBucketId: serializer.fromJson<String?>(json['counterBucketId']),
      paydayId: serializer.fromJson<String?>(json['paydayId']),
      transferId: serializer.fromJson<String?>(json['transferId']),
      alertId: serializer.fromJson<String?>(json['alertId']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      receiptId: serializer.fromJson<String?>(json['receiptId']),
      billId: serializer.fromJson<String?>(json['billId']),
      carryOverId: serializer.fromJson<String?>(json['carryOverId']),
      note: serializer.fromJson<String?>(json['note']),
      reversesEntryId: serializer.fromJson<String?>(json['reversesEntryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'kind': serializer.toJson<String>(
        $LedgerEntriesTable.$converterkind.toJson(kind),
      ),
      'bucketId': serializer.toJson<String>(bucketId),
      'amount': serializer.toJson<int>(amount),
      'counterBucketId': serializer.toJson<String?>(counterBucketId),
      'paydayId': serializer.toJson<String?>(paydayId),
      'transferId': serializer.toJson<String?>(transferId),
      'alertId': serializer.toJson<String?>(alertId),
      'transactionId': serializer.toJson<String?>(transactionId),
      'receiptId': serializer.toJson<String?>(receiptId),
      'billId': serializer.toJson<String?>(billId),
      'carryOverId': serializer.toJson<String?>(carryOverId),
      'note': serializer.toJson<String?>(note),
      'reversesEntryId': serializer.toJson<String?>(reversesEntryId),
    };
  }

  LedgerEntryRow copyWith({
    String? id,
    DateTime? occurredAt,
    LedgerEntryKind? kind,
    String? bucketId,
    int? amount,
    Value<String?> counterBucketId = const Value.absent(),
    Value<String?> paydayId = const Value.absent(),
    Value<String?> transferId = const Value.absent(),
    Value<String?> alertId = const Value.absent(),
    Value<String?> transactionId = const Value.absent(),
    Value<String?> receiptId = const Value.absent(),
    Value<String?> billId = const Value.absent(),
    Value<String?> carryOverId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> reversesEntryId = const Value.absent(),
  }) => LedgerEntryRow(
    id: id ?? this.id,
    occurredAt: occurredAt ?? this.occurredAt,
    kind: kind ?? this.kind,
    bucketId: bucketId ?? this.bucketId,
    amount: amount ?? this.amount,
    counterBucketId: counterBucketId.present
        ? counterBucketId.value
        : this.counterBucketId,
    paydayId: paydayId.present ? paydayId.value : this.paydayId,
    transferId: transferId.present ? transferId.value : this.transferId,
    alertId: alertId.present ? alertId.value : this.alertId,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    receiptId: receiptId.present ? receiptId.value : this.receiptId,
    billId: billId.present ? billId.value : this.billId,
    carryOverId: carryOverId.present ? carryOverId.value : this.carryOverId,
    note: note.present ? note.value : this.note,
    reversesEntryId: reversesEntryId.present
        ? reversesEntryId.value
        : this.reversesEntryId,
  );
  LedgerEntryRow copyWithCompanion(LedgerEntriesCompanion data) {
    return LedgerEntryRow(
      id: data.id.present ? data.id.value : this.id,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      kind: data.kind.present ? data.kind.value : this.kind,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      amount: data.amount.present ? data.amount.value : this.amount,
      counterBucketId: data.counterBucketId.present
          ? data.counterBucketId.value
          : this.counterBucketId,
      paydayId: data.paydayId.present ? data.paydayId.value : this.paydayId,
      transferId: data.transferId.present
          ? data.transferId.value
          : this.transferId,
      alertId: data.alertId.present ? data.alertId.value : this.alertId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      billId: data.billId.present ? data.billId.value : this.billId,
      carryOverId: data.carryOverId.present
          ? data.carryOverId.value
          : this.carryOverId,
      note: data.note.present ? data.note.value : this.note,
      reversesEntryId: data.reversesEntryId.present
          ? data.reversesEntryId.value
          : this.reversesEntryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntryRow(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('kind: $kind, ')
          ..write('bucketId: $bucketId, ')
          ..write('amount: $amount, ')
          ..write('counterBucketId: $counterBucketId, ')
          ..write('paydayId: $paydayId, ')
          ..write('transferId: $transferId, ')
          ..write('alertId: $alertId, ')
          ..write('transactionId: $transactionId, ')
          ..write('receiptId: $receiptId, ')
          ..write('billId: $billId, ')
          ..write('carryOverId: $carryOverId, ')
          ..write('note: $note, ')
          ..write('reversesEntryId: $reversesEntryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    occurredAt,
    kind,
    bucketId,
    amount,
    counterBucketId,
    paydayId,
    transferId,
    alertId,
    transactionId,
    receiptId,
    billId,
    carryOverId,
    note,
    reversesEntryId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerEntryRow &&
          other.id == this.id &&
          other.occurredAt == this.occurredAt &&
          other.kind == this.kind &&
          other.bucketId == this.bucketId &&
          other.amount == this.amount &&
          other.counterBucketId == this.counterBucketId &&
          other.paydayId == this.paydayId &&
          other.transferId == this.transferId &&
          other.alertId == this.alertId &&
          other.transactionId == this.transactionId &&
          other.receiptId == this.receiptId &&
          other.billId == this.billId &&
          other.carryOverId == this.carryOverId &&
          other.note == this.note &&
          other.reversesEntryId == this.reversesEntryId);
}

class LedgerEntriesCompanion extends UpdateCompanion<LedgerEntryRow> {
  final Value<String> id;
  final Value<DateTime> occurredAt;
  final Value<LedgerEntryKind> kind;
  final Value<String> bucketId;
  final Value<int> amount;
  final Value<String?> counterBucketId;
  final Value<String?> paydayId;
  final Value<String?> transferId;
  final Value<String?> alertId;
  final Value<String?> transactionId;
  final Value<String?> receiptId;
  final Value<String?> billId;
  final Value<String?> carryOverId;
  final Value<String?> note;
  final Value<String?> reversesEntryId;
  final Value<int> rowid;
  const LedgerEntriesCompanion({
    this.id = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.amount = const Value.absent(),
    this.counterBucketId = const Value.absent(),
    this.paydayId = const Value.absent(),
    this.transferId = const Value.absent(),
    this.alertId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.billId = const Value.absent(),
    this.carryOverId = const Value.absent(),
    this.note = const Value.absent(),
    this.reversesEntryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LedgerEntriesCompanion.insert({
    required String id,
    required DateTime occurredAt,
    required LedgerEntryKind kind,
    required String bucketId,
    required int amount,
    this.counterBucketId = const Value.absent(),
    this.paydayId = const Value.absent(),
    this.transferId = const Value.absent(),
    this.alertId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.billId = const Value.absent(),
    this.carryOverId = const Value.absent(),
    this.note = const Value.absent(),
    this.reversesEntryId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       occurredAt = Value(occurredAt),
       kind = Value(kind),
       bucketId = Value(bucketId),
       amount = Value(amount);
  static Insertable<LedgerEntryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? occurredAt,
    Expression<String>? kind,
    Expression<String>? bucketId,
    Expression<int>? amount,
    Expression<String>? counterBucketId,
    Expression<String>? paydayId,
    Expression<String>? transferId,
    Expression<String>? alertId,
    Expression<String>? transactionId,
    Expression<String>? receiptId,
    Expression<String>? billId,
    Expression<String>? carryOverId,
    Expression<String>? note,
    Expression<String>? reversesEntryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (kind != null) 'kind': kind,
      if (bucketId != null) 'bucket_id': bucketId,
      if (amount != null) 'amount': amount,
      if (counterBucketId != null) 'counter_bucket_id': counterBucketId,
      if (paydayId != null) 'payday_id': paydayId,
      if (transferId != null) 'transfer_id': transferId,
      if (alertId != null) 'alert_id': alertId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (receiptId != null) 'receipt_id': receiptId,
      if (billId != null) 'bill_id': billId,
      if (carryOverId != null) 'carry_over_id': carryOverId,
      if (note != null) 'note': note,
      if (reversesEntryId != null) 'reverses_entry_id': reversesEntryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LedgerEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? occurredAt,
    Value<LedgerEntryKind>? kind,
    Value<String>? bucketId,
    Value<int>? amount,
    Value<String?>? counterBucketId,
    Value<String?>? paydayId,
    Value<String?>? transferId,
    Value<String?>? alertId,
    Value<String?>? transactionId,
    Value<String?>? receiptId,
    Value<String?>? billId,
    Value<String?>? carryOverId,
    Value<String?>? note,
    Value<String?>? reversesEntryId,
    Value<int>? rowid,
  }) {
    return LedgerEntriesCompanion(
      id: id ?? this.id,
      occurredAt: occurredAt ?? this.occurredAt,
      kind: kind ?? this.kind,
      bucketId: bucketId ?? this.bucketId,
      amount: amount ?? this.amount,
      counterBucketId: counterBucketId ?? this.counterBucketId,
      paydayId: paydayId ?? this.paydayId,
      transferId: transferId ?? this.transferId,
      alertId: alertId ?? this.alertId,
      transactionId: transactionId ?? this.transactionId,
      receiptId: receiptId ?? this.receiptId,
      billId: billId ?? this.billId,
      carryOverId: carryOverId ?? this.carryOverId,
      note: note ?? this.note,
      reversesEntryId: reversesEntryId ?? this.reversesEntryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $LedgerEntriesTable.$converterkind.toSql(kind.value),
      );
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (counterBucketId.present) {
      map['counter_bucket_id'] = Variable<String>(counterBucketId.value);
    }
    if (paydayId.present) {
      map['payday_id'] = Variable<String>(paydayId.value);
    }
    if (transferId.present) {
      map['transfer_id'] = Variable<String>(transferId.value);
    }
    if (alertId.present) {
      map['alert_id'] = Variable<String>(alertId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (receiptId.present) {
      map['receipt_id'] = Variable<String>(receiptId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (carryOverId.present) {
      map['carry_over_id'] = Variable<String>(carryOverId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (reversesEntryId.present) {
      map['reverses_entry_id'] = Variable<String>(reversesEntryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('kind: $kind, ')
          ..write('bucketId: $bucketId, ')
          ..write('amount: $amount, ')
          ..write('counterBucketId: $counterBucketId, ')
          ..write('paydayId: $paydayId, ')
          ..write('transferId: $transferId, ')
          ..write('alertId: $alertId, ')
          ..write('transactionId: $transactionId, ')
          ..write('receiptId: $receiptId, ')
          ..write('billId: $billId, ')
          ..write('carryOverId: $carryOverId, ')
          ..write('note: $note, ')
          ..write('reversesEntryId: $reversesEntryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaydaysTable extends Paydays with TableInfo<$PaydaysTable, PaydayRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaydaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incomeSourceIdMeta = const VerificationMeta(
    'incomeSourceId',
  );
  @override
  late final GeneratedColumn<String> incomeSourceId = GeneratedColumn<String>(
    'income_source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snoozesUsedMeta = const VerificationMeta(
    'snoozesUsed',
  );
  @override
  late final GeneratedColumn<int> snoozesUsed = GeneratedColumn<int>(
    'snoozes_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaydayStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PaydayStatus>($PaydaysTable.$converterstatus);
  static const VerificationMeta _snoozedUntilMeta = const VerificationMeta(
    'snoozedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> snoozedUntil = GeneratedColumn<DateTime>(
    'snoozed_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    incomeSourceId,
    amount,
    startedAt,
    snoozesUsed,
    status,
    snoozedUntil,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paydays';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaydayRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('income_source_id')) {
      context.handle(
        _incomeSourceIdMeta,
        incomeSourceId.isAcceptableOrUnknown(
          data['income_source_id']!,
          _incomeSourceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_incomeSourceIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('snoozes_used')) {
      context.handle(
        _snoozesUsedMeta,
        snoozesUsed.isAcceptableOrUnknown(
          data['snoozes_used']!,
          _snoozesUsedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_snoozesUsedMeta);
    }
    if (data.containsKey('snoozed_until')) {
      context.handle(
        _snoozedUntilMeta,
        snoozedUntil.isAcceptableOrUnknown(
          data['snoozed_until']!,
          _snoozedUntilMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaydayRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaydayRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      incomeSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}income_source_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      snoozesUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snoozes_used'],
      )!,
      status: $PaydaysTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      snoozedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snoozed_until'],
      ),
    );
  }

  @override
  $PaydaysTable createAlias(String alias) {
    return $PaydaysTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaydayStatus, String, String> $converterstatus =
      const EnumNameConverter<PaydayStatus>(PaydayStatus.values);
}

class PaydayRow extends DataClass implements Insertable<PaydayRow> {
  final String id;
  final String incomeSourceId;
  final int amount;
  final DateTime startedAt;
  final int snoozesUsed;
  final PaydayStatus status;
  final DateTime? snoozedUntil;
  const PaydayRow({
    required this.id,
    required this.incomeSourceId,
    required this.amount,
    required this.startedAt,
    required this.snoozesUsed,
    required this.status,
    this.snoozedUntil,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['income_source_id'] = Variable<String>(incomeSourceId);
    map['amount'] = Variable<int>(amount);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['snoozes_used'] = Variable<int>(snoozesUsed);
    {
      map['status'] = Variable<String>(
        $PaydaysTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || snoozedUntil != null) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil);
    }
    return map;
  }

  PaydaysCompanion toCompanion(bool nullToAbsent) {
    return PaydaysCompanion(
      id: Value(id),
      incomeSourceId: Value(incomeSourceId),
      amount: Value(amount),
      startedAt: Value(startedAt),
      snoozesUsed: Value(snoozesUsed),
      status: Value(status),
      snoozedUntil: snoozedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozedUntil),
    );
  }

  factory PaydayRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaydayRow(
      id: serializer.fromJson<String>(json['id']),
      incomeSourceId: serializer.fromJson<String>(json['incomeSourceId']),
      amount: serializer.fromJson<int>(json['amount']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      snoozesUsed: serializer.fromJson<int>(json['snoozesUsed']),
      status: $PaydaysTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      snoozedUntil: serializer.fromJson<DateTime?>(json['snoozedUntil']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'incomeSourceId': serializer.toJson<String>(incomeSourceId),
      'amount': serializer.toJson<int>(amount),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'snoozesUsed': serializer.toJson<int>(snoozesUsed),
      'status': serializer.toJson<String>(
        $PaydaysTable.$converterstatus.toJson(status),
      ),
      'snoozedUntil': serializer.toJson<DateTime?>(snoozedUntil),
    };
  }

  PaydayRow copyWith({
    String? id,
    String? incomeSourceId,
    int? amount,
    DateTime? startedAt,
    int? snoozesUsed,
    PaydayStatus? status,
    Value<DateTime?> snoozedUntil = const Value.absent(),
  }) => PaydayRow(
    id: id ?? this.id,
    incomeSourceId: incomeSourceId ?? this.incomeSourceId,
    amount: amount ?? this.amount,
    startedAt: startedAt ?? this.startedAt,
    snoozesUsed: snoozesUsed ?? this.snoozesUsed,
    status: status ?? this.status,
    snoozedUntil: snoozedUntil.present ? snoozedUntil.value : this.snoozedUntil,
  );
  PaydayRow copyWithCompanion(PaydaysCompanion data) {
    return PaydayRow(
      id: data.id.present ? data.id.value : this.id,
      incomeSourceId: data.incomeSourceId.present
          ? data.incomeSourceId.value
          : this.incomeSourceId,
      amount: data.amount.present ? data.amount.value : this.amount,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      snoozesUsed: data.snoozesUsed.present
          ? data.snoozesUsed.value
          : this.snoozesUsed,
      status: data.status.present ? data.status.value : this.status,
      snoozedUntil: data.snoozedUntil.present
          ? data.snoozedUntil.value
          : this.snoozedUntil,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaydayRow(')
          ..write('id: $id, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('amount: $amount, ')
          ..write('startedAt: $startedAt, ')
          ..write('snoozesUsed: $snoozesUsed, ')
          ..write('status: $status, ')
          ..write('snoozedUntil: $snoozedUntil')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    incomeSourceId,
    amount,
    startedAt,
    snoozesUsed,
    status,
    snoozedUntil,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaydayRow &&
          other.id == this.id &&
          other.incomeSourceId == this.incomeSourceId &&
          other.amount == this.amount &&
          other.startedAt == this.startedAt &&
          other.snoozesUsed == this.snoozesUsed &&
          other.status == this.status &&
          other.snoozedUntil == this.snoozedUntil);
}

class PaydaysCompanion extends UpdateCompanion<PaydayRow> {
  final Value<String> id;
  final Value<String> incomeSourceId;
  final Value<int> amount;
  final Value<DateTime> startedAt;
  final Value<int> snoozesUsed;
  final Value<PaydayStatus> status;
  final Value<DateTime?> snoozedUntil;
  final Value<int> rowid;
  const PaydaysCompanion({
    this.id = const Value.absent(),
    this.incomeSourceId = const Value.absent(),
    this.amount = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.snoozesUsed = const Value.absent(),
    this.status = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaydaysCompanion.insert({
    required String id,
    required String incomeSourceId,
    required int amount,
    required DateTime startedAt,
    required int snoozesUsed,
    required PaydayStatus status,
    this.snoozedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       incomeSourceId = Value(incomeSourceId),
       amount = Value(amount),
       startedAt = Value(startedAt),
       snoozesUsed = Value(snoozesUsed),
       status = Value(status);
  static Insertable<PaydayRow> custom({
    Expression<String>? id,
    Expression<String>? incomeSourceId,
    Expression<int>? amount,
    Expression<DateTime>? startedAt,
    Expression<int>? snoozesUsed,
    Expression<String>? status,
    Expression<DateTime>? snoozedUntil,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (incomeSourceId != null) 'income_source_id': incomeSourceId,
      if (amount != null) 'amount': amount,
      if (startedAt != null) 'started_at': startedAt,
      if (snoozesUsed != null) 'snoozes_used': snoozesUsed,
      if (status != null) 'status': status,
      if (snoozedUntil != null) 'snoozed_until': snoozedUntil,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaydaysCompanion copyWith({
    Value<String>? id,
    Value<String>? incomeSourceId,
    Value<int>? amount,
    Value<DateTime>? startedAt,
    Value<int>? snoozesUsed,
    Value<PaydayStatus>? status,
    Value<DateTime?>? snoozedUntil,
    Value<int>? rowid,
  }) {
    return PaydaysCompanion(
      id: id ?? this.id,
      incomeSourceId: incomeSourceId ?? this.incomeSourceId,
      amount: amount ?? this.amount,
      startedAt: startedAt ?? this.startedAt,
      snoozesUsed: snoozesUsed ?? this.snoozesUsed,
      status: status ?? this.status,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (incomeSourceId.present) {
      map['income_source_id'] = Variable<String>(incomeSourceId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (snoozesUsed.present) {
      map['snoozes_used'] = Variable<int>(snoozesUsed.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PaydaysTable.$converterstatus.toSql(status.value),
      );
    }
    if (snoozedUntil.present) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaydaysCompanion(')
          ..write('id: $id, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('amount: $amount, ')
          ..write('startedAt: $startedAt, ')
          ..write('snoozesUsed: $snoozesUsed, ')
          ..write('status: $status, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransfersTable extends Transfers
    with TableInfo<$TransfersTable, TransferRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransfersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paydayIdMeta = const VerificationMeta(
    'paydayId',
  );
  @override
  late final GeneratedColumn<String> paydayId = GeneratedColumn<String>(
    'payday_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES paydays (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toAccountIdMeta = const VerificationMeta(
    'toAccountId',
  );
  @override
  late final GeneratedColumn<String> toAccountId = GeneratedColumn<String>(
    'to_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransferStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TransferStatus>($TransfersTable.$converterstatus);
  static const VerificationMeta _provenAmountMeta = const VerificationMeta(
    'provenAmount',
  );
  @override
  late final GeneratedColumn<int> provenAmount = GeneratedColumn<int>(
    'proven_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _owedAmountMeta = const VerificationMeta(
    'owedAmount',
  );
  @override
  late final GeneratedColumn<int> owedAmount = GeneratedColumn<int>(
    'owed_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _provenAtMeta = const VerificationMeta(
    'provenAt',
  );
  @override
  late final GeneratedColumn<DateTime> provenAt = GeneratedColumn<DateTime>(
    'proven_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    paydayId,
    position,
    bucketId,
    toAccountId,
    amount,
    status,
    provenAmount,
    owedAmount,
    provenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransferRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payday_id')) {
      context.handle(
        _paydayIdMeta,
        paydayId.isAcceptableOrUnknown(data['payday_id']!, _paydayIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paydayIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('to_account_id')) {
      context.handle(
        _toAccountIdMeta,
        toAccountId.isAcceptableOrUnknown(
          data['to_account_id']!,
          _toAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toAccountIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('proven_amount')) {
      context.handle(
        _provenAmountMeta,
        provenAmount.isAcceptableOrUnknown(
          data['proven_amount']!,
          _provenAmountMeta,
        ),
      );
    }
    if (data.containsKey('owed_amount')) {
      context.handle(
        _owedAmountMeta,
        owedAmount.isAcceptableOrUnknown(data['owed_amount']!, _owedAmountMeta),
      );
    }
    if (data.containsKey('proven_at')) {
      context.handle(
        _provenAtMeta,
        provenAt.isAcceptableOrUnknown(data['proven_at']!, _provenAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransferRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransferRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      paydayId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payday_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      toAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_account_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      status: $TransfersTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      provenAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}proven_amount'],
      ),
      owedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owed_amount'],
      ),
      provenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}proven_at'],
      ),
    );
  }

  @override
  $TransfersTable createAlias(String alias) {
    return $TransfersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransferStatus, String, String> $converterstatus =
      const EnumNameConverter<TransferStatus>(TransferStatus.values);
}

class TransferRow extends DataClass implements Insertable<TransferRow> {
  final String id;
  final String paydayId;
  final int position;
  final String bucketId;
  final String toAccountId;
  final int amount;
  final TransferStatus status;
  final int? provenAmount;
  final int? owedAmount;
  final DateTime? provenAt;
  const TransferRow({
    required this.id,
    required this.paydayId,
    required this.position,
    required this.bucketId,
    required this.toAccountId,
    required this.amount,
    required this.status,
    this.provenAmount,
    this.owedAmount,
    this.provenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payday_id'] = Variable<String>(paydayId);
    map['position'] = Variable<int>(position);
    map['bucket_id'] = Variable<String>(bucketId);
    map['to_account_id'] = Variable<String>(toAccountId);
    map['amount'] = Variable<int>(amount);
    {
      map['status'] = Variable<String>(
        $TransfersTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || provenAmount != null) {
      map['proven_amount'] = Variable<int>(provenAmount);
    }
    if (!nullToAbsent || owedAmount != null) {
      map['owed_amount'] = Variable<int>(owedAmount);
    }
    if (!nullToAbsent || provenAt != null) {
      map['proven_at'] = Variable<DateTime>(provenAt);
    }
    return map;
  }

  TransfersCompanion toCompanion(bool nullToAbsent) {
    return TransfersCompanion(
      id: Value(id),
      paydayId: Value(paydayId),
      position: Value(position),
      bucketId: Value(bucketId),
      toAccountId: Value(toAccountId),
      amount: Value(amount),
      status: Value(status),
      provenAmount: provenAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(provenAmount),
      owedAmount: owedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(owedAmount),
      provenAt: provenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(provenAt),
    );
  }

  factory TransferRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransferRow(
      id: serializer.fromJson<String>(json['id']),
      paydayId: serializer.fromJson<String>(json['paydayId']),
      position: serializer.fromJson<int>(json['position']),
      bucketId: serializer.fromJson<String>(json['bucketId']),
      toAccountId: serializer.fromJson<String>(json['toAccountId']),
      amount: serializer.fromJson<int>(json['amount']),
      status: $TransfersTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      provenAmount: serializer.fromJson<int?>(json['provenAmount']),
      owedAmount: serializer.fromJson<int?>(json['owedAmount']),
      provenAt: serializer.fromJson<DateTime?>(json['provenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'paydayId': serializer.toJson<String>(paydayId),
      'position': serializer.toJson<int>(position),
      'bucketId': serializer.toJson<String>(bucketId),
      'toAccountId': serializer.toJson<String>(toAccountId),
      'amount': serializer.toJson<int>(amount),
      'status': serializer.toJson<String>(
        $TransfersTable.$converterstatus.toJson(status),
      ),
      'provenAmount': serializer.toJson<int?>(provenAmount),
      'owedAmount': serializer.toJson<int?>(owedAmount),
      'provenAt': serializer.toJson<DateTime?>(provenAt),
    };
  }

  TransferRow copyWith({
    String? id,
    String? paydayId,
    int? position,
    String? bucketId,
    String? toAccountId,
    int? amount,
    TransferStatus? status,
    Value<int?> provenAmount = const Value.absent(),
    Value<int?> owedAmount = const Value.absent(),
    Value<DateTime?> provenAt = const Value.absent(),
  }) => TransferRow(
    id: id ?? this.id,
    paydayId: paydayId ?? this.paydayId,
    position: position ?? this.position,
    bucketId: bucketId ?? this.bucketId,
    toAccountId: toAccountId ?? this.toAccountId,
    amount: amount ?? this.amount,
    status: status ?? this.status,
    provenAmount: provenAmount.present ? provenAmount.value : this.provenAmount,
    owedAmount: owedAmount.present ? owedAmount.value : this.owedAmount,
    provenAt: provenAt.present ? provenAt.value : this.provenAt,
  );
  TransferRow copyWithCompanion(TransfersCompanion data) {
    return TransferRow(
      id: data.id.present ? data.id.value : this.id,
      paydayId: data.paydayId.present ? data.paydayId.value : this.paydayId,
      position: data.position.present ? data.position.value : this.position,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      toAccountId: data.toAccountId.present
          ? data.toAccountId.value
          : this.toAccountId,
      amount: data.amount.present ? data.amount.value : this.amount,
      status: data.status.present ? data.status.value : this.status,
      provenAmount: data.provenAmount.present
          ? data.provenAmount.value
          : this.provenAmount,
      owedAmount: data.owedAmount.present
          ? data.owedAmount.value
          : this.owedAmount,
      provenAt: data.provenAt.present ? data.provenAt.value : this.provenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransferRow(')
          ..write('id: $id, ')
          ..write('paydayId: $paydayId, ')
          ..write('position: $position, ')
          ..write('bucketId: $bucketId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('provenAmount: $provenAmount, ')
          ..write('owedAmount: $owedAmount, ')
          ..write('provenAt: $provenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    paydayId,
    position,
    bucketId,
    toAccountId,
    amount,
    status,
    provenAmount,
    owedAmount,
    provenAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferRow &&
          other.id == this.id &&
          other.paydayId == this.paydayId &&
          other.position == this.position &&
          other.bucketId == this.bucketId &&
          other.toAccountId == this.toAccountId &&
          other.amount == this.amount &&
          other.status == this.status &&
          other.provenAmount == this.provenAmount &&
          other.owedAmount == this.owedAmount &&
          other.provenAt == this.provenAt);
}

class TransfersCompanion extends UpdateCompanion<TransferRow> {
  final Value<String> id;
  final Value<String> paydayId;
  final Value<int> position;
  final Value<String> bucketId;
  final Value<String> toAccountId;
  final Value<int> amount;
  final Value<TransferStatus> status;
  final Value<int?> provenAmount;
  final Value<int?> owedAmount;
  final Value<DateTime?> provenAt;
  final Value<int> rowid;
  const TransfersCompanion({
    this.id = const Value.absent(),
    this.paydayId = const Value.absent(),
    this.position = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.amount = const Value.absent(),
    this.status = const Value.absent(),
    this.provenAmount = const Value.absent(),
    this.owedAmount = const Value.absent(),
    this.provenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransfersCompanion.insert({
    required String id,
    required String paydayId,
    required int position,
    required String bucketId,
    required String toAccountId,
    required int amount,
    required TransferStatus status,
    this.provenAmount = const Value.absent(),
    this.owedAmount = const Value.absent(),
    this.provenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       paydayId = Value(paydayId),
       position = Value(position),
       bucketId = Value(bucketId),
       toAccountId = Value(toAccountId),
       amount = Value(amount),
       status = Value(status);
  static Insertable<TransferRow> custom({
    Expression<String>? id,
    Expression<String>? paydayId,
    Expression<int>? position,
    Expression<String>? bucketId,
    Expression<String>? toAccountId,
    Expression<int>? amount,
    Expression<String>? status,
    Expression<int>? provenAmount,
    Expression<int>? owedAmount,
    Expression<DateTime>? provenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paydayId != null) 'payday_id': paydayId,
      if (position != null) 'position': position,
      if (bucketId != null) 'bucket_id': bucketId,
      if (toAccountId != null) 'to_account_id': toAccountId,
      if (amount != null) 'amount': amount,
      if (status != null) 'status': status,
      if (provenAmount != null) 'proven_amount': provenAmount,
      if (owedAmount != null) 'owed_amount': owedAmount,
      if (provenAt != null) 'proven_at': provenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransfersCompanion copyWith({
    Value<String>? id,
    Value<String>? paydayId,
    Value<int>? position,
    Value<String>? bucketId,
    Value<String>? toAccountId,
    Value<int>? amount,
    Value<TransferStatus>? status,
    Value<int?>? provenAmount,
    Value<int?>? owedAmount,
    Value<DateTime?>? provenAt,
    Value<int>? rowid,
  }) {
    return TransfersCompanion(
      id: id ?? this.id,
      paydayId: paydayId ?? this.paydayId,
      position: position ?? this.position,
      bucketId: bucketId ?? this.bucketId,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      provenAmount: provenAmount ?? this.provenAmount,
      owedAmount: owedAmount ?? this.owedAmount,
      provenAt: provenAt ?? this.provenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (paydayId.present) {
      map['payday_id'] = Variable<String>(paydayId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (toAccountId.present) {
      map['to_account_id'] = Variable<String>(toAccountId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $TransfersTable.$converterstatus.toSql(status.value),
      );
    }
    if (provenAmount.present) {
      map['proven_amount'] = Variable<int>(provenAmount.value);
    }
    if (owedAmount.present) {
      map['owed_amount'] = Variable<int>(owedAmount.value);
    }
    if (provenAt.present) {
      map['proven_at'] = Variable<DateTime>(provenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransfersCompanion(')
          ..write('id: $id, ')
          ..write('paydayId: $paydayId, ')
          ..write('position: $position, ')
          ..write('bucketId: $bucketId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('amount: $amount, ')
          ..write('status: $status, ')
          ..write('provenAmount: $provenAmount, ')
          ..write('owedAmount: $owedAmount, ')
          ..write('provenAt: $provenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransferProofRefsTable extends TransferProofRefs
    with TableInfo<$TransferProofRefsTable, TransferProofRefRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransferProofRefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _transferIdMeta = const VerificationMeta(
    'transferId',
  );
  @override
  late final GeneratedColumn<String> transferId = GeneratedColumn<String>(
    'transfer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transfers (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [transferId, position, reference];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfer_proof_refs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransferProofRefRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transfer_id')) {
      context.handle(
        _transferIdMeta,
        transferId.isAcceptableOrUnknown(data['transfer_id']!, _transferIdMeta),
      );
    } else if (isInserting) {
      context.missing(_transferIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {transferId, position};
  @override
  TransferProofRefRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransferProofRefRow(
      transferId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
    );
  }

  @override
  $TransferProofRefsTable createAlias(String alias) {
    return $TransferProofRefsTable(attachedDatabase, alias);
  }
}

class TransferProofRefRow extends DataClass
    implements Insertable<TransferProofRefRow> {
  final String transferId;
  final int position;
  final String reference;
  const TransferProofRefRow({
    required this.transferId,
    required this.position,
    required this.reference,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transfer_id'] = Variable<String>(transferId);
    map['position'] = Variable<int>(position);
    map['reference'] = Variable<String>(reference);
    return map;
  }

  TransferProofRefsCompanion toCompanion(bool nullToAbsent) {
    return TransferProofRefsCompanion(
      transferId: Value(transferId),
      position: Value(position),
      reference: Value(reference),
    );
  }

  factory TransferProofRefRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransferProofRefRow(
      transferId: serializer.fromJson<String>(json['transferId']),
      position: serializer.fromJson<int>(json['position']),
      reference: serializer.fromJson<String>(json['reference']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transferId': serializer.toJson<String>(transferId),
      'position': serializer.toJson<int>(position),
      'reference': serializer.toJson<String>(reference),
    };
  }

  TransferProofRefRow copyWith({
    String? transferId,
    int? position,
    String? reference,
  }) => TransferProofRefRow(
    transferId: transferId ?? this.transferId,
    position: position ?? this.position,
    reference: reference ?? this.reference,
  );
  TransferProofRefRow copyWithCompanion(TransferProofRefsCompanion data) {
    return TransferProofRefRow(
      transferId: data.transferId.present
          ? data.transferId.value
          : this.transferId,
      position: data.position.present ? data.position.value : this.position,
      reference: data.reference.present ? data.reference.value : this.reference,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransferProofRefRow(')
          ..write('transferId: $transferId, ')
          ..write('position: $position, ')
          ..write('reference: $reference')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(transferId, position, reference);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransferProofRefRow &&
          other.transferId == this.transferId &&
          other.position == this.position &&
          other.reference == this.reference);
}

class TransferProofRefsCompanion extends UpdateCompanion<TransferProofRefRow> {
  final Value<String> transferId;
  final Value<int> position;
  final Value<String> reference;
  final Value<int> rowid;
  const TransferProofRefsCompanion({
    this.transferId = const Value.absent(),
    this.position = const Value.absent(),
    this.reference = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransferProofRefsCompanion.insert({
    required String transferId,
    required int position,
    required String reference,
    this.rowid = const Value.absent(),
  }) : transferId = Value(transferId),
       position = Value(position),
       reference = Value(reference);
  static Insertable<TransferProofRefRow> custom({
    Expression<String>? transferId,
    Expression<int>? position,
    Expression<String>? reference,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (transferId != null) 'transfer_id': transferId,
      if (position != null) 'position': position,
      if (reference != null) 'reference': reference,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransferProofRefsCompanion copyWith({
    Value<String>? transferId,
    Value<int>? position,
    Value<String>? reference,
    Value<int>? rowid,
  }) {
    return TransferProofRefsCompanion(
      transferId: transferId ?? this.transferId,
      position: position ?? this.position,
      reference: reference ?? this.reference,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transferId.present) {
      map['transfer_id'] = Variable<String>(transferId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransferProofRefsCompanion(')
          ..write('transferId: $transferId, ')
          ..write('position: $position, ')
          ..write('reference: $reference, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HeldIncomesTable extends HeldIncomes
    with TableInfo<$HeldIncomesTable, HeldIncomeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HeldIncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incomeSourceIdMeta = const VerificationMeta(
    'incomeSourceId',
  );
  @override
  late final GeneratedColumn<String> incomeSourceId = GeneratedColumn<String>(
    'income_source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alertIdMeta = const VerificationMeta(
    'alertId',
  );
  @override
  late final GeneratedColumn<String> alertId = GeneratedColumn<String>(
    'alert_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    incomeSourceId,
    amount,
    receivedAt,
    alertId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'held_incomes';
  @override
  VerificationContext validateIntegrity(
    Insertable<HeldIncomeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('income_source_id')) {
      context.handle(
        _incomeSourceIdMeta,
        incomeSourceId.isAcceptableOrUnknown(
          data['income_source_id']!,
          _incomeSourceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_incomeSourceIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('alert_id')) {
      context.handle(
        _alertIdMeta,
        alertId.isAcceptableOrUnknown(data['alert_id']!, _alertIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HeldIncomeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HeldIncomeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      incomeSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}income_source_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      alertId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_id'],
      ),
    );
  }

  @override
  $HeldIncomesTable createAlias(String alias) {
    return $HeldIncomesTable(attachedDatabase, alias);
  }
}

class HeldIncomeRow extends DataClass implements Insertable<HeldIncomeRow> {
  final String id;
  final String incomeSourceId;
  final int amount;
  final DateTime receivedAt;
  final String? alertId;
  const HeldIncomeRow({
    required this.id,
    required this.incomeSourceId,
    required this.amount,
    required this.receivedAt,
    this.alertId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['income_source_id'] = Variable<String>(incomeSourceId);
    map['amount'] = Variable<int>(amount);
    map['received_at'] = Variable<DateTime>(receivedAt);
    if (!nullToAbsent || alertId != null) {
      map['alert_id'] = Variable<String>(alertId);
    }
    return map;
  }

  HeldIncomesCompanion toCompanion(bool nullToAbsent) {
    return HeldIncomesCompanion(
      id: Value(id),
      incomeSourceId: Value(incomeSourceId),
      amount: Value(amount),
      receivedAt: Value(receivedAt),
      alertId: alertId == null && nullToAbsent
          ? const Value.absent()
          : Value(alertId),
    );
  }

  factory HeldIncomeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HeldIncomeRow(
      id: serializer.fromJson<String>(json['id']),
      incomeSourceId: serializer.fromJson<String>(json['incomeSourceId']),
      amount: serializer.fromJson<int>(json['amount']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      alertId: serializer.fromJson<String?>(json['alertId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'incomeSourceId': serializer.toJson<String>(incomeSourceId),
      'amount': serializer.toJson<int>(amount),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'alertId': serializer.toJson<String?>(alertId),
    };
  }

  HeldIncomeRow copyWith({
    String? id,
    String? incomeSourceId,
    int? amount,
    DateTime? receivedAt,
    Value<String?> alertId = const Value.absent(),
  }) => HeldIncomeRow(
    id: id ?? this.id,
    incomeSourceId: incomeSourceId ?? this.incomeSourceId,
    amount: amount ?? this.amount,
    receivedAt: receivedAt ?? this.receivedAt,
    alertId: alertId.present ? alertId.value : this.alertId,
  );
  HeldIncomeRow copyWithCompanion(HeldIncomesCompanion data) {
    return HeldIncomeRow(
      id: data.id.present ? data.id.value : this.id,
      incomeSourceId: data.incomeSourceId.present
          ? data.incomeSourceId.value
          : this.incomeSourceId,
      amount: data.amount.present ? data.amount.value : this.amount,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      alertId: data.alertId.present ? data.alertId.value : this.alertId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HeldIncomeRow(')
          ..write('id: $id, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('amount: $amount, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('alertId: $alertId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, incomeSourceId, amount, receivedAt, alertId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HeldIncomeRow &&
          other.id == this.id &&
          other.incomeSourceId == this.incomeSourceId &&
          other.amount == this.amount &&
          other.receivedAt == this.receivedAt &&
          other.alertId == this.alertId);
}

class HeldIncomesCompanion extends UpdateCompanion<HeldIncomeRow> {
  final Value<String> id;
  final Value<String> incomeSourceId;
  final Value<int> amount;
  final Value<DateTime> receivedAt;
  final Value<String?> alertId;
  final Value<int> rowid;
  const HeldIncomesCompanion({
    this.id = const Value.absent(),
    this.incomeSourceId = const Value.absent(),
    this.amount = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.alertId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HeldIncomesCompanion.insert({
    required String id,
    required String incomeSourceId,
    required int amount,
    required DateTime receivedAt,
    this.alertId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       incomeSourceId = Value(incomeSourceId),
       amount = Value(amount),
       receivedAt = Value(receivedAt);
  static Insertable<HeldIncomeRow> custom({
    Expression<String>? id,
    Expression<String>? incomeSourceId,
    Expression<int>? amount,
    Expression<DateTime>? receivedAt,
    Expression<String>? alertId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (incomeSourceId != null) 'income_source_id': incomeSourceId,
      if (amount != null) 'amount': amount,
      if (receivedAt != null) 'received_at': receivedAt,
      if (alertId != null) 'alert_id': alertId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HeldIncomesCompanion copyWith({
    Value<String>? id,
    Value<String>? incomeSourceId,
    Value<int>? amount,
    Value<DateTime>? receivedAt,
    Value<String?>? alertId,
    Value<int>? rowid,
  }) {
    return HeldIncomesCompanion(
      id: id ?? this.id,
      incomeSourceId: incomeSourceId ?? this.incomeSourceId,
      amount: amount ?? this.amount,
      receivedAt: receivedAt ?? this.receivedAt,
      alertId: alertId ?? this.alertId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (incomeSourceId.present) {
      map['income_source_id'] = Variable<String>(incomeSourceId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (alertId.present) {
      map['alert_id'] = Variable<String>(alertId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HeldIncomesCompanion(')
          ..write('id: $id, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('amount: $amount, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('alertId: $alertId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, GoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _celebratedAtMeta = const VerificationMeta(
    'celebratedAt',
  );
  @override
  late final GeneratedColumn<DateTime> celebratedAt = GeneratedColumn<DateTime>(
    'celebrated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    bucketId,
    target,
    targetDate,
    celebratedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('celebrated_at')) {
      context.handle(
        _celebratedAtMeta,
        celebratedAt.isAcceptableOrUnknown(
          data['celebrated_at']!,
          _celebratedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bucketId};
  @override
  GoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalRow(
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      celebratedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}celebrated_at'],
      ),
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class GoalRow extends DataClass implements Insertable<GoalRow> {
  final String bucketId;
  final int target;
  final DateTime? targetDate;
  final DateTime? celebratedAt;
  const GoalRow({
    required this.bucketId,
    required this.target,
    this.targetDate,
    this.celebratedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['bucket_id'] = Variable<String>(bucketId);
    map['target'] = Variable<int>(target);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    if (!nullToAbsent || celebratedAt != null) {
      map['celebrated_at'] = Variable<DateTime>(celebratedAt);
    }
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      bucketId: Value(bucketId),
      target: Value(target),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      celebratedAt: celebratedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(celebratedAt),
    );
  }

  factory GoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalRow(
      bucketId: serializer.fromJson<String>(json['bucketId']),
      target: serializer.fromJson<int>(json['target']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      celebratedAt: serializer.fromJson<DateTime?>(json['celebratedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bucketId': serializer.toJson<String>(bucketId),
      'target': serializer.toJson<int>(target),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'celebratedAt': serializer.toJson<DateTime?>(celebratedAt),
    };
  }

  GoalRow copyWith({
    String? bucketId,
    int? target,
    Value<DateTime?> targetDate = const Value.absent(),
    Value<DateTime?> celebratedAt = const Value.absent(),
  }) => GoalRow(
    bucketId: bucketId ?? this.bucketId,
    target: target ?? this.target,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    celebratedAt: celebratedAt.present ? celebratedAt.value : this.celebratedAt,
  );
  GoalRow copyWithCompanion(GoalsCompanion data) {
    return GoalRow(
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      target: data.target.present ? data.target.value : this.target,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      celebratedAt: data.celebratedAt.present
          ? data.celebratedAt.value
          : this.celebratedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalRow(')
          ..write('bucketId: $bucketId, ')
          ..write('target: $target, ')
          ..write('targetDate: $targetDate, ')
          ..write('celebratedAt: $celebratedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bucketId, target, targetDate, celebratedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalRow &&
          other.bucketId == this.bucketId &&
          other.target == this.target &&
          other.targetDate == this.targetDate &&
          other.celebratedAt == this.celebratedAt);
}

class GoalsCompanion extends UpdateCompanion<GoalRow> {
  final Value<String> bucketId;
  final Value<int> target;
  final Value<DateTime?> targetDate;
  final Value<DateTime?> celebratedAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.bucketId = const Value.absent(),
    this.target = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.celebratedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String bucketId,
    required int target,
    this.targetDate = const Value.absent(),
    this.celebratedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : bucketId = Value(bucketId),
       target = Value(target);
  static Insertable<GoalRow> custom({
    Expression<String>? bucketId,
    Expression<int>? target,
    Expression<DateTime>? targetDate,
    Expression<DateTime>? celebratedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (bucketId != null) 'bucket_id': bucketId,
      if (target != null) 'target': target,
      if (targetDate != null) 'target_date': targetDate,
      if (celebratedAt != null) 'celebrated_at': celebratedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? bucketId,
    Value<int>? target,
    Value<DateTime?>? targetDate,
    Value<DateTime?>? celebratedAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      bucketId: bucketId ?? this.bucketId,
      target: target ?? this.target,
      targetDate: targetDate ?? this.targetDate,
      celebratedAt: celebratedAt ?? this.celebratedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (celebratedAt.present) {
      map['celebrated_at'] = Variable<DateTime>(celebratedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('bucketId: $bucketId, ')
          ..write('target: $target, ')
          ..write('targetDate: $targetDate, ')
          ..write('celebratedAt: $celebratedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CheckInsTable extends CheckIns
    with TableInfo<$CheckInsTable, CheckInRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countedAtMeta = const VerificationMeta(
    'countedAt',
  );
  @override
  late final GeneratedColumn<DateTime> countedAt = GeneratedColumn<DateTime>(
    'counted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedCashMeta = const VerificationMeta(
    'expectedCash',
  );
  @override
  late final GeneratedColumn<int> expectedCash = GeneratedColumn<int>(
    'expected_cash',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countedCashMeta = const VerificationMeta(
    'countedCash',
  );
  @override
  late final GeneratedColumn<int> countedCash = GeneratedColumn<int>(
    'counted_cash',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    countedAt,
    expectedCash,
    countedCash,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('counted_at')) {
      context.handle(
        _countedAtMeta,
        countedAt.isAcceptableOrUnknown(data['counted_at']!, _countedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_countedAtMeta);
    }
    if (data.containsKey('expected_cash')) {
      context.handle(
        _expectedCashMeta,
        expectedCash.isAcceptableOrUnknown(
          data['expected_cash']!,
          _expectedCashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedCashMeta);
    }
    if (data.containsKey('counted_cash')) {
      context.handle(
        _countedCashMeta,
        countedCash.isAcceptableOrUnknown(
          data['counted_cash']!,
          _countedCashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_countedCashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckInRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      countedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}counted_at'],
      )!,
      expectedCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_cash'],
      )!,
      countedCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}counted_cash'],
      )!,
    );
  }

  @override
  $CheckInsTable createAlias(String alias) {
    return $CheckInsTable(attachedDatabase, alias);
  }
}

class CheckInRow extends DataClass implements Insertable<CheckInRow> {
  final String id;
  final DateTime countedAt;
  final int expectedCash;
  final int countedCash;
  const CheckInRow({
    required this.id,
    required this.countedAt,
    required this.expectedCash,
    required this.countedCash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['counted_at'] = Variable<DateTime>(countedAt);
    map['expected_cash'] = Variable<int>(expectedCash);
    map['counted_cash'] = Variable<int>(countedCash);
    return map;
  }

  CheckInsCompanion toCompanion(bool nullToAbsent) {
    return CheckInsCompanion(
      id: Value(id),
      countedAt: Value(countedAt),
      expectedCash: Value(expectedCash),
      countedCash: Value(countedCash),
    );
  }

  factory CheckInRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckInRow(
      id: serializer.fromJson<String>(json['id']),
      countedAt: serializer.fromJson<DateTime>(json['countedAt']),
      expectedCash: serializer.fromJson<int>(json['expectedCash']),
      countedCash: serializer.fromJson<int>(json['countedCash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'countedAt': serializer.toJson<DateTime>(countedAt),
      'expectedCash': serializer.toJson<int>(expectedCash),
      'countedCash': serializer.toJson<int>(countedCash),
    };
  }

  CheckInRow copyWith({
    String? id,
    DateTime? countedAt,
    int? expectedCash,
    int? countedCash,
  }) => CheckInRow(
    id: id ?? this.id,
    countedAt: countedAt ?? this.countedAt,
    expectedCash: expectedCash ?? this.expectedCash,
    countedCash: countedCash ?? this.countedCash,
  );
  CheckInRow copyWithCompanion(CheckInsCompanion data) {
    return CheckInRow(
      id: data.id.present ? data.id.value : this.id,
      countedAt: data.countedAt.present ? data.countedAt.value : this.countedAt,
      expectedCash: data.expectedCash.present
          ? data.expectedCash.value
          : this.expectedCash,
      countedCash: data.countedCash.present
          ? data.countedCash.value
          : this.countedCash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckInRow(')
          ..write('id: $id, ')
          ..write('countedAt: $countedAt, ')
          ..write('expectedCash: $expectedCash, ')
          ..write('countedCash: $countedCash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, countedAt, expectedCash, countedCash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckInRow &&
          other.id == this.id &&
          other.countedAt == this.countedAt &&
          other.expectedCash == this.expectedCash &&
          other.countedCash == this.countedCash);
}

class CheckInsCompanion extends UpdateCompanion<CheckInRow> {
  final Value<String> id;
  final Value<DateTime> countedAt;
  final Value<int> expectedCash;
  final Value<int> countedCash;
  final Value<int> rowid;
  const CheckInsCompanion({
    this.id = const Value.absent(),
    this.countedAt = const Value.absent(),
    this.expectedCash = const Value.absent(),
    this.countedCash = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheckInsCompanion.insert({
    required String id,
    required DateTime countedAt,
    required int expectedCash,
    required int countedCash,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       countedAt = Value(countedAt),
       expectedCash = Value(expectedCash),
       countedCash = Value(countedCash);
  static Insertable<CheckInRow> custom({
    Expression<String>? id,
    Expression<DateTime>? countedAt,
    Expression<int>? expectedCash,
    Expression<int>? countedCash,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (countedAt != null) 'counted_at': countedAt,
      if (expectedCash != null) 'expected_cash': expectedCash,
      if (countedCash != null) 'counted_cash': countedCash,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheckInsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? countedAt,
    Value<int>? expectedCash,
    Value<int>? countedCash,
    Value<int>? rowid,
  }) {
    return CheckInsCompanion(
      id: id ?? this.id,
      countedAt: countedAt ?? this.countedAt,
      expectedCash: expectedCash ?? this.expectedCash,
      countedCash: countedCash ?? this.countedCash,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (countedAt.present) {
      map['counted_at'] = Variable<DateTime>(countedAt.value);
    }
    if (expectedCash.present) {
      map['expected_cash'] = Variable<int>(expectedCash.value);
    }
    if (countedCash.present) {
      map['counted_cash'] = Variable<int>(countedCash.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInsCompanion(')
          ..write('id: $id, ')
          ..write('countedAt: $countedAt, ')
          ..write('expectedCash: $expectedCash, ')
          ..write('countedCash: $countedCash, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentAlertsTable extends PaymentAlerts
    with TableInfo<$PaymentAlertsTable, PaymentAlertRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentAlertsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawTextMeta = const VerificationMeta(
    'rawText',
  );
  @override
  late final GeneratedColumn<String> rawText = GeneratedColumn<String>(
    'raw_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AlertSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AlertSource>($PaymentAlertsTable.$convertersource);
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AlertStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AlertStatus>($PaymentAlertsTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<MessageDirection?, String>
  direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<MessageDirection?>($PaymentAlertsTable.$converterdirectionn);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feeMeta = const VerificationMeta('fee');
  @override
  late final GeneratedColumn<int> fee = GeneratedColumn<int>(
    'fee',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _counterpartyMeta = const VerificationMeta(
    'counterparty',
  );
  @override
  late final GeneratedColumn<String> counterparty = GeneratedColumn<String>(
    'counterparty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _balanceAfterMeta = const VerificationMeta(
    'balanceAfter',
  );
  @override
  late final GeneratedColumn<int> balanceAfter = GeneratedColumn<int>(
    'balance_after',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isWithdrawalMeta = const VerificationMeta(
    'isWithdrawal',
  );
  @override
  late final GeneratedColumn<bool> isWithdrawal = GeneratedColumn<bool>(
    'is_withdrawal',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_withdrawal" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawText,
    source,
    receivedAt,
    status,
    direction,
    amount,
    fee,
    counterparty,
    reference,
    occurredAt,
    balanceAfter,
    confidence,
    isWithdrawal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_alerts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentAlertRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raw_text')) {
      context.handle(
        _rawTextMeta,
        rawText.isAcceptableOrUnknown(data['raw_text']!, _rawTextMeta),
      );
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('fee')) {
      context.handle(
        _feeMeta,
        fee.isAcceptableOrUnknown(data['fee']!, _feeMeta),
      );
    }
    if (data.containsKey('counterparty')) {
      context.handle(
        _counterpartyMeta,
        counterparty.isAcceptableOrUnknown(
          data['counterparty']!,
          _counterpartyMeta,
        ),
      );
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    }
    if (data.containsKey('balance_after')) {
      context.handle(
        _balanceAfterMeta,
        balanceAfter.isAcceptableOrUnknown(
          data['balance_after']!,
          _balanceAfterMeta,
        ),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('is_withdrawal')) {
      context.handle(
        _isWithdrawalMeta,
        isWithdrawal.isAcceptableOrUnknown(
          data['is_withdrawal']!,
          _isWithdrawalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isWithdrawalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentAlertRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentAlertRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      rawText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_text'],
      ),
      source: $PaymentAlertsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
      status: $PaymentAlertsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      direction: $PaymentAlertsTable.$converterdirectionn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}direction'],
        ),
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      ),
      fee: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fee'],
      ),
      counterparty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counterparty'],
      ),
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      ),
      balanceAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_after'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      isWithdrawal: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_withdrawal'],
      )!,
    );
  }

  @override
  $PaymentAlertsTable createAlias(String alias) {
    return $PaymentAlertsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AlertSource, String, String> $convertersource =
      const EnumNameConverter<AlertSource>(AlertSource.values);
  static JsonTypeConverter2<AlertStatus, String, String> $converterstatus =
      const EnumNameConverter<AlertStatus>(AlertStatus.values);
  static JsonTypeConverter2<MessageDirection, String, String>
  $converterdirection = const EnumNameConverter<MessageDirection>(
    MessageDirection.values,
  );
  static JsonTypeConverter2<MessageDirection?, String?, String?>
  $converterdirectionn = JsonTypeConverter2.asNullable($converterdirection);
}

class PaymentAlertRow extends DataClass implements Insertable<PaymentAlertRow> {
  final String id;
  final String? rawText;
  final AlertSource source;
  final DateTime receivedAt;
  final AlertStatus status;
  final MessageDirection? direction;
  final int? amount;
  final int? fee;
  final String? counterparty;
  final String? reference;
  final DateTime? occurredAt;
  final int? balanceAfter;
  final double confidence;
  final bool isWithdrawal;
  const PaymentAlertRow({
    required this.id,
    this.rawText,
    required this.source,
    required this.receivedAt,
    required this.status,
    this.direction,
    this.amount,
    this.fee,
    this.counterparty,
    this.reference,
    this.occurredAt,
    this.balanceAfter,
    required this.confidence,
    required this.isWithdrawal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || rawText != null) {
      map['raw_text'] = Variable<String>(rawText);
    }
    {
      map['source'] = Variable<String>(
        $PaymentAlertsTable.$convertersource.toSql(source),
      );
    }
    map['received_at'] = Variable<DateTime>(receivedAt);
    {
      map['status'] = Variable<String>(
        $PaymentAlertsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || direction != null) {
      map['direction'] = Variable<String>(
        $PaymentAlertsTable.$converterdirectionn.toSql(direction),
      );
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<int>(amount);
    }
    if (!nullToAbsent || fee != null) {
      map['fee'] = Variable<int>(fee);
    }
    if (!nullToAbsent || counterparty != null) {
      map['counterparty'] = Variable<String>(counterparty);
    }
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || occurredAt != null) {
      map['occurred_at'] = Variable<DateTime>(occurredAt);
    }
    if (!nullToAbsent || balanceAfter != null) {
      map['balance_after'] = Variable<int>(balanceAfter);
    }
    map['confidence'] = Variable<double>(confidence);
    map['is_withdrawal'] = Variable<bool>(isWithdrawal);
    return map;
  }

  PaymentAlertsCompanion toCompanion(bool nullToAbsent) {
    return PaymentAlertsCompanion(
      id: Value(id),
      rawText: rawText == null && nullToAbsent
          ? const Value.absent()
          : Value(rawText),
      source: Value(source),
      receivedAt: Value(receivedAt),
      status: Value(status),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      fee: fee == null && nullToAbsent ? const Value.absent() : Value(fee),
      counterparty: counterparty == null && nullToAbsent
          ? const Value.absent()
          : Value(counterparty),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      occurredAt: occurredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(occurredAt),
      balanceAfter: balanceAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceAfter),
      confidence: Value(confidence),
      isWithdrawal: Value(isWithdrawal),
    );
  }

  factory PaymentAlertRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentAlertRow(
      id: serializer.fromJson<String>(json['id']),
      rawText: serializer.fromJson<String?>(json['rawText']),
      source: $PaymentAlertsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      status: $PaymentAlertsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      direction: $PaymentAlertsTable.$converterdirectionn.fromJson(
        serializer.fromJson<String?>(json['direction']),
      ),
      amount: serializer.fromJson<int?>(json['amount']),
      fee: serializer.fromJson<int?>(json['fee']),
      counterparty: serializer.fromJson<String?>(json['counterparty']),
      reference: serializer.fromJson<String?>(json['reference']),
      occurredAt: serializer.fromJson<DateTime?>(json['occurredAt']),
      balanceAfter: serializer.fromJson<int?>(json['balanceAfter']),
      confidence: serializer.fromJson<double>(json['confidence']),
      isWithdrawal: serializer.fromJson<bool>(json['isWithdrawal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'rawText': serializer.toJson<String?>(rawText),
      'source': serializer.toJson<String>(
        $PaymentAlertsTable.$convertersource.toJson(source),
      ),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'status': serializer.toJson<String>(
        $PaymentAlertsTable.$converterstatus.toJson(status),
      ),
      'direction': serializer.toJson<String?>(
        $PaymentAlertsTable.$converterdirectionn.toJson(direction),
      ),
      'amount': serializer.toJson<int?>(amount),
      'fee': serializer.toJson<int?>(fee),
      'counterparty': serializer.toJson<String?>(counterparty),
      'reference': serializer.toJson<String?>(reference),
      'occurredAt': serializer.toJson<DateTime?>(occurredAt),
      'balanceAfter': serializer.toJson<int?>(balanceAfter),
      'confidence': serializer.toJson<double>(confidence),
      'isWithdrawal': serializer.toJson<bool>(isWithdrawal),
    };
  }

  PaymentAlertRow copyWith({
    String? id,
    Value<String?> rawText = const Value.absent(),
    AlertSource? source,
    DateTime? receivedAt,
    AlertStatus? status,
    Value<MessageDirection?> direction = const Value.absent(),
    Value<int?> amount = const Value.absent(),
    Value<int?> fee = const Value.absent(),
    Value<String?> counterparty = const Value.absent(),
    Value<String?> reference = const Value.absent(),
    Value<DateTime?> occurredAt = const Value.absent(),
    Value<int?> balanceAfter = const Value.absent(),
    double? confidence,
    bool? isWithdrawal,
  }) => PaymentAlertRow(
    id: id ?? this.id,
    rawText: rawText.present ? rawText.value : this.rawText,
    source: source ?? this.source,
    receivedAt: receivedAt ?? this.receivedAt,
    status: status ?? this.status,
    direction: direction.present ? direction.value : this.direction,
    amount: amount.present ? amount.value : this.amount,
    fee: fee.present ? fee.value : this.fee,
    counterparty: counterparty.present ? counterparty.value : this.counterparty,
    reference: reference.present ? reference.value : this.reference,
    occurredAt: occurredAt.present ? occurredAt.value : this.occurredAt,
    balanceAfter: balanceAfter.present ? balanceAfter.value : this.balanceAfter,
    confidence: confidence ?? this.confidence,
    isWithdrawal: isWithdrawal ?? this.isWithdrawal,
  );
  PaymentAlertRow copyWithCompanion(PaymentAlertsCompanion data) {
    return PaymentAlertRow(
      id: data.id.present ? data.id.value : this.id,
      rawText: data.rawText.present ? data.rawText.value : this.rawText,
      source: data.source.present ? data.source.value : this.source,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      status: data.status.present ? data.status.value : this.status,
      direction: data.direction.present ? data.direction.value : this.direction,
      amount: data.amount.present ? data.amount.value : this.amount,
      fee: data.fee.present ? data.fee.value : this.fee,
      counterparty: data.counterparty.present
          ? data.counterparty.value
          : this.counterparty,
      reference: data.reference.present ? data.reference.value : this.reference,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      balanceAfter: data.balanceAfter.present
          ? data.balanceAfter.value
          : this.balanceAfter,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      isWithdrawal: data.isWithdrawal.present
          ? data.isWithdrawal.value
          : this.isWithdrawal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAlertRow(')
          ..write('id: $id, ')
          ..write('rawText: $rawText, ')
          ..write('source: $source, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('status: $status, ')
          ..write('direction: $direction, ')
          ..write('amount: $amount, ')
          ..write('fee: $fee, ')
          ..write('counterparty: $counterparty, ')
          ..write('reference: $reference, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('confidence: $confidence, ')
          ..write('isWithdrawal: $isWithdrawal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawText,
    source,
    receivedAt,
    status,
    direction,
    amount,
    fee,
    counterparty,
    reference,
    occurredAt,
    balanceAfter,
    confidence,
    isWithdrawal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentAlertRow &&
          other.id == this.id &&
          other.rawText == this.rawText &&
          other.source == this.source &&
          other.receivedAt == this.receivedAt &&
          other.status == this.status &&
          other.direction == this.direction &&
          other.amount == this.amount &&
          other.fee == this.fee &&
          other.counterparty == this.counterparty &&
          other.reference == this.reference &&
          other.occurredAt == this.occurredAt &&
          other.balanceAfter == this.balanceAfter &&
          other.confidence == this.confidence &&
          other.isWithdrawal == this.isWithdrawal);
}

class PaymentAlertsCompanion extends UpdateCompanion<PaymentAlertRow> {
  final Value<String> id;
  final Value<String?> rawText;
  final Value<AlertSource> source;
  final Value<DateTime> receivedAt;
  final Value<AlertStatus> status;
  final Value<MessageDirection?> direction;
  final Value<int?> amount;
  final Value<int?> fee;
  final Value<String?> counterparty;
  final Value<String?> reference;
  final Value<DateTime?> occurredAt;
  final Value<int?> balanceAfter;
  final Value<double> confidence;
  final Value<bool> isWithdrawal;
  final Value<int> rowid;
  const PaymentAlertsCompanion({
    this.id = const Value.absent(),
    this.rawText = const Value.absent(),
    this.source = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.direction = const Value.absent(),
    this.amount = const Value.absent(),
    this.fee = const Value.absent(),
    this.counterparty = const Value.absent(),
    this.reference = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.balanceAfter = const Value.absent(),
    this.confidence = const Value.absent(),
    this.isWithdrawal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentAlertsCompanion.insert({
    required String id,
    this.rawText = const Value.absent(),
    required AlertSource source,
    required DateTime receivedAt,
    required AlertStatus status,
    this.direction = const Value.absent(),
    this.amount = const Value.absent(),
    this.fee = const Value.absent(),
    this.counterparty = const Value.absent(),
    this.reference = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.balanceAfter = const Value.absent(),
    required double confidence,
    required bool isWithdrawal,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       source = Value(source),
       receivedAt = Value(receivedAt),
       status = Value(status),
       confidence = Value(confidence),
       isWithdrawal = Value(isWithdrawal);
  static Insertable<PaymentAlertRow> custom({
    Expression<String>? id,
    Expression<String>? rawText,
    Expression<String>? source,
    Expression<DateTime>? receivedAt,
    Expression<String>? status,
    Expression<String>? direction,
    Expression<int>? amount,
    Expression<int>? fee,
    Expression<String>? counterparty,
    Expression<String>? reference,
    Expression<DateTime>? occurredAt,
    Expression<int>? balanceAfter,
    Expression<double>? confidence,
    Expression<bool>? isWithdrawal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawText != null) 'raw_text': rawText,
      if (source != null) 'source': source,
      if (receivedAt != null) 'received_at': receivedAt,
      if (status != null) 'status': status,
      if (direction != null) 'direction': direction,
      if (amount != null) 'amount': amount,
      if (fee != null) 'fee': fee,
      if (counterparty != null) 'counterparty': counterparty,
      if (reference != null) 'reference': reference,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (balanceAfter != null) 'balance_after': balanceAfter,
      if (confidence != null) 'confidence': confidence,
      if (isWithdrawal != null) 'is_withdrawal': isWithdrawal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentAlertsCompanion copyWith({
    Value<String>? id,
    Value<String?>? rawText,
    Value<AlertSource>? source,
    Value<DateTime>? receivedAt,
    Value<AlertStatus>? status,
    Value<MessageDirection?>? direction,
    Value<int?>? amount,
    Value<int?>? fee,
    Value<String?>? counterparty,
    Value<String?>? reference,
    Value<DateTime?>? occurredAt,
    Value<int?>? balanceAfter,
    Value<double>? confidence,
    Value<bool>? isWithdrawal,
    Value<int>? rowid,
  }) {
    return PaymentAlertsCompanion(
      id: id ?? this.id,
      rawText: rawText ?? this.rawText,
      source: source ?? this.source,
      receivedAt: receivedAt ?? this.receivedAt,
      status: status ?? this.status,
      direction: direction ?? this.direction,
      amount: amount ?? this.amount,
      fee: fee ?? this.fee,
      counterparty: counterparty ?? this.counterparty,
      reference: reference ?? this.reference,
      occurredAt: occurredAt ?? this.occurredAt,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      confidence: confidence ?? this.confidence,
      isWithdrawal: isWithdrawal ?? this.isWithdrawal,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rawText.present) {
      map['raw_text'] = Variable<String>(rawText.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $PaymentAlertsTable.$convertersource.toSql(source.value),
      );
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PaymentAlertsTable.$converterstatus.toSql(status.value),
      );
    }
    if (direction.present) {
      map['direction'] = Variable<String>(
        $PaymentAlertsTable.$converterdirectionn.toSql(direction.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (fee.present) {
      map['fee'] = Variable<int>(fee.value);
    }
    if (counterparty.present) {
      map['counterparty'] = Variable<String>(counterparty.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (balanceAfter.present) {
      map['balance_after'] = Variable<int>(balanceAfter.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (isWithdrawal.present) {
      map['is_withdrawal'] = Variable<bool>(isWithdrawal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAlertsCompanion(')
          ..write('id: $id, ')
          ..write('rawText: $rawText, ')
          ..write('source: $source, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('status: $status, ')
          ..write('direction: $direction, ')
          ..write('amount: $amount, ')
          ..write('fee: $fee, ')
          ..write('counterparty: $counterparty, ')
          ..write('reference: $reference, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('confidence: $confidence, ')
          ..write('isWithdrawal: $isWithdrawal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionSource, String>
  source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<TransactionSource>($TransactionsTable.$convertersource);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alertIdMeta = const VerificationMeta(
    'alertId',
  );
  @override
  late final GeneratedColumn<String> alertId = GeneratedColumn<String>(
    'alert_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptIdMeta = const VerificationMeta(
    'receiptId',
  );
  @override
  late final GeneratedColumn<String> receiptId = GeneratedColumn<String>(
    'receipt_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FeeType?, String> feeType =
      GeneratedColumn<String>(
        'fee_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<FeeType?>($TransactionsTable.$converterfeeTypen);
  @override
  late final GeneratedColumnWithTypeConverter<AlertSource?, String> provider =
      GeneratedColumn<String>(
        'provider',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<AlertSource?>($TransactionsTable.$converterprovidern);
  @override
  late final GeneratedColumnWithTypeConverter<FeeSource?, String> feeSource =
      GeneratedColumn<String>(
        'fee_source',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<FeeSource?>($TransactionsTable.$converterfeeSourcen);
  static const VerificationMeta _parentTransactionIdMeta =
      const VerificationMeta('parentTransactionId');
  @override
  late final GeneratedColumn<String> parentTransactionId =
      GeneratedColumn<String>(
        'parent_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    bucketId,
    category,
    accountId,
    occurredAt,
    source,
    note,
    alertId,
    receiptId,
    billId,
    feeType,
    provider,
    feeSource,
    parentTransactionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('alert_id')) {
      context.handle(
        _alertIdMeta,
        alertId.isAcceptableOrUnknown(data['alert_id']!, _alertIdMeta),
      );
    }
    if (data.containsKey('receipt_id')) {
      context.handle(
        _receiptIdMeta,
        receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta),
      );
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    }
    if (data.containsKey('parent_transaction_id')) {
      context.handle(
        _parentTransactionIdMeta,
        parentTransactionId.isAcceptableOrUnknown(
          data['parent_transaction_id']!,
          _parentTransactionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      source: $TransactionsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      alertId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_id'],
      ),
      receiptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_id'],
      ),
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      ),
      feeType: $TransactionsTable.$converterfeeTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fee_type'],
        ),
      ),
      provider: $TransactionsTable.$converterprovidern.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}provider'],
        ),
      ),
      feeSource: $TransactionsTable.$converterfeeSourcen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fee_source'],
        ),
      ),
      parentTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_transaction_id'],
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionSource, String, String>
  $convertersource = const EnumNameConverter<TransactionSource>(
    TransactionSource.values,
  );
  static JsonTypeConverter2<FeeType, String, String> $converterfeeType =
      const EnumNameConverter<FeeType>(FeeType.values);
  static JsonTypeConverter2<FeeType?, String?, String?> $converterfeeTypen =
      JsonTypeConverter2.asNullable($converterfeeType);
  static JsonTypeConverter2<AlertSource, String, String> $converterprovider =
      const EnumNameConverter<AlertSource>(AlertSource.values);
  static JsonTypeConverter2<AlertSource?, String?, String?>
  $converterprovidern = JsonTypeConverter2.asNullable($converterprovider);
  static JsonTypeConverter2<FeeSource, String, String> $converterfeeSource =
      const EnumNameConverter<FeeSource>(FeeSource.values);
  static JsonTypeConverter2<FeeSource?, String?, String?> $converterfeeSourcen =
      JsonTypeConverter2.asNullable($converterfeeSource);
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final String id;
  final int amount;
  final String bucketId;
  final String category;
  final String accountId;
  final DateTime occurredAt;
  final TransactionSource source;
  final String? note;
  final String? alertId;
  final String? receiptId;
  final String? billId;
  final FeeType? feeType;
  final AlertSource? provider;
  final FeeSource? feeSource;
  final String? parentTransactionId;
  const TransactionRow({
    required this.id,
    required this.amount,
    required this.bucketId,
    required this.category,
    required this.accountId,
    required this.occurredAt,
    required this.source,
    this.note,
    this.alertId,
    this.receiptId,
    this.billId,
    this.feeType,
    this.provider,
    this.feeSource,
    this.parentTransactionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<int>(amount);
    map['bucket_id'] = Variable<String>(bucketId);
    map['category'] = Variable<String>(category);
    map['account_id'] = Variable<String>(accountId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    {
      map['source'] = Variable<String>(
        $TransactionsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || alertId != null) {
      map['alert_id'] = Variable<String>(alertId);
    }
    if (!nullToAbsent || receiptId != null) {
      map['receipt_id'] = Variable<String>(receiptId);
    }
    if (!nullToAbsent || billId != null) {
      map['bill_id'] = Variable<String>(billId);
    }
    if (!nullToAbsent || feeType != null) {
      map['fee_type'] = Variable<String>(
        $TransactionsTable.$converterfeeTypen.toSql(feeType),
      );
    }
    if (!nullToAbsent || provider != null) {
      map['provider'] = Variable<String>(
        $TransactionsTable.$converterprovidern.toSql(provider),
      );
    }
    if (!nullToAbsent || feeSource != null) {
      map['fee_source'] = Variable<String>(
        $TransactionsTable.$converterfeeSourcen.toSql(feeSource),
      );
    }
    if (!nullToAbsent || parentTransactionId != null) {
      map['parent_transaction_id'] = Variable<String>(parentTransactionId);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      amount: Value(amount),
      bucketId: Value(bucketId),
      category: Value(category),
      accountId: Value(accountId),
      occurredAt: Value(occurredAt),
      source: Value(source),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      alertId: alertId == null && nullToAbsent
          ? const Value.absent()
          : Value(alertId),
      receiptId: receiptId == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptId),
      billId: billId == null && nullToAbsent
          ? const Value.absent()
          : Value(billId),
      feeType: feeType == null && nullToAbsent
          ? const Value.absent()
          : Value(feeType),
      provider: provider == null && nullToAbsent
          ? const Value.absent()
          : Value(provider),
      feeSource: feeSource == null && nullToAbsent
          ? const Value.absent()
          : Value(feeSource),
      parentTransactionId: parentTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTransactionId),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      bucketId: serializer.fromJson<String>(json['bucketId']),
      category: serializer.fromJson<String>(json['category']),
      accountId: serializer.fromJson<String>(json['accountId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      source: $TransactionsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      note: serializer.fromJson<String?>(json['note']),
      alertId: serializer.fromJson<String?>(json['alertId']),
      receiptId: serializer.fromJson<String?>(json['receiptId']),
      billId: serializer.fromJson<String?>(json['billId']),
      feeType: $TransactionsTable.$converterfeeTypen.fromJson(
        serializer.fromJson<String?>(json['feeType']),
      ),
      provider: $TransactionsTable.$converterprovidern.fromJson(
        serializer.fromJson<String?>(json['provider']),
      ),
      feeSource: $TransactionsTable.$converterfeeSourcen.fromJson(
        serializer.fromJson<String?>(json['feeSource']),
      ),
      parentTransactionId: serializer.fromJson<String?>(
        json['parentTransactionId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<int>(amount),
      'bucketId': serializer.toJson<String>(bucketId),
      'category': serializer.toJson<String>(category),
      'accountId': serializer.toJson<String>(accountId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'source': serializer.toJson<String>(
        $TransactionsTable.$convertersource.toJson(source),
      ),
      'note': serializer.toJson<String?>(note),
      'alertId': serializer.toJson<String?>(alertId),
      'receiptId': serializer.toJson<String?>(receiptId),
      'billId': serializer.toJson<String?>(billId),
      'feeType': serializer.toJson<String?>(
        $TransactionsTable.$converterfeeTypen.toJson(feeType),
      ),
      'provider': serializer.toJson<String?>(
        $TransactionsTable.$converterprovidern.toJson(provider),
      ),
      'feeSource': serializer.toJson<String?>(
        $TransactionsTable.$converterfeeSourcen.toJson(feeSource),
      ),
      'parentTransactionId': serializer.toJson<String?>(parentTransactionId),
    };
  }

  TransactionRow copyWith({
    String? id,
    int? amount,
    String? bucketId,
    String? category,
    String? accountId,
    DateTime? occurredAt,
    TransactionSource? source,
    Value<String?> note = const Value.absent(),
    Value<String?> alertId = const Value.absent(),
    Value<String?> receiptId = const Value.absent(),
    Value<String?> billId = const Value.absent(),
    Value<FeeType?> feeType = const Value.absent(),
    Value<AlertSource?> provider = const Value.absent(),
    Value<FeeSource?> feeSource = const Value.absent(),
    Value<String?> parentTransactionId = const Value.absent(),
  }) => TransactionRow(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    bucketId: bucketId ?? this.bucketId,
    category: category ?? this.category,
    accountId: accountId ?? this.accountId,
    occurredAt: occurredAt ?? this.occurredAt,
    source: source ?? this.source,
    note: note.present ? note.value : this.note,
    alertId: alertId.present ? alertId.value : this.alertId,
    receiptId: receiptId.present ? receiptId.value : this.receiptId,
    billId: billId.present ? billId.value : this.billId,
    feeType: feeType.present ? feeType.value : this.feeType,
    provider: provider.present ? provider.value : this.provider,
    feeSource: feeSource.present ? feeSource.value : this.feeSource,
    parentTransactionId: parentTransactionId.present
        ? parentTransactionId.value
        : this.parentTransactionId,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      category: data.category.present ? data.category.value : this.category,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      source: data.source.present ? data.source.value : this.source,
      note: data.note.present ? data.note.value : this.note,
      alertId: data.alertId.present ? data.alertId.value : this.alertId,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      billId: data.billId.present ? data.billId.value : this.billId,
      feeType: data.feeType.present ? data.feeType.value : this.feeType,
      provider: data.provider.present ? data.provider.value : this.provider,
      feeSource: data.feeSource.present ? data.feeSource.value : this.feeSource,
      parentTransactionId: data.parentTransactionId.present
          ? data.parentTransactionId.value
          : this.parentTransactionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('bucketId: $bucketId, ')
          ..write('category: $category, ')
          ..write('accountId: $accountId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('source: $source, ')
          ..write('note: $note, ')
          ..write('alertId: $alertId, ')
          ..write('receiptId: $receiptId, ')
          ..write('billId: $billId, ')
          ..write('feeType: $feeType, ')
          ..write('provider: $provider, ')
          ..write('feeSource: $feeSource, ')
          ..write('parentTransactionId: $parentTransactionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    bucketId,
    category,
    accountId,
    occurredAt,
    source,
    note,
    alertId,
    receiptId,
    billId,
    feeType,
    provider,
    feeSource,
    parentTransactionId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.bucketId == this.bucketId &&
          other.category == this.category &&
          other.accountId == this.accountId &&
          other.occurredAt == this.occurredAt &&
          other.source == this.source &&
          other.note == this.note &&
          other.alertId == this.alertId &&
          other.receiptId == this.receiptId &&
          other.billId == this.billId &&
          other.feeType == this.feeType &&
          other.provider == this.provider &&
          other.feeSource == this.feeSource &&
          other.parentTransactionId == this.parentTransactionId);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<String> id;
  final Value<int> amount;
  final Value<String> bucketId;
  final Value<String> category;
  final Value<String> accountId;
  final Value<DateTime> occurredAt;
  final Value<TransactionSource> source;
  final Value<String?> note;
  final Value<String?> alertId;
  final Value<String?> receiptId;
  final Value<String?> billId;
  final Value<FeeType?> feeType;
  final Value<AlertSource?> provider;
  final Value<FeeSource?> feeSource;
  final Value<String?> parentTransactionId;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.category = const Value.absent(),
    this.accountId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.source = const Value.absent(),
    this.note = const Value.absent(),
    this.alertId = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.billId = const Value.absent(),
    this.feeType = const Value.absent(),
    this.provider = const Value.absent(),
    this.feeSource = const Value.absent(),
    this.parentTransactionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required int amount,
    required String bucketId,
    required String category,
    required String accountId,
    required DateTime occurredAt,
    required TransactionSource source,
    this.note = const Value.absent(),
    this.alertId = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.billId = const Value.absent(),
    this.feeType = const Value.absent(),
    this.provider = const Value.absent(),
    this.feeSource = const Value.absent(),
    this.parentTransactionId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       bucketId = Value(bucketId),
       category = Value(category),
       accountId = Value(accountId),
       occurredAt = Value(occurredAt),
       source = Value(source);
  static Insertable<TransactionRow> custom({
    Expression<String>? id,
    Expression<int>? amount,
    Expression<String>? bucketId,
    Expression<String>? category,
    Expression<String>? accountId,
    Expression<DateTime>? occurredAt,
    Expression<String>? source,
    Expression<String>? note,
    Expression<String>? alertId,
    Expression<String>? receiptId,
    Expression<String>? billId,
    Expression<String>? feeType,
    Expression<String>? provider,
    Expression<String>? feeSource,
    Expression<String>? parentTransactionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (bucketId != null) 'bucket_id': bucketId,
      if (category != null) 'category': category,
      if (accountId != null) 'account_id': accountId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (source != null) 'source': source,
      if (note != null) 'note': note,
      if (alertId != null) 'alert_id': alertId,
      if (receiptId != null) 'receipt_id': receiptId,
      if (billId != null) 'bill_id': billId,
      if (feeType != null) 'fee_type': feeType,
      if (provider != null) 'provider': provider,
      if (feeSource != null) 'fee_source': feeSource,
      if (parentTransactionId != null)
        'parent_transaction_id': parentTransactionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<int>? amount,
    Value<String>? bucketId,
    Value<String>? category,
    Value<String>? accountId,
    Value<DateTime>? occurredAt,
    Value<TransactionSource>? source,
    Value<String?>? note,
    Value<String?>? alertId,
    Value<String?>? receiptId,
    Value<String?>? billId,
    Value<FeeType?>? feeType,
    Value<AlertSource?>? provider,
    Value<FeeSource?>? feeSource,
    Value<String?>? parentTransactionId,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      bucketId: bucketId ?? this.bucketId,
      category: category ?? this.category,
      accountId: accountId ?? this.accountId,
      occurredAt: occurredAt ?? this.occurredAt,
      source: source ?? this.source,
      note: note ?? this.note,
      alertId: alertId ?? this.alertId,
      receiptId: receiptId ?? this.receiptId,
      billId: billId ?? this.billId,
      feeType: feeType ?? this.feeType,
      provider: provider ?? this.provider,
      feeSource: feeSource ?? this.feeSource,
      parentTransactionId: parentTransactionId ?? this.parentTransactionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $TransactionsTable.$convertersource.toSql(source.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (alertId.present) {
      map['alert_id'] = Variable<String>(alertId.value);
    }
    if (receiptId.present) {
      map['receipt_id'] = Variable<String>(receiptId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (feeType.present) {
      map['fee_type'] = Variable<String>(
        $TransactionsTable.$converterfeeTypen.toSql(feeType.value),
      );
    }
    if (provider.present) {
      map['provider'] = Variable<String>(
        $TransactionsTable.$converterprovidern.toSql(provider.value),
      );
    }
    if (feeSource.present) {
      map['fee_source'] = Variable<String>(
        $TransactionsTable.$converterfeeSourcen.toSql(feeSource.value),
      );
    }
    if (parentTransactionId.present) {
      map['parent_transaction_id'] = Variable<String>(
        parentTransactionId.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('bucketId: $bucketId, ')
          ..write('category: $category, ')
          ..write('accountId: $accountId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('source: $source, ')
          ..write('note: $note, ')
          ..write('alertId: $alertId, ')
          ..write('receiptId: $receiptId, ')
          ..write('billId: $billId, ')
          ..write('feeType: $feeType, ')
          ..write('provider: $provider, ')
          ..write('feeSource: $feeSource, ')
          ..write('parentTransactionId: $parentTransactionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionLinesTable extends TransactionLines
    with TableInfo<$TransactionLinesTable, TransactionLineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    transactionId,
    position,
    bucketId,
    amount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionLineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {transactionId, position};
  @override
  TransactionLineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionLineRow(
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $TransactionLinesTable createAlias(String alias) {
    return $TransactionLinesTable(attachedDatabase, alias);
  }
}

class TransactionLineRow extends DataClass
    implements Insertable<TransactionLineRow> {
  final String transactionId;
  final int position;
  final String bucketId;
  final int amount;
  const TransactionLineRow({
    required this.transactionId,
    required this.position,
    required this.bucketId,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transaction_id'] = Variable<String>(transactionId);
    map['position'] = Variable<int>(position);
    map['bucket_id'] = Variable<String>(bucketId);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  TransactionLinesCompanion toCompanion(bool nullToAbsent) {
    return TransactionLinesCompanion(
      transactionId: Value(transactionId),
      position: Value(position),
      bucketId: Value(bucketId),
      amount: Value(amount),
    );
  }

  factory TransactionLineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionLineRow(
      transactionId: serializer.fromJson<String>(json['transactionId']),
      position: serializer.fromJson<int>(json['position']),
      bucketId: serializer.fromJson<String>(json['bucketId']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transactionId': serializer.toJson<String>(transactionId),
      'position': serializer.toJson<int>(position),
      'bucketId': serializer.toJson<String>(bucketId),
      'amount': serializer.toJson<int>(amount),
    };
  }

  TransactionLineRow copyWith({
    String? transactionId,
    int? position,
    String? bucketId,
    int? amount,
  }) => TransactionLineRow(
    transactionId: transactionId ?? this.transactionId,
    position: position ?? this.position,
    bucketId: bucketId ?? this.bucketId,
    amount: amount ?? this.amount,
  );
  TransactionLineRow copyWithCompanion(TransactionLinesCompanion data) {
    return TransactionLineRow(
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      position: data.position.present ? data.position.value : this.position,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionLineRow(')
          ..write('transactionId: $transactionId, ')
          ..write('position: $position, ')
          ..write('bucketId: $bucketId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(transactionId, position, bucketId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionLineRow &&
          other.transactionId == this.transactionId &&
          other.position == this.position &&
          other.bucketId == this.bucketId &&
          other.amount == this.amount);
}

class TransactionLinesCompanion extends UpdateCompanion<TransactionLineRow> {
  final Value<String> transactionId;
  final Value<int> position;
  final Value<String> bucketId;
  final Value<int> amount;
  final Value<int> rowid;
  const TransactionLinesCompanion({
    this.transactionId = const Value.absent(),
    this.position = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionLinesCompanion.insert({
    required String transactionId,
    required int position,
    required String bucketId,
    required int amount,
    this.rowid = const Value.absent(),
  }) : transactionId = Value(transactionId),
       position = Value(position),
       bucketId = Value(bucketId),
       amount = Value(amount);
  static Insertable<TransactionLineRow> custom({
    Expression<String>? transactionId,
    Expression<int>? position,
    Expression<String>? bucketId,
    Expression<int>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (transactionId != null) 'transaction_id': transactionId,
      if (position != null) 'position': position,
      if (bucketId != null) 'bucket_id': bucketId,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionLinesCompanion copyWith({
    Value<String>? transactionId,
    Value<int>? position,
    Value<String>? bucketId,
    Value<int>? amount,
    Value<int>? rowid,
  }) {
    return TransactionLinesCompanion(
      transactionId: transactionId ?? this.transactionId,
      position: position ?? this.position,
      bucketId: bucketId ?? this.bucketId,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionLinesCompanion(')
          ..write('transactionId: $transactionId, ')
          ..write('position: $position, ')
          ..write('bucketId: $bucketId, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashWithdrawalsTable extends CashWithdrawals
    with TableInfo<$CashWithdrawalsTable, CashWithdrawalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashWithdrawalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromAccountIdMeta = const VerificationMeta(
    'fromAccountId',
  );
  @override
  late final GeneratedColumn<String> fromAccountId = GeneratedColumn<String>(
    'from_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashAccountIdMeta = const VerificationMeta(
    'cashAccountId',
  );
  @override
  late final GeneratedColumn<String> cashAccountId = GeneratedColumn<String>(
    'cash_account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alertIdMeta = const VerificationMeta(
    'alertId',
  );
  @override
  late final GeneratedColumn<String> alertId = GeneratedColumn<String>(
    'alert_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    fromAccountId,
    cashAccountId,
    occurredAt,
    alertId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_withdrawals';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashWithdrawalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('from_account_id')) {
      context.handle(
        _fromAccountIdMeta,
        fromAccountId.isAcceptableOrUnknown(
          data['from_account_id']!,
          _fromAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromAccountIdMeta);
    }
    if (data.containsKey('cash_account_id')) {
      context.handle(
        _cashAccountIdMeta,
        cashAccountId.isAcceptableOrUnknown(
          data['cash_account_id']!,
          _cashAccountIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cashAccountIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('alert_id')) {
      context.handle(
        _alertIdMeta,
        alertId.isAcceptableOrUnknown(data['alert_id']!, _alertIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashWithdrawalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashWithdrawalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      fromAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_account_id'],
      )!,
      cashAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cash_account_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      alertId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_id'],
      ),
    );
  }

  @override
  $CashWithdrawalsTable createAlias(String alias) {
    return $CashWithdrawalsTable(attachedDatabase, alias);
  }
}

class CashWithdrawalRow extends DataClass
    implements Insertable<CashWithdrawalRow> {
  final String id;
  final int amount;
  final String fromAccountId;
  final String cashAccountId;
  final DateTime occurredAt;
  final String? alertId;
  const CashWithdrawalRow({
    required this.id,
    required this.amount,
    required this.fromAccountId,
    required this.cashAccountId,
    required this.occurredAt,
    this.alertId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<int>(amount);
    map['from_account_id'] = Variable<String>(fromAccountId);
    map['cash_account_id'] = Variable<String>(cashAccountId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || alertId != null) {
      map['alert_id'] = Variable<String>(alertId);
    }
    return map;
  }

  CashWithdrawalsCompanion toCompanion(bool nullToAbsent) {
    return CashWithdrawalsCompanion(
      id: Value(id),
      amount: Value(amount),
      fromAccountId: Value(fromAccountId),
      cashAccountId: Value(cashAccountId),
      occurredAt: Value(occurredAt),
      alertId: alertId == null && nullToAbsent
          ? const Value.absent()
          : Value(alertId),
    );
  }

  factory CashWithdrawalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashWithdrawalRow(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      fromAccountId: serializer.fromJson<String>(json['fromAccountId']),
      cashAccountId: serializer.fromJson<String>(json['cashAccountId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      alertId: serializer.fromJson<String?>(json['alertId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<int>(amount),
      'fromAccountId': serializer.toJson<String>(fromAccountId),
      'cashAccountId': serializer.toJson<String>(cashAccountId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'alertId': serializer.toJson<String?>(alertId),
    };
  }

  CashWithdrawalRow copyWith({
    String? id,
    int? amount,
    String? fromAccountId,
    String? cashAccountId,
    DateTime? occurredAt,
    Value<String?> alertId = const Value.absent(),
  }) => CashWithdrawalRow(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    fromAccountId: fromAccountId ?? this.fromAccountId,
    cashAccountId: cashAccountId ?? this.cashAccountId,
    occurredAt: occurredAt ?? this.occurredAt,
    alertId: alertId.present ? alertId.value : this.alertId,
  );
  CashWithdrawalRow copyWithCompanion(CashWithdrawalsCompanion data) {
    return CashWithdrawalRow(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      fromAccountId: data.fromAccountId.present
          ? data.fromAccountId.value
          : this.fromAccountId,
      cashAccountId: data.cashAccountId.present
          ? data.cashAccountId.value
          : this.cashAccountId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      alertId: data.alertId.present ? data.alertId.value : this.alertId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashWithdrawalRow(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('cashAccountId: $cashAccountId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('alertId: $alertId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    fromAccountId,
    cashAccountId,
    occurredAt,
    alertId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashWithdrawalRow &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.fromAccountId == this.fromAccountId &&
          other.cashAccountId == this.cashAccountId &&
          other.occurredAt == this.occurredAt &&
          other.alertId == this.alertId);
}

class CashWithdrawalsCompanion extends UpdateCompanion<CashWithdrawalRow> {
  final Value<String> id;
  final Value<int> amount;
  final Value<String> fromAccountId;
  final Value<String> cashAccountId;
  final Value<DateTime> occurredAt;
  final Value<String?> alertId;
  final Value<int> rowid;
  const CashWithdrawalsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.fromAccountId = const Value.absent(),
    this.cashAccountId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.alertId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashWithdrawalsCompanion.insert({
    required String id,
    required int amount,
    required String fromAccountId,
    required String cashAccountId,
    required DateTime occurredAt,
    this.alertId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       fromAccountId = Value(fromAccountId),
       cashAccountId = Value(cashAccountId),
       occurredAt = Value(occurredAt);
  static Insertable<CashWithdrawalRow> custom({
    Expression<String>? id,
    Expression<int>? amount,
    Expression<String>? fromAccountId,
    Expression<String>? cashAccountId,
    Expression<DateTime>? occurredAt,
    Expression<String>? alertId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (fromAccountId != null) 'from_account_id': fromAccountId,
      if (cashAccountId != null) 'cash_account_id': cashAccountId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (alertId != null) 'alert_id': alertId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashWithdrawalsCompanion copyWith({
    Value<String>? id,
    Value<int>? amount,
    Value<String>? fromAccountId,
    Value<String>? cashAccountId,
    Value<DateTime>? occurredAt,
    Value<String?>? alertId,
    Value<int>? rowid,
  }) {
    return CashWithdrawalsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      cashAccountId: cashAccountId ?? this.cashAccountId,
      occurredAt: occurredAt ?? this.occurredAt,
      alertId: alertId ?? this.alertId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (fromAccountId.present) {
      map['from_account_id'] = Variable<String>(fromAccountId.value);
    }
    if (cashAccountId.present) {
      map['cash_account_id'] = Variable<String>(cashAccountId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (alertId.present) {
      map['alert_id'] = Variable<String>(alertId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashWithdrawalsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('cashAccountId: $cashAccountId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('alertId: $alertId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MerchantRulesTable extends MerchantRules
    with TableInfo<$MerchantRulesTable, MerchantRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantKeyMeta = const VerificationMeta(
    'merchantKey',
  );
  @override
  late final GeneratedColumn<String> merchantKey = GeneratedColumn<String>(
    'merchant_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, merchantKey, category, bucketId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchant_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<MerchantRuleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('merchant_key')) {
      context.handle(
        _merchantKeyMeta,
        merchantKey.isAcceptableOrUnknown(
          data['merchant_key']!,
          _merchantKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantKeyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MerchantRuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MerchantRuleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      merchantKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_key'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
    );
  }

  @override
  $MerchantRulesTable createAlias(String alias) {
    return $MerchantRulesTable(attachedDatabase, alias);
  }
}

class MerchantRuleRow extends DataClass implements Insertable<MerchantRuleRow> {
  final String id;
  final String merchantKey;
  final String category;
  final String bucketId;
  const MerchantRuleRow({
    required this.id,
    required this.merchantKey,
    required this.category,
    required this.bucketId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['merchant_key'] = Variable<String>(merchantKey);
    map['category'] = Variable<String>(category);
    map['bucket_id'] = Variable<String>(bucketId);
    return map;
  }

  MerchantRulesCompanion toCompanion(bool nullToAbsent) {
    return MerchantRulesCompanion(
      id: Value(id),
      merchantKey: Value(merchantKey),
      category: Value(category),
      bucketId: Value(bucketId),
    );
  }

  factory MerchantRuleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MerchantRuleRow(
      id: serializer.fromJson<String>(json['id']),
      merchantKey: serializer.fromJson<String>(json['merchantKey']),
      category: serializer.fromJson<String>(json['category']),
      bucketId: serializer.fromJson<String>(json['bucketId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'merchantKey': serializer.toJson<String>(merchantKey),
      'category': serializer.toJson<String>(category),
      'bucketId': serializer.toJson<String>(bucketId),
    };
  }

  MerchantRuleRow copyWith({
    String? id,
    String? merchantKey,
    String? category,
    String? bucketId,
  }) => MerchantRuleRow(
    id: id ?? this.id,
    merchantKey: merchantKey ?? this.merchantKey,
    category: category ?? this.category,
    bucketId: bucketId ?? this.bucketId,
  );
  MerchantRuleRow copyWithCompanion(MerchantRulesCompanion data) {
    return MerchantRuleRow(
      id: data.id.present ? data.id.value : this.id,
      merchantKey: data.merchantKey.present
          ? data.merchantKey.value
          : this.merchantKey,
      category: data.category.present ? data.category.value : this.category,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MerchantRuleRow(')
          ..write('id: $id, ')
          ..write('merchantKey: $merchantKey, ')
          ..write('category: $category, ')
          ..write('bucketId: $bucketId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, merchantKey, category, bucketId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MerchantRuleRow &&
          other.id == this.id &&
          other.merchantKey == this.merchantKey &&
          other.category == this.category &&
          other.bucketId == this.bucketId);
}

class MerchantRulesCompanion extends UpdateCompanion<MerchantRuleRow> {
  final Value<String> id;
  final Value<String> merchantKey;
  final Value<String> category;
  final Value<String> bucketId;
  final Value<int> rowid;
  const MerchantRulesCompanion({
    this.id = const Value.absent(),
    this.merchantKey = const Value.absent(),
    this.category = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MerchantRulesCompanion.insert({
    required String id,
    required String merchantKey,
    required String category,
    required String bucketId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       merchantKey = Value(merchantKey),
       category = Value(category),
       bucketId = Value(bucketId);
  static Insertable<MerchantRuleRow> custom({
    Expression<String>? id,
    Expression<String>? merchantKey,
    Expression<String>? category,
    Expression<String>? bucketId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (merchantKey != null) 'merchant_key': merchantKey,
      if (category != null) 'category': category,
      if (bucketId != null) 'bucket_id': bucketId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MerchantRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? merchantKey,
    Value<String>? category,
    Value<String>? bucketId,
    Value<int>? rowid,
  }) {
    return MerchantRulesCompanion(
      id: id ?? this.id,
      merchantKey: merchantKey ?? this.merchantKey,
      category: category ?? this.category,
      bucketId: bucketId ?? this.bucketId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (merchantKey.present) {
      map['merchant_key'] = Variable<String>(merchantKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MerchantRulesCompanion(')
          ..write('id: $id, ')
          ..write('merchantKey: $merchantKey, ')
          ..write('category: $category, ')
          ..write('bucketId: $bucketId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts
    with TableInfo<$ReceiptsTable, ReceiptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _draftJsonMeta = const VerificationMeta(
    'draftJson',
  );
  @override
  late final GeneratedColumn<String> draftJson = GeneratedColumn<String>(
    'draft_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, imagePath, draftJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReceiptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('draft_json')) {
      context.handle(
        _draftJsonMeta,
        draftJson.isAcceptableOrUnknown(data['draft_json']!, _draftJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_draftJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      draftJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}draft_json'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class ReceiptRow extends DataClass implements Insertable<ReceiptRow> {
  final String id;
  final String imagePath;
  final String draftJson;
  const ReceiptRow({
    required this.id,
    required this.imagePath,
    required this.draftJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image_path'] = Variable<String>(imagePath);
    map['draft_json'] = Variable<String>(draftJson);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      draftJson: Value(draftJson),
    );
  }

  factory ReceiptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptRow(
      id: serializer.fromJson<String>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      draftJson: serializer.fromJson<String>(json['draftJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'draftJson': serializer.toJson<String>(draftJson),
    };
  }

  ReceiptRow copyWith({String? id, String? imagePath, String? draftJson}) =>
      ReceiptRow(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        draftJson: draftJson ?? this.draftJson,
      );
  ReceiptRow copyWithCompanion(ReceiptsCompanion data) {
    return ReceiptRow(
      id: data.id.present ? data.id.value : this.id,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      draftJson: data.draftJson.present ? data.draftJson.value : this.draftJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptRow(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('draftJson: $draftJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, draftJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptRow &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.draftJson == this.draftJson);
}

class ReceiptsCompanion extends UpdateCompanion<ReceiptRow> {
  final Value<String> id;
  final Value<String> imagePath;
  final Value<String> draftJson;
  final Value<int> rowid;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.draftJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    required String id,
    required String imagePath,
    required String draftJson,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       imagePath = Value(imagePath),
       draftJson = Value(draftJson);
  static Insertable<ReceiptRow> custom({
    Expression<String>? id,
    Expression<String>? imagePath,
    Expression<String>? draftJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (draftJson != null) 'draft_json': draftJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptsCompanion copyWith({
    Value<String>? id,
    Value<String>? imagePath,
    Value<String>? draftJson,
    Value<int>? rowid,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      draftJson: draftJson ?? this.draftJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (draftJson.present) {
      map['draft_json'] = Variable<String>(draftJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('draftJson: $draftJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlannedPurchasesTable extends PlannedPurchases
    with TableInfo<$PlannedPurchasesTable, PlannedPurchaseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlannedPurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueMeta = const VerificationMeta('due');
  @override
  late final GeneratedColumn<DateTime> due = GeneratedColumn<DateTime>(
    'due',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repeatEverySecondsMeta =
      const VerificationMeta('repeatEverySeconds');
  @override
  late final GeneratedColumn<int> repeatEverySeconds = GeneratedColumn<int>(
    'repeat_every_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
    'done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("done" IN (0, 1))',
    ),
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    amount,
    bucketId,
    due,
    repeatEverySeconds,
    done,
    transactionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planned_purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlannedPurchaseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('due')) {
      context.handle(
        _dueMeta,
        due.isAcceptableOrUnknown(data['due']!, _dueMeta),
      );
    }
    if (data.containsKey('repeat_every_seconds')) {
      context.handle(
        _repeatEverySecondsMeta,
        repeatEverySeconds.isAcceptableOrUnknown(
          data['repeat_every_seconds']!,
          _repeatEverySecondsMeta,
        ),
      );
    }
    if (data.containsKey('done')) {
      context.handle(
        _doneMeta,
        done.isAcceptableOrUnknown(data['done']!, _doneMeta),
      );
    } else if (isInserting) {
      context.missing(_doneMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlannedPurchaseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlannedPurchaseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      due: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due'],
      ),
      repeatEverySeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_every_seconds'],
      ),
      done: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}done'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
    );
  }

  @override
  $PlannedPurchasesTable createAlias(String alias) {
    return $PlannedPurchasesTable(attachedDatabase, alias);
  }
}

class PlannedPurchaseRow extends DataClass
    implements Insertable<PlannedPurchaseRow> {
  final String id;
  final String name;
  final int amount;
  final String bucketId;
  final DateTime? due;
  final int? repeatEverySeconds;
  final bool done;
  final String? transactionId;
  const PlannedPurchaseRow({
    required this.id,
    required this.name,
    required this.amount,
    required this.bucketId,
    this.due,
    this.repeatEverySeconds,
    required this.done,
    this.transactionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['bucket_id'] = Variable<String>(bucketId);
    if (!nullToAbsent || due != null) {
      map['due'] = Variable<DateTime>(due);
    }
    if (!nullToAbsent || repeatEverySeconds != null) {
      map['repeat_every_seconds'] = Variable<int>(repeatEverySeconds);
    }
    map['done'] = Variable<bool>(done);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    return map;
  }

  PlannedPurchasesCompanion toCompanion(bool nullToAbsent) {
    return PlannedPurchasesCompanion(
      id: Value(id),
      name: Value(name),
      amount: Value(amount),
      bucketId: Value(bucketId),
      due: due == null && nullToAbsent ? const Value.absent() : Value(due),
      repeatEverySeconds: repeatEverySeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatEverySeconds),
      done: Value(done),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
    );
  }

  factory PlannedPurchaseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlannedPurchaseRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      bucketId: serializer.fromJson<String>(json['bucketId']),
      due: serializer.fromJson<DateTime?>(json['due']),
      repeatEverySeconds: serializer.fromJson<int?>(json['repeatEverySeconds']),
      done: serializer.fromJson<bool>(json['done']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
      'bucketId': serializer.toJson<String>(bucketId),
      'due': serializer.toJson<DateTime?>(due),
      'repeatEverySeconds': serializer.toJson<int?>(repeatEverySeconds),
      'done': serializer.toJson<bool>(done),
      'transactionId': serializer.toJson<String?>(transactionId),
    };
  }

  PlannedPurchaseRow copyWith({
    String? id,
    String? name,
    int? amount,
    String? bucketId,
    Value<DateTime?> due = const Value.absent(),
    Value<int?> repeatEverySeconds = const Value.absent(),
    bool? done,
    Value<String?> transactionId = const Value.absent(),
  }) => PlannedPurchaseRow(
    id: id ?? this.id,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    bucketId: bucketId ?? this.bucketId,
    due: due.present ? due.value : this.due,
    repeatEverySeconds: repeatEverySeconds.present
        ? repeatEverySeconds.value
        : this.repeatEverySeconds,
    done: done ?? this.done,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
  );
  PlannedPurchaseRow copyWithCompanion(PlannedPurchasesCompanion data) {
    return PlannedPurchaseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      due: data.due.present ? data.due.value : this.due,
      repeatEverySeconds: data.repeatEverySeconds.present
          ? data.repeatEverySeconds.value
          : this.repeatEverySeconds,
      done: data.done.present ? data.done.value : this.done,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlannedPurchaseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('bucketId: $bucketId, ')
          ..write('due: $due, ')
          ..write('repeatEverySeconds: $repeatEverySeconds, ')
          ..write('done: $done, ')
          ..write('transactionId: $transactionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    amount,
    bucketId,
    due,
    repeatEverySeconds,
    done,
    transactionId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlannedPurchaseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.bucketId == this.bucketId &&
          other.due == this.due &&
          other.repeatEverySeconds == this.repeatEverySeconds &&
          other.done == this.done &&
          other.transactionId == this.transactionId);
}

class PlannedPurchasesCompanion extends UpdateCompanion<PlannedPurchaseRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> amount;
  final Value<String> bucketId;
  final Value<DateTime?> due;
  final Value<int?> repeatEverySeconds;
  final Value<bool> done;
  final Value<String?> transactionId;
  final Value<int> rowid;
  const PlannedPurchasesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.due = const Value.absent(),
    this.repeatEverySeconds = const Value.absent(),
    this.done = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlannedPurchasesCompanion.insert({
    required String id,
    required String name,
    required int amount,
    required String bucketId,
    this.due = const Value.absent(),
    this.repeatEverySeconds = const Value.absent(),
    required bool done,
    this.transactionId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       amount = Value(amount),
       bucketId = Value(bucketId),
       done = Value(done);
  static Insertable<PlannedPurchaseRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<String>? bucketId,
    Expression<DateTime>? due,
    Expression<int>? repeatEverySeconds,
    Expression<bool>? done,
    Expression<String>? transactionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (bucketId != null) 'bucket_id': bucketId,
      if (due != null) 'due': due,
      if (repeatEverySeconds != null)
        'repeat_every_seconds': repeatEverySeconds,
      if (done != null) 'done': done,
      if (transactionId != null) 'transaction_id': transactionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlannedPurchasesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? amount,
    Value<String>? bucketId,
    Value<DateTime?>? due,
    Value<int?>? repeatEverySeconds,
    Value<bool>? done,
    Value<String?>? transactionId,
    Value<int>? rowid,
  }) {
    return PlannedPurchasesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      bucketId: bucketId ?? this.bucketId,
      due: due ?? this.due,
      repeatEverySeconds: repeatEverySeconds ?? this.repeatEverySeconds,
      done: done ?? this.done,
      transactionId: transactionId ?? this.transactionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (due.present) {
      map['due'] = Variable<DateTime>(due.value);
    }
    if (repeatEverySeconds.present) {
      map['repeat_every_seconds'] = Variable<int>(repeatEverySeconds.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlannedPurchasesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('bucketId: $bucketId, ')
          ..write('due: $due, ')
          ..write('repeatEverySeconds: $repeatEverySeconds, ')
          ..write('done: $done, ')
          ..write('transactionId: $transactionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WishesTable extends Wishes with TableInfo<$WishesTable, WishRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bucketIdMeta = const VerificationMeta(
    'bucketId',
  );
  @override
  late final GeneratedColumn<String> bucketId = GeneratedColumn<String>(
    'bucket_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
    'ends_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WishStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WishStatus>($WishesTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    amount,
    bucketId,
    createdAt,
    endsAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishes';
  @override
  VerificationContext validateIntegrity(
    Insertable<WishRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('bucket_id')) {
      context.handle(
        _bucketIdMeta,
        bucketId.isAcceptableOrUnknown(data['bucket_id']!, _bucketIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bucketIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('ends_at')) {
      context.handle(
        _endsAtMeta,
        endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endsAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      bucketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bucket_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      endsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ends_at'],
      )!,
      status: $WishesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $WishesTable createAlias(String alias) {
    return $WishesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WishStatus, String, String> $converterstatus =
      const EnumNameConverter<WishStatus>(WishStatus.values);
}

class WishRow extends DataClass implements Insertable<WishRow> {
  final String id;
  final String name;
  final int amount;
  final String bucketId;
  final DateTime createdAt;
  final DateTime endsAt;
  final WishStatus status;
  const WishRow({
    required this.id,
    required this.name,
    required this.amount,
    required this.bucketId,
    required this.createdAt,
    required this.endsAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['bucket_id'] = Variable<String>(bucketId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['ends_at'] = Variable<DateTime>(endsAt);
    {
      map['status'] = Variable<String>(
        $WishesTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  WishesCompanion toCompanion(bool nullToAbsent) {
    return WishesCompanion(
      id: Value(id),
      name: Value(name),
      amount: Value(amount),
      bucketId: Value(bucketId),
      createdAt: Value(createdAt),
      endsAt: Value(endsAt),
      status: Value(status),
    );
  }

  factory WishRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      bucketId: serializer.fromJson<String>(json['bucketId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      endsAt: serializer.fromJson<DateTime>(json['endsAt']),
      status: $WishesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
      'bucketId': serializer.toJson<String>(bucketId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'endsAt': serializer.toJson<DateTime>(endsAt),
      'status': serializer.toJson<String>(
        $WishesTable.$converterstatus.toJson(status),
      ),
    };
  }

  WishRow copyWith({
    String? id,
    String? name,
    int? amount,
    String? bucketId,
    DateTime? createdAt,
    DateTime? endsAt,
    WishStatus? status,
  }) => WishRow(
    id: id ?? this.id,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    bucketId: bucketId ?? this.bucketId,
    createdAt: createdAt ?? this.createdAt,
    endsAt: endsAt ?? this.endsAt,
    status: status ?? this.status,
  );
  WishRow copyWithCompanion(WishesCompanion data) {
    return WishRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      bucketId: data.bucketId.present ? data.bucketId.value : this.bucketId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('bucketId: $bucketId, ')
          ..write('createdAt: $createdAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, amount, bucketId, createdAt, endsAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.bucketId == this.bucketId &&
          other.createdAt == this.createdAt &&
          other.endsAt == this.endsAt &&
          other.status == this.status);
}

class WishesCompanion extends UpdateCompanion<WishRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> amount;
  final Value<String> bucketId;
  final Value<DateTime> createdAt;
  final Value<DateTime> endsAt;
  final Value<WishStatus> status;
  final Value<int> rowid;
  const WishesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.bucketId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishesCompanion.insert({
    required String id,
    required String name,
    required int amount,
    required String bucketId,
    required DateTime createdAt,
    required DateTime endsAt,
    required WishStatus status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       amount = Value(amount),
       bucketId = Value(bucketId),
       createdAt = Value(createdAt),
       endsAt = Value(endsAt),
       status = Value(status);
  static Insertable<WishRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<String>? bucketId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? endsAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (bucketId != null) 'bucket_id': bucketId,
      if (createdAt != null) 'created_at': createdAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? amount,
    Value<String>? bucketId,
    Value<DateTime>? createdAt,
    Value<DateTime>? endsAt,
    Value<WishStatus>? status,
    Value<int>? rowid,
  }) {
    return WishesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      bucketId: bucketId ?? this.bucketId,
      createdAt: createdAt ?? this.createdAt,
      endsAt: endsAt ?? this.endsAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (bucketId.present) {
      map['bucket_id'] = Variable<String>(bucketId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $WishesTable.$converterstatus.toSql(status.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('bucketId: $bucketId, ')
          ..write('createdAt: $createdAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillOccurrencesTable extends BillOccurrences
    with TableInfo<$BillOccurrencesTable, BillOccurrenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillOccurrencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cycleStartMeta = const VerificationMeta(
    'cycleStart',
  );
  @override
  late final GeneratedColumn<String> cycleStart = GeneratedColumn<String>(
    'cycle_start',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedAmountMeta = const VerificationMeta(
    'expectedAmount',
  );
  @override
  late final GeneratedColumn<int> expectedAmount = GeneratedColumn<int>(
    'expected_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BillStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BillStatus>($BillOccurrencesTable.$converterstatus);
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<int> paidAmount = GeneratedColumn<int>(
    'paid_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feeTransactionIdMeta = const VerificationMeta(
    'feeTransactionId',
  );
  @override
  late final GeneratedColumn<String> feeTransactionId = GeneratedColumn<String>(
    'fee_transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proofRefMeta = const VerificationMeta(
    'proofRef',
  );
  @override
  late final GeneratedColumn<String> proofRef = GeneratedColumn<String>(
    'proof_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billId,
    cycleStart,
    dueDate,
    expectedAmount,
    status,
    paidAmount,
    paidAt,
    accountId,
    feeTransactionId,
    proofRef,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_occurrences';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillOccurrenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('cycle_start')) {
      context.handle(
        _cycleStartMeta,
        cycleStart.isAcceptableOrUnknown(data['cycle_start']!, _cycleStartMeta),
      );
    } else if (isInserting) {
      context.missing(_cycleStartMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('expected_amount')) {
      context.handle(
        _expectedAmountMeta,
        expectedAmount.isAcceptableOrUnknown(
          data['expected_amount']!,
          _expectedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedAmountMeta);
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('fee_transaction_id')) {
      context.handle(
        _feeTransactionIdMeta,
        feeTransactionId.isAcceptableOrUnknown(
          data['fee_transaction_id']!,
          _feeTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('proof_ref')) {
      context.handle(
        _proofRefMeta,
        proofRef.isAcceptableOrUnknown(data['proof_ref']!, _proofRefMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {billId, cycleStart},
  ];
  @override
  BillOccurrenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillOccurrenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      )!,
      cycleStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cycle_start'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      )!,
      expectedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_amount'],
      )!,
      status: $BillOccurrencesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_amount'],
      ),
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      feeTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fee_transaction_id'],
      ),
      proofRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proof_ref'],
      ),
    );
  }

  @override
  $BillOccurrencesTable createAlias(String alias) {
    return $BillOccurrencesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BillStatus, String, String> $converterstatus =
      const EnumNameConverter<BillStatus>(BillStatus.values);
}

class BillOccurrenceRow extends DataClass
    implements Insertable<BillOccurrenceRow> {
  final String id;
  final String billId;
  final String cycleStart;
  final String dueDate;
  final int expectedAmount;
  final BillStatus status;
  final int? paidAmount;
  final DateTime? paidAt;
  final String? accountId;
  final String? feeTransactionId;
  final String? proofRef;
  const BillOccurrenceRow({
    required this.id,
    required this.billId,
    required this.cycleStart,
    required this.dueDate,
    required this.expectedAmount,
    required this.status,
    this.paidAmount,
    this.paidAt,
    this.accountId,
    this.feeTransactionId,
    this.proofRef,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bill_id'] = Variable<String>(billId);
    map['cycle_start'] = Variable<String>(cycleStart);
    map['due_date'] = Variable<String>(dueDate);
    map['expected_amount'] = Variable<int>(expectedAmount);
    {
      map['status'] = Variable<String>(
        $BillOccurrencesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || paidAmount != null) {
      map['paid_amount'] = Variable<int>(paidAmount);
    }
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || feeTransactionId != null) {
      map['fee_transaction_id'] = Variable<String>(feeTransactionId);
    }
    if (!nullToAbsent || proofRef != null) {
      map['proof_ref'] = Variable<String>(proofRef);
    }
    return map;
  }

  BillOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return BillOccurrencesCompanion(
      id: Value(id),
      billId: Value(billId),
      cycleStart: Value(cycleStart),
      dueDate: Value(dueDate),
      expectedAmount: Value(expectedAmount),
      status: Value(status),
      paidAmount: paidAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAmount),
      paidAt: paidAt == null && nullToAbsent
          ? const Value.absent()
          : Value(paidAt),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      feeTransactionId: feeTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(feeTransactionId),
      proofRef: proofRef == null && nullToAbsent
          ? const Value.absent()
          : Value(proofRef),
    );
  }

  factory BillOccurrenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillOccurrenceRow(
      id: serializer.fromJson<String>(json['id']),
      billId: serializer.fromJson<String>(json['billId']),
      cycleStart: serializer.fromJson<String>(json['cycleStart']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      expectedAmount: serializer.fromJson<int>(json['expectedAmount']),
      status: $BillOccurrencesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      paidAmount: serializer.fromJson<int?>(json['paidAmount']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      feeTransactionId: serializer.fromJson<String?>(json['feeTransactionId']),
      proofRef: serializer.fromJson<String?>(json['proofRef']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'billId': serializer.toJson<String>(billId),
      'cycleStart': serializer.toJson<String>(cycleStart),
      'dueDate': serializer.toJson<String>(dueDate),
      'expectedAmount': serializer.toJson<int>(expectedAmount),
      'status': serializer.toJson<String>(
        $BillOccurrencesTable.$converterstatus.toJson(status),
      ),
      'paidAmount': serializer.toJson<int?>(paidAmount),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
      'accountId': serializer.toJson<String?>(accountId),
      'feeTransactionId': serializer.toJson<String?>(feeTransactionId),
      'proofRef': serializer.toJson<String?>(proofRef),
    };
  }

  BillOccurrenceRow copyWith({
    String? id,
    String? billId,
    String? cycleStart,
    String? dueDate,
    int? expectedAmount,
    BillStatus? status,
    Value<int?> paidAmount = const Value.absent(),
    Value<DateTime?> paidAt = const Value.absent(),
    Value<String?> accountId = const Value.absent(),
    Value<String?> feeTransactionId = const Value.absent(),
    Value<String?> proofRef = const Value.absent(),
  }) => BillOccurrenceRow(
    id: id ?? this.id,
    billId: billId ?? this.billId,
    cycleStart: cycleStart ?? this.cycleStart,
    dueDate: dueDate ?? this.dueDate,
    expectedAmount: expectedAmount ?? this.expectedAmount,
    status: status ?? this.status,
    paidAmount: paidAmount.present ? paidAmount.value : this.paidAmount,
    paidAt: paidAt.present ? paidAt.value : this.paidAt,
    accountId: accountId.present ? accountId.value : this.accountId,
    feeTransactionId: feeTransactionId.present
        ? feeTransactionId.value
        : this.feeTransactionId,
    proofRef: proofRef.present ? proofRef.value : this.proofRef,
  );
  BillOccurrenceRow copyWithCompanion(BillOccurrencesCompanion data) {
    return BillOccurrenceRow(
      id: data.id.present ? data.id.value : this.id,
      billId: data.billId.present ? data.billId.value : this.billId,
      cycleStart: data.cycleStart.present
          ? data.cycleStart.value
          : this.cycleStart,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      expectedAmount: data.expectedAmount.present
          ? data.expectedAmount.value
          : this.expectedAmount,
      status: data.status.present ? data.status.value : this.status,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      feeTransactionId: data.feeTransactionId.present
          ? data.feeTransactionId.value
          : this.feeTransactionId,
      proofRef: data.proofRef.present ? data.proofRef.value : this.proofRef,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillOccurrenceRow(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('cycleStart: $cycleStart, ')
          ..write('dueDate: $dueDate, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('status: $status, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paidAt: $paidAt, ')
          ..write('accountId: $accountId, ')
          ..write('feeTransactionId: $feeTransactionId, ')
          ..write('proofRef: $proofRef')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    billId,
    cycleStart,
    dueDate,
    expectedAmount,
    status,
    paidAmount,
    paidAt,
    accountId,
    feeTransactionId,
    proofRef,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillOccurrenceRow &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.cycleStart == this.cycleStart &&
          other.dueDate == this.dueDate &&
          other.expectedAmount == this.expectedAmount &&
          other.status == this.status &&
          other.paidAmount == this.paidAmount &&
          other.paidAt == this.paidAt &&
          other.accountId == this.accountId &&
          other.feeTransactionId == this.feeTransactionId &&
          other.proofRef == this.proofRef);
}

class BillOccurrencesCompanion extends UpdateCompanion<BillOccurrenceRow> {
  final Value<String> id;
  final Value<String> billId;
  final Value<String> cycleStart;
  final Value<String> dueDate;
  final Value<int> expectedAmount;
  final Value<BillStatus> status;
  final Value<int?> paidAmount;
  final Value<DateTime?> paidAt;
  final Value<String?> accountId;
  final Value<String?> feeTransactionId;
  final Value<String?> proofRef;
  final Value<int> rowid;
  const BillOccurrencesCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.cycleStart = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.expectedAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.accountId = const Value.absent(),
    this.feeTransactionId = const Value.absent(),
    this.proofRef = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillOccurrencesCompanion.insert({
    required String id,
    required String billId,
    required String cycleStart,
    required String dueDate,
    required int expectedAmount,
    required BillStatus status,
    this.paidAmount = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.accountId = const Value.absent(),
    this.feeTransactionId = const Value.absent(),
    this.proofRef = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       billId = Value(billId),
       cycleStart = Value(cycleStart),
       dueDate = Value(dueDate),
       expectedAmount = Value(expectedAmount),
       status = Value(status);
  static Insertable<BillOccurrenceRow> custom({
    Expression<String>? id,
    Expression<String>? billId,
    Expression<String>? cycleStart,
    Expression<String>? dueDate,
    Expression<int>? expectedAmount,
    Expression<String>? status,
    Expression<int>? paidAmount,
    Expression<DateTime>? paidAt,
    Expression<String>? accountId,
    Expression<String>? feeTransactionId,
    Expression<String>? proofRef,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (cycleStart != null) 'cycle_start': cycleStart,
      if (dueDate != null) 'due_date': dueDate,
      if (expectedAmount != null) 'expected_amount': expectedAmount,
      if (status != null) 'status': status,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (paidAt != null) 'paid_at': paidAt,
      if (accountId != null) 'account_id': accountId,
      if (feeTransactionId != null) 'fee_transaction_id': feeTransactionId,
      if (proofRef != null) 'proof_ref': proofRef,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillOccurrencesCompanion copyWith({
    Value<String>? id,
    Value<String>? billId,
    Value<String>? cycleStart,
    Value<String>? dueDate,
    Value<int>? expectedAmount,
    Value<BillStatus>? status,
    Value<int?>? paidAmount,
    Value<DateTime?>? paidAt,
    Value<String?>? accountId,
    Value<String?>? feeTransactionId,
    Value<String?>? proofRef,
    Value<int>? rowid,
  }) {
    return BillOccurrencesCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      cycleStart: cycleStart ?? this.cycleStart,
      dueDate: dueDate ?? this.dueDate,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      status: status ?? this.status,
      paidAmount: paidAmount ?? this.paidAmount,
      paidAt: paidAt ?? this.paidAt,
      accountId: accountId ?? this.accountId,
      feeTransactionId: feeTransactionId ?? this.feeTransactionId,
      proofRef: proofRef ?? this.proofRef,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (cycleStart.present) {
      map['cycle_start'] = Variable<String>(cycleStart.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (expectedAmount.present) {
      map['expected_amount'] = Variable<int>(expectedAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $BillOccurrencesTable.$converterstatus.toSql(status.value),
      );
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<int>(paidAmount.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (feeTransactionId.present) {
      map['fee_transaction_id'] = Variable<String>(feeTransactionId.value);
    }
    if (proofRef.present) {
      map['proof_ref'] = Variable<String>(proofRef.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('cycleStart: $cycleStart, ')
          ..write('dueDate: $dueDate, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('status: $status, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('paidAt: $paidAt, ')
          ..write('accountId: $accountId, ')
          ..write('feeTransactionId: $feeTransactionId, ')
          ..write('proofRef: $proofRef, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeeTariffsTable extends FeeTariffs
    with TableInfo<$FeeTariffsTable, FeeTariffRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeTariffsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AlertSource, String> provider =
      GeneratedColumn<String>(
        'provider',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AlertSource>($FeeTariffsTable.$converterprovider);
  @override
  late final GeneratedColumnWithTypeConverter<FeeType, String> feeType =
      GeneratedColumn<String>(
        'fee_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeeType>($FeeTariffsTable.$converterfeeType);
  @override
  List<GeneratedColumn> get $columns => [provider, feeType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_tariffs';
  @override
  Set<GeneratedColumn> get $primaryKey => {provider, feeType};
  @override
  FeeTariffRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeTariffRow(
      provider: $FeeTariffsTable.$converterprovider.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}provider'],
        )!,
      ),
      feeType: $FeeTariffsTable.$converterfeeType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fee_type'],
        )!,
      ),
    );
  }

  @override
  $FeeTariffsTable createAlias(String alias) {
    return $FeeTariffsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AlertSource, String, String> $converterprovider =
      const EnumNameConverter<AlertSource>(AlertSource.values);
  static JsonTypeConverter2<FeeType, String, String> $converterfeeType =
      const EnumNameConverter<FeeType>(FeeType.values);
}

class FeeTariffRow extends DataClass implements Insertable<FeeTariffRow> {
  final AlertSource provider;
  final FeeType feeType;
  const FeeTariffRow({required this.provider, required this.feeType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['provider'] = Variable<String>(
        $FeeTariffsTable.$converterprovider.toSql(provider),
      );
    }
    {
      map['fee_type'] = Variable<String>(
        $FeeTariffsTable.$converterfeeType.toSql(feeType),
      );
    }
    return map;
  }

  FeeTariffsCompanion toCompanion(bool nullToAbsent) {
    return FeeTariffsCompanion(
      provider: Value(provider),
      feeType: Value(feeType),
    );
  }

  factory FeeTariffRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeTariffRow(
      provider: $FeeTariffsTable.$converterprovider.fromJson(
        serializer.fromJson<String>(json['provider']),
      ),
      feeType: $FeeTariffsTable.$converterfeeType.fromJson(
        serializer.fromJson<String>(json['feeType']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'provider': serializer.toJson<String>(
        $FeeTariffsTable.$converterprovider.toJson(provider),
      ),
      'feeType': serializer.toJson<String>(
        $FeeTariffsTable.$converterfeeType.toJson(feeType),
      ),
    };
  }

  FeeTariffRow copyWith({AlertSource? provider, FeeType? feeType}) =>
      FeeTariffRow(
        provider: provider ?? this.provider,
        feeType: feeType ?? this.feeType,
      );
  FeeTariffRow copyWithCompanion(FeeTariffsCompanion data) {
    return FeeTariffRow(
      provider: data.provider.present ? data.provider.value : this.provider,
      feeType: data.feeType.present ? data.feeType.value : this.feeType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeTariffRow(')
          ..write('provider: $provider, ')
          ..write('feeType: $feeType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(provider, feeType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeTariffRow &&
          other.provider == this.provider &&
          other.feeType == this.feeType);
}

class FeeTariffsCompanion extends UpdateCompanion<FeeTariffRow> {
  final Value<AlertSource> provider;
  final Value<FeeType> feeType;
  final Value<int> rowid;
  const FeeTariffsCompanion({
    this.provider = const Value.absent(),
    this.feeType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeeTariffsCompanion.insert({
    required AlertSource provider,
    required FeeType feeType,
    this.rowid = const Value.absent(),
  }) : provider = Value(provider),
       feeType = Value(feeType);
  static Insertable<FeeTariffRow> custom({
    Expression<String>? provider,
    Expression<String>? feeType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (provider != null) 'provider': provider,
      if (feeType != null) 'fee_type': feeType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeeTariffsCompanion copyWith({
    Value<AlertSource>? provider,
    Value<FeeType>? feeType,
    Value<int>? rowid,
  }) {
    return FeeTariffsCompanion(
      provider: provider ?? this.provider,
      feeType: feeType ?? this.feeType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (provider.present) {
      map['provider'] = Variable<String>(
        $FeeTariffsTable.$converterprovider.toSql(provider.value),
      );
    }
    if (feeType.present) {
      map['fee_type'] = Variable<String>(
        $FeeTariffsTable.$converterfeeType.toSql(feeType.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeTariffsCompanion(')
          ..write('provider: $provider, ')
          ..write('feeType: $feeType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeeBandsTable extends FeeBands
    with TableInfo<$FeeBandsTable, FeeBandRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeeBandsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<AlertSource, String> provider =
      GeneratedColumn<String>(
        'provider',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AlertSource>($FeeBandsTable.$converterprovider);
  @override
  late final GeneratedColumnWithTypeConverter<FeeType, String> feeType =
      GeneratedColumn<String>(
        'fee_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeeType>($FeeBandsTable.$converterfeeType);
  static const VerificationMeta _minAmountMeta = const VerificationMeta(
    'minAmount',
  );
  @override
  late final GeneratedColumn<int> minAmount = GeneratedColumn<int>(
    'min_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxAmountMeta = const VerificationMeta(
    'maxAmount',
  );
  @override
  late final GeneratedColumn<int> maxAmount = GeneratedColumn<int>(
    'max_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feeMeta = const VerificationMeta('fee');
  @override
  late final GeneratedColumn<int> fee = GeneratedColumn<int>(
    'fee',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FeeBandSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeeBandSource>($FeeBandsTable.$convertersource);
  static const VerificationMeta _observationsMeta = const VerificationMeta(
    'observations',
  );
  @override
  late final GeneratedColumn<int> observations = GeneratedColumn<int>(
    'observations',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    provider,
    feeType,
    minAmount,
    maxAmount,
    fee,
    source,
    observations,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fee_bands';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeeBandRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('min_amount')) {
      context.handle(
        _minAmountMeta,
        minAmount.isAcceptableOrUnknown(data['min_amount']!, _minAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_minAmountMeta);
    }
    if (data.containsKey('max_amount')) {
      context.handle(
        _maxAmountMeta,
        maxAmount.isAcceptableOrUnknown(data['max_amount']!, _maxAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_maxAmountMeta);
    }
    if (data.containsKey('fee')) {
      context.handle(
        _feeMeta,
        fee.isAcceptableOrUnknown(data['fee']!, _feeMeta),
      );
    } else if (isInserting) {
      context.missing(_feeMeta);
    }
    if (data.containsKey('observations')) {
      context.handle(
        _observationsMeta,
        observations.isAcceptableOrUnknown(
          data['observations']!,
          _observationsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {provider, feeType, minAmount};
  @override
  FeeBandRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeeBandRow(
      provider: $FeeBandsTable.$converterprovider.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}provider'],
        )!,
      ),
      feeType: $FeeBandsTable.$converterfeeType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fee_type'],
        )!,
      ),
      minAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_amount'],
      )!,
      maxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_amount'],
      )!,
      fee: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fee'],
      )!,
      source: $FeeBandsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      observations: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}observations'],
      )!,
    );
  }

  @override
  $FeeBandsTable createAlias(String alias) {
    return $FeeBandsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AlertSource, String, String> $converterprovider =
      const EnumNameConverter<AlertSource>(AlertSource.values);
  static JsonTypeConverter2<FeeType, String, String> $converterfeeType =
      const EnumNameConverter<FeeType>(FeeType.values);
  static JsonTypeConverter2<FeeBandSource, String, String> $convertersource =
      const EnumNameConverter<FeeBandSource>(FeeBandSource.values);
}

class FeeBandRow extends DataClass implements Insertable<FeeBandRow> {
  final AlertSource provider;
  final FeeType feeType;
  final int minAmount;
  final int maxAmount;
  final int fee;
  final FeeBandSource source;
  final int observations;
  const FeeBandRow({
    required this.provider,
    required this.feeType,
    required this.minAmount,
    required this.maxAmount,
    required this.fee,
    required this.source,
    required this.observations,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['provider'] = Variable<String>(
        $FeeBandsTable.$converterprovider.toSql(provider),
      );
    }
    {
      map['fee_type'] = Variable<String>(
        $FeeBandsTable.$converterfeeType.toSql(feeType),
      );
    }
    map['min_amount'] = Variable<int>(minAmount);
    map['max_amount'] = Variable<int>(maxAmount);
    map['fee'] = Variable<int>(fee);
    {
      map['source'] = Variable<String>(
        $FeeBandsTable.$convertersource.toSql(source),
      );
    }
    map['observations'] = Variable<int>(observations);
    return map;
  }

  FeeBandsCompanion toCompanion(bool nullToAbsent) {
    return FeeBandsCompanion(
      provider: Value(provider),
      feeType: Value(feeType),
      minAmount: Value(minAmount),
      maxAmount: Value(maxAmount),
      fee: Value(fee),
      source: Value(source),
      observations: Value(observations),
    );
  }

  factory FeeBandRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeeBandRow(
      provider: $FeeBandsTable.$converterprovider.fromJson(
        serializer.fromJson<String>(json['provider']),
      ),
      feeType: $FeeBandsTable.$converterfeeType.fromJson(
        serializer.fromJson<String>(json['feeType']),
      ),
      minAmount: serializer.fromJson<int>(json['minAmount']),
      maxAmount: serializer.fromJson<int>(json['maxAmount']),
      fee: serializer.fromJson<int>(json['fee']),
      source: $FeeBandsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      observations: serializer.fromJson<int>(json['observations']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'provider': serializer.toJson<String>(
        $FeeBandsTable.$converterprovider.toJson(provider),
      ),
      'feeType': serializer.toJson<String>(
        $FeeBandsTable.$converterfeeType.toJson(feeType),
      ),
      'minAmount': serializer.toJson<int>(minAmount),
      'maxAmount': serializer.toJson<int>(maxAmount),
      'fee': serializer.toJson<int>(fee),
      'source': serializer.toJson<String>(
        $FeeBandsTable.$convertersource.toJson(source),
      ),
      'observations': serializer.toJson<int>(observations),
    };
  }

  FeeBandRow copyWith({
    AlertSource? provider,
    FeeType? feeType,
    int? minAmount,
    int? maxAmount,
    int? fee,
    FeeBandSource? source,
    int? observations,
  }) => FeeBandRow(
    provider: provider ?? this.provider,
    feeType: feeType ?? this.feeType,
    minAmount: minAmount ?? this.minAmount,
    maxAmount: maxAmount ?? this.maxAmount,
    fee: fee ?? this.fee,
    source: source ?? this.source,
    observations: observations ?? this.observations,
  );
  FeeBandRow copyWithCompanion(FeeBandsCompanion data) {
    return FeeBandRow(
      provider: data.provider.present ? data.provider.value : this.provider,
      feeType: data.feeType.present ? data.feeType.value : this.feeType,
      minAmount: data.minAmount.present ? data.minAmount.value : this.minAmount,
      maxAmount: data.maxAmount.present ? data.maxAmount.value : this.maxAmount,
      fee: data.fee.present ? data.fee.value : this.fee,
      source: data.source.present ? data.source.value : this.source,
      observations: data.observations.present
          ? data.observations.value
          : this.observations,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeeBandRow(')
          ..write('provider: $provider, ')
          ..write('feeType: $feeType, ')
          ..write('minAmount: $minAmount, ')
          ..write('maxAmount: $maxAmount, ')
          ..write('fee: $fee, ')
          ..write('source: $source, ')
          ..write('observations: $observations')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    provider,
    feeType,
    minAmount,
    maxAmount,
    fee,
    source,
    observations,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeeBandRow &&
          other.provider == this.provider &&
          other.feeType == this.feeType &&
          other.minAmount == this.minAmount &&
          other.maxAmount == this.maxAmount &&
          other.fee == this.fee &&
          other.source == this.source &&
          other.observations == this.observations);
}

class FeeBandsCompanion extends UpdateCompanion<FeeBandRow> {
  final Value<AlertSource> provider;
  final Value<FeeType> feeType;
  final Value<int> minAmount;
  final Value<int> maxAmount;
  final Value<int> fee;
  final Value<FeeBandSource> source;
  final Value<int> observations;
  final Value<int> rowid;
  const FeeBandsCompanion({
    this.provider = const Value.absent(),
    this.feeType = const Value.absent(),
    this.minAmount = const Value.absent(),
    this.maxAmount = const Value.absent(),
    this.fee = const Value.absent(),
    this.source = const Value.absent(),
    this.observations = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeeBandsCompanion.insert({
    required AlertSource provider,
    required FeeType feeType,
    required int minAmount,
    required int maxAmount,
    required int fee,
    required FeeBandSource source,
    this.observations = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : provider = Value(provider),
       feeType = Value(feeType),
       minAmount = Value(minAmount),
       maxAmount = Value(maxAmount),
       fee = Value(fee),
       source = Value(source);
  static Insertable<FeeBandRow> custom({
    Expression<String>? provider,
    Expression<String>? feeType,
    Expression<int>? minAmount,
    Expression<int>? maxAmount,
    Expression<int>? fee,
    Expression<String>? source,
    Expression<int>? observations,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (provider != null) 'provider': provider,
      if (feeType != null) 'fee_type': feeType,
      if (minAmount != null) 'min_amount': minAmount,
      if (maxAmount != null) 'max_amount': maxAmount,
      if (fee != null) 'fee': fee,
      if (source != null) 'source': source,
      if (observations != null) 'observations': observations,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeeBandsCompanion copyWith({
    Value<AlertSource>? provider,
    Value<FeeType>? feeType,
    Value<int>? minAmount,
    Value<int>? maxAmount,
    Value<int>? fee,
    Value<FeeBandSource>? source,
    Value<int>? observations,
    Value<int>? rowid,
  }) {
    return FeeBandsCompanion(
      provider: provider ?? this.provider,
      feeType: feeType ?? this.feeType,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      fee: fee ?? this.fee,
      source: source ?? this.source,
      observations: observations ?? this.observations,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (provider.present) {
      map['provider'] = Variable<String>(
        $FeeBandsTable.$converterprovider.toSql(provider.value),
      );
    }
    if (feeType.present) {
      map['fee_type'] = Variable<String>(
        $FeeBandsTable.$converterfeeType.toSql(feeType.value),
      );
    }
    if (minAmount.present) {
      map['min_amount'] = Variable<int>(minAmount.value);
    }
    if (maxAmount.present) {
      map['max_amount'] = Variable<int>(maxAmount.value);
    }
    if (fee.present) {
      map['fee'] = Variable<int>(fee.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $FeeBandsTable.$convertersource.toSql(source.value),
      );
    }
    if (observations.present) {
      map['observations'] = Variable<int>(observations.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeeBandsCompanion(')
          ..write('provider: $provider, ')
          ..write('feeType: $feeType, ')
          ..write('minAmount: $minAmount, ')
          ..write('maxAmount: $maxAmount, ')
          ..write('fee: $fee, ')
          ..write('source: $source, ')
          ..write('observations: $observations, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$BucketsDatabase extends GeneratedDatabase {
  _$BucketsDatabase(QueryExecutor e) : super(e);
  $BucketsDatabaseManager get managers => $BucketsDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $AccountMatchKeysTable accountMatchKeys = $AccountMatchKeysTable(
    this,
  );
  late final $BucketsTable buckets = $BucketsTable(this);
  late final $IncomeSourcesTable incomeSources = $IncomeSourcesTable(this);
  late final $IncomePayerKeysTable incomePayerKeys = $IncomePayerKeysTable(
    this,
  );
  late final $SplitProfilesTable splitProfiles = $SplitProfilesTable(this);
  late final $SplitAllocationsTable splitAllocations = $SplitAllocationsTable(
    this,
  );
  late final $BillsTable bills = $BillsTable(this);
  late final $SettingsRowsTable settingsRows = $SettingsRowsTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $HelpFeedbacksTable helpFeedbacks = $HelpFeedbacksTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final $PaydaysTable paydays = $PaydaysTable(this);
  late final $TransfersTable transfers = $TransfersTable(this);
  late final $TransferProofRefsTable transferProofRefs =
      $TransferProofRefsTable(this);
  late final $HeldIncomesTable heldIncomes = $HeldIncomesTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $CheckInsTable checkIns = $CheckInsTable(this);
  late final $PaymentAlertsTable paymentAlerts = $PaymentAlertsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $TransactionLinesTable transactionLines = $TransactionLinesTable(
    this,
  );
  late final $CashWithdrawalsTable cashWithdrawals = $CashWithdrawalsTable(
    this,
  );
  late final $MerchantRulesTable merchantRules = $MerchantRulesTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $PlannedPurchasesTable plannedPurchases = $PlannedPurchasesTable(
    this,
  );
  late final $WishesTable wishes = $WishesTable(this);
  late final $BillOccurrencesTable billOccurrences = $BillOccurrencesTable(
    this,
  );
  late final $FeeTariffsTable feeTariffs = $FeeTariffsTable(this);
  late final $FeeBandsTable feeBands = $FeeBandsTable(this);
  late final Index ledgerBucketTime = Index(
    'ledger_bucket_time',
    'CREATE INDEX ledger_bucket_time ON ledger_entries (bucket_id, occurred_at)',
  );
  late final Index ledgerCarryOver = Index(
    'ledger_carry_over',
    'CREATE INDEX ledger_carry_over ON ledger_entries (carry_over_id)',
  );
  late final Index paydaysStarted = Index(
    'paydays_started',
    'CREATE INDEX paydays_started ON paydays (started_at)',
  );
  late final Index proofRefsReference = Index(
    'proof_refs_reference',
    'CREATE INDEX proof_refs_reference ON transfer_proof_refs (reference)',
  );
  late final Index alertsReference = Index(
    'alerts_reference',
    'CREATE INDEX alerts_reference ON payment_alerts (source, reference)',
  );
  late final Index alertsReceived = Index(
    'alerts_received',
    'CREATE INDEX alerts_received ON payment_alerts (received_at)',
  );
  late final Index alertsStatus = Index(
    'alerts_status',
    'CREATE INDEX alerts_status ON payment_alerts (status)',
  );
  late final Index transactionsTime = Index(
    'transactions_time',
    'CREATE INDEX transactions_time ON transactions (occurred_at)',
  );
  late final Index withdrawalsTime = Index(
    'withdrawals_time',
    'CREATE INDEX withdrawals_time ON cash_withdrawals (occurred_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    accountMatchKeys,
    buckets,
    incomeSources,
    incomePayerKeys,
    splitProfiles,
    splitAllocations,
    bills,
    settingsRows,
    profiles,
    categories,
    helpFeedbacks,
    ledgerEntries,
    paydays,
    transfers,
    transferProofRefs,
    heldIncomes,
    goals,
    checkIns,
    paymentAlerts,
    transactions,
    transactionLines,
    cashWithdrawals,
    merchantRules,
    receipts,
    plannedPurchases,
    wishes,
    billOccurrences,
    feeTariffs,
    feeBands,
    ledgerBucketTime,
    ledgerCarryOver,
    paydaysStarted,
    proofRefsReference,
    alertsReference,
    alertsReceived,
    alertsStatus,
    transactionsTime,
    withdrawalsTime,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  required String id,
  required String name,
  required AccountKind kind,
  required bool isSpending,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<AccountKind> kind,
  Value<bool> isSpending,
  Value<int> rowid,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$BucketsDatabase, $AccountsTable, AccountRow> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AccountMatchKeysTable, List<AccountMatchKeyRow>>
  _accountMatchKeysRefsTable(_$BucketsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.accountMatchKeys,
        aliasName: 'accounts__id__account_match_keys__account_id',
      );

  $$AccountMatchKeysTableProcessedTableManager get accountMatchKeysRefs {
    final manager = $$AccountMatchKeysTableTableManager(
      $_db,
      $_db.accountMatchKeys,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _accountMatchKeysRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$BucketsDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountKind, AccountKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isSpending => $composableBuilder(
    column: $table.isSpending,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> accountMatchKeysRefs(
    Expression<bool> Function($$AccountMatchKeysTableFilterComposer f) f,
  ) {
    final $$AccountMatchKeysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accountMatchKeys,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountMatchKeysTableFilterComposer(
            $db: $db,
            $table: $db.accountMatchKeys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSpending => $composableBuilder(
    column: $table.isSpending,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get isSpending => $composableBuilder(
    column: $table.isSpending,
    builder: (column) => column,
  );

  Expression<T> accountMatchKeysRefs<T extends Object>(
    Expression<T> Function($$AccountMatchKeysTableAnnotationComposer a) f,
  ) {
    final $$AccountMatchKeysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accountMatchKeys,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountMatchKeysTableAnnotationComposer(
            $db: $db,
            $table: $db.accountMatchKeys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $AccountsTable,
          AccountRow,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (AccountRow, $$AccountsTableReferences),
          AccountRow,
          PrefetchHooks Function({bool accountMatchKeysRefs})
        > {
  $$AccountsTableTableManager(_$BucketsDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<AccountKind> kind = const Value.absent(),
                Value<bool> isSpending = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                kind: kind,
                isSpending: isSpending,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required AccountKind kind,
                required bool isSpending,
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                isSpending: isSpending,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountsTable, AccountRow>(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountMatchKeysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (accountMatchKeysRefs) db.accountMatchKeys,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (accountMatchKeysRefs)
                    await $_getPrefetchedDataByColumns<
                      AccountRow,
                      $AccountsTable,
                      AccountMatchKeyRow,
                      $AccountMatchKeysTable
                    >(
                      currentTable: table,
                      referencedTable: $$AccountsTableReferences
                          ._accountMatchKeysRefsTable(db),
                      managerFromTypedResult: (p0) => $$AccountsTableReferences(
                        db,
                        table,
                        p0,
                      ).accountMatchKeysRefs,
                      currentColumn: 'id',
                      referencedColumn: 'account_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $AccountsTable,
      AccountRow,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (AccountRow, $$AccountsTableReferences),
      AccountRow,
      PrefetchHooks Function({bool accountMatchKeysRefs})
    >;
typedef $$AccountMatchKeysTableCreateCompanionBuilder =
    AccountMatchKeysCompanion Function({
      required String accountId,
      required int position,
      required String value,
      Value<int> rowid,
    });
typedef $$AccountMatchKeysTableUpdateCompanionBuilder =
    AccountMatchKeysCompanion Function({
      Value<String> accountId,
      Value<int> position,
      Value<String> value,
      Value<int> rowid,
    });

final class $$AccountMatchKeysTableReferences
    extends
        BaseReferences<
          _$BucketsDatabase,
          $AccountMatchKeysTable,
          AccountMatchKeyRow
        > {
  $$AccountMatchKeysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTable _accountIdTable(_$BucketsDatabase db) =>
      db.accounts.createAlias('account_match_keys__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AccountMatchKeysTableFilterComposer
    extends Composer<_$BucketsDatabase, $AccountMatchKeysTable> {
  $$AccountMatchKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountMatchKeysTableOrderingComposer
    extends Composer<_$BucketsDatabase, $AccountMatchKeysTable> {
  $$AccountMatchKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountMatchKeysTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $AccountMatchKeysTable> {
  $$AccountMatchKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountMatchKeysTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $AccountMatchKeysTable,
          AccountMatchKeyRow,
          $$AccountMatchKeysTableFilterComposer,
          $$AccountMatchKeysTableOrderingComposer,
          $$AccountMatchKeysTableAnnotationComposer,
          $$AccountMatchKeysTableCreateCompanionBuilder,
          $$AccountMatchKeysTableUpdateCompanionBuilder,
          (AccountMatchKeyRow, $$AccountMatchKeysTableReferences),
          AccountMatchKeyRow,
          PrefetchHooks Function({bool accountId})
        > {
  $$AccountMatchKeysTableTableManager(
    _$BucketsDatabase db,
    $AccountMatchKeysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountMatchKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountMatchKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountMatchKeysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountMatchKeysCompanion(
                accountId: accountId,
                position: position,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                required int position,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AccountMatchKeysCompanion.insert(
                accountId: accountId,
                position: position,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountMatchKeysTable, AccountMatchKeyRow>(
                    table,
                  ),
                  $$AccountMatchKeysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$AccountMatchKeysTableReferences
                            ._accountIdTable(db),
                        referencedColumn: $$AccountMatchKeysTableReferences
                            ._accountIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AccountMatchKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $AccountMatchKeysTable,
      AccountMatchKeyRow,
      $$AccountMatchKeysTableFilterComposer,
      $$AccountMatchKeysTableOrderingComposer,
      $$AccountMatchKeysTableAnnotationComposer,
      $$AccountMatchKeysTableCreateCompanionBuilder,
      $$AccountMatchKeysTableUpdateCompanionBuilder,
      (AccountMatchKeyRow, $$AccountMatchKeysTableReferences),
      AccountMatchKeyRow,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$BucketsTableCreateCompanionBuilder = BucketsCompanion Function({
  required String id,
  required String name,
  required BucketKind kind,
  required BucketColor color,
  required String accountId,
  required bool isProtected,
  required int sortOrder,
  required bool archived,
  Value<int> rowid,
});
typedef $$BucketsTableUpdateCompanionBuilder = BucketsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<BucketKind> kind,
  Value<BucketColor> color,
  Value<String> accountId,
  Value<bool> isProtected,
  Value<int> sortOrder,
  Value<bool> archived,
  Value<int> rowid,
});

class $$BucketsTableFilterComposer
    extends Composer<_$BucketsDatabase, $BucketsTable> {
  $$BucketsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BucketKind, BucketKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<BucketColor, BucketColor, String> get color =>
      $composableBuilder(
        column: $table.color,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isProtected => $composableBuilder(
    column: $table.isProtected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BucketsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $BucketsTable> {
  $$BucketsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isProtected => $composableBuilder(
    column: $table.isProtected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BucketsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $BucketsTable> {
  $$BucketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BucketKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BucketColor, String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<bool> get isProtected => $composableBuilder(
    column: $table.isProtected,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$BucketsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $BucketsTable,
          BucketRow,
          $$BucketsTableFilterComposer,
          $$BucketsTableOrderingComposer,
          $$BucketsTableAnnotationComposer,
          $$BucketsTableCreateCompanionBuilder,
          $$BucketsTableUpdateCompanionBuilder,
          (
            BucketRow,
            BaseReferences<_$BucketsDatabase, $BucketsTable, BucketRow>,
          ),
          BucketRow,
          PrefetchHooks Function()
        > {
  $$BucketsTableTableManager(_$BucketsDatabase db, $BucketsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BucketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BucketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BucketsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<BucketKind> kind = const Value.absent(),
                Value<BucketColor> color = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<bool> isProtected = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BucketsCompanion(
                id: id,
                name: name,
                kind: kind,
                color: color,
                accountId: accountId,
                isProtected: isProtected,
                sortOrder: sortOrder,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required BucketKind kind,
                required BucketColor color,
                required String accountId,
                required bool isProtected,
                required int sortOrder,
                required bool archived,
                Value<int> rowid = const Value.absent(),
              }) => BucketsCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                color: color,
                accountId: accountId,
                isProtected: isProtected,
                sortOrder: sortOrder,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BucketsTable, BucketRow>(table),
                  BaseReferences<_$BucketsDatabase, $BucketsTable, BucketRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BucketsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $BucketsTable,
      BucketRow,
      $$BucketsTableFilterComposer,
      $$BucketsTableOrderingComposer,
      $$BucketsTableAnnotationComposer,
      $$BucketsTableCreateCompanionBuilder,
      $$BucketsTableUpdateCompanionBuilder,
      (BucketRow, BaseReferences<_$BucketsDatabase, $BucketsTable, BucketRow>),
      BucketRow,
      PrefetchHooks Function()
    >;
typedef $$IncomeSourcesTableCreateCompanionBuilder =
    IncomeSourcesCompanion Function({
      required String id,
      required String name,
      required IncomeKind kind,
      Value<int?> expectedAmount,
      required String scheduleKind,
      Value<int?> scheduleDay,
      Value<DateTime?> scheduleAnchor,
      required String landsInAccountId,
      required String splitProfileId,
      required bool deductBillsFirst,
      Value<int> rowid,
    });
typedef $$IncomeSourcesTableUpdateCompanionBuilder =
    IncomeSourcesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<IncomeKind> kind,
      Value<int?> expectedAmount,
      Value<String> scheduleKind,
      Value<int?> scheduleDay,
      Value<DateTime?> scheduleAnchor,
      Value<String> landsInAccountId,
      Value<String> splitProfileId,
      Value<bool> deductBillsFirst,
      Value<int> rowid,
    });

final class $$IncomeSourcesTableReferences
    extends
        BaseReferences<
          _$BucketsDatabase,
          $IncomeSourcesTable,
          IncomeSourceRow
        > {
  $$IncomeSourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$IncomePayerKeysTable, List<IncomePayerKeyRow>>
  _incomePayerKeysRefsTable(_$BucketsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.incomePayerKeys,
        aliasName: 'income_sources__id__income_payer_keys__income_id',
      );

  $$IncomePayerKeysTableProcessedTableManager get incomePayerKeysRefs {
    final manager = $$IncomePayerKeysTableTableManager(
      $_db,
      $_db.incomePayerKeys,
    ).filter((f) => f.incomeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _incomePayerKeysRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IncomeSourcesTableFilterComposer
    extends Composer<_$BucketsDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<IncomeKind, IncomeKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleKind => $composableBuilder(
    column: $table.scheduleKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduleDay => $composableBuilder(
    column: $table.scheduleDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduleAnchor => $composableBuilder(
    column: $table.scheduleAnchor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get landsInAccountId => $composableBuilder(
    column: $table.landsInAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get splitProfileId => $composableBuilder(
    column: $table.splitProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deductBillsFirst => $composableBuilder(
    column: $table.deductBillsFirst,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> incomePayerKeysRefs(
    Expression<bool> Function($$IncomePayerKeysTableFilterComposer f) f,
  ) {
    final $$IncomePayerKeysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.incomePayerKeys,
      getReferencedColumn: (t) => t.incomeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomePayerKeysTableFilterComposer(
            $db: $db,
            $table: $db.incomePayerKeys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IncomeSourcesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleKind => $composableBuilder(
    column: $table.scheduleKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduleDay => $composableBuilder(
    column: $table.scheduleDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduleAnchor => $composableBuilder(
    column: $table.scheduleAnchor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get landsInAccountId => $composableBuilder(
    column: $table.landsInAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get splitProfileId => $composableBuilder(
    column: $table.splitProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deductBillsFirst => $composableBuilder(
    column: $table.deductBillsFirst,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomeSourcesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<IncomeKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheduleKind => $composableBuilder(
    column: $table.scheduleKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scheduleDay => $composableBuilder(
    column: $table.scheduleDay,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduleAnchor => $composableBuilder(
    column: $table.scheduleAnchor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get landsInAccountId => $composableBuilder(
    column: $table.landsInAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get splitProfileId => $composableBuilder(
    column: $table.splitProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get deductBillsFirst => $composableBuilder(
    column: $table.deductBillsFirst,
    builder: (column) => column,
  );

  Expression<T> incomePayerKeysRefs<T extends Object>(
    Expression<T> Function($$IncomePayerKeysTableAnnotationComposer a) f,
  ) {
    final $$IncomePayerKeysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.incomePayerKeys,
      getReferencedColumn: (t) => t.incomeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomePayerKeysTableAnnotationComposer(
            $db: $db,
            $table: $db.incomePayerKeys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IncomeSourcesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $IncomeSourcesTable,
          IncomeSourceRow,
          $$IncomeSourcesTableFilterComposer,
          $$IncomeSourcesTableOrderingComposer,
          $$IncomeSourcesTableAnnotationComposer,
          $$IncomeSourcesTableCreateCompanionBuilder,
          $$IncomeSourcesTableUpdateCompanionBuilder,
          (IncomeSourceRow, $$IncomeSourcesTableReferences),
          IncomeSourceRow,
          PrefetchHooks Function({bool incomePayerKeysRefs})
        > {
  $$IncomeSourcesTableTableManager(
    _$BucketsDatabase db,
    $IncomeSourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomeSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomeSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomeSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<IncomeKind> kind = const Value.absent(),
                Value<int?> expectedAmount = const Value.absent(),
                Value<String> scheduleKind = const Value.absent(),
                Value<int?> scheduleDay = const Value.absent(),
                Value<DateTime?> scheduleAnchor = const Value.absent(),
                Value<String> landsInAccountId = const Value.absent(),
                Value<String> splitProfileId = const Value.absent(),
                Value<bool> deductBillsFirst = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomeSourcesCompanion(
                id: id,
                name: name,
                kind: kind,
                expectedAmount: expectedAmount,
                scheduleKind: scheduleKind,
                scheduleDay: scheduleDay,
                scheduleAnchor: scheduleAnchor,
                landsInAccountId: landsInAccountId,
                splitProfileId: splitProfileId,
                deductBillsFirst: deductBillsFirst,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required IncomeKind kind,
                Value<int?> expectedAmount = const Value.absent(),
                required String scheduleKind,
                Value<int?> scheduleDay = const Value.absent(),
                Value<DateTime?> scheduleAnchor = const Value.absent(),
                required String landsInAccountId,
                required String splitProfileId,
                required bool deductBillsFirst,
                Value<int> rowid = const Value.absent(),
              }) => IncomeSourcesCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                expectedAmount: expectedAmount,
                scheduleKind: scheduleKind,
                scheduleDay: scheduleDay,
                scheduleAnchor: scheduleAnchor,
                landsInAccountId: landsInAccountId,
                splitProfileId: splitProfileId,
                deductBillsFirst: deductBillsFirst,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IncomeSourcesTable, IncomeSourceRow>(table),
                  $$IncomeSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({incomePayerKeysRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (incomePayerKeysRefs) db.incomePayerKeys,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (incomePayerKeysRefs)
                    await $_getPrefetchedDataByColumns<
                      IncomeSourceRow,
                      $IncomeSourcesTable,
                      IncomePayerKeyRow,
                      $IncomePayerKeysTable
                    >(
                      currentTable: table,
                      referencedTable: $$IncomeSourcesTableReferences
                          ._incomePayerKeysRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$IncomeSourcesTableReferences(
                            db,
                            table,
                            p0,
                          ).incomePayerKeysRefs,
                      currentColumn: 'id',
                      referencedColumn: 'income_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$IncomeSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $IncomeSourcesTable,
      IncomeSourceRow,
      $$IncomeSourcesTableFilterComposer,
      $$IncomeSourcesTableOrderingComposer,
      $$IncomeSourcesTableAnnotationComposer,
      $$IncomeSourcesTableCreateCompanionBuilder,
      $$IncomeSourcesTableUpdateCompanionBuilder,
      (IncomeSourceRow, $$IncomeSourcesTableReferences),
      IncomeSourceRow,
      PrefetchHooks Function({bool incomePayerKeysRefs})
    >;
typedef $$IncomePayerKeysTableCreateCompanionBuilder =
    IncomePayerKeysCompanion Function({
      required String incomeId,
      required int position,
      required String value,
      Value<int> rowid,
    });
typedef $$IncomePayerKeysTableUpdateCompanionBuilder =
    IncomePayerKeysCompanion Function({
      Value<String> incomeId,
      Value<int> position,
      Value<String> value,
      Value<int> rowid,
    });

final class $$IncomePayerKeysTableReferences
    extends
        BaseReferences<
          _$BucketsDatabase,
          $IncomePayerKeysTable,
          IncomePayerKeyRow
        > {
  $$IncomePayerKeysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $IncomeSourcesTable _incomeIdTable(_$BucketsDatabase db) => db
      .incomeSources
      .createAlias('income_payer_keys__income_id__income_sources__id');

  $$IncomeSourcesTableProcessedTableManager get incomeId {
    final $_column = $_itemColumn<String>('income_id')!;

    final manager = $$IncomeSourcesTableTableManager(
      $_db,
      $_db.incomeSources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_incomeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IncomePayerKeysTableFilterComposer
    extends Composer<_$BucketsDatabase, $IncomePayerKeysTable> {
  $$IncomePayerKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$IncomeSourcesTableFilterComposer get incomeId {
    final $$IncomeSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.incomeId,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableFilterComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IncomePayerKeysTableOrderingComposer
    extends Composer<_$BucketsDatabase, $IncomePayerKeysTable> {
  $$IncomePayerKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$IncomeSourcesTableOrderingComposer get incomeId {
    final $$IncomeSourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.incomeId,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableOrderingComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IncomePayerKeysTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $IncomePayerKeysTable> {
  $$IncomePayerKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$IncomeSourcesTableAnnotationComposer get incomeId {
    final $$IncomeSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.incomeId,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IncomePayerKeysTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $IncomePayerKeysTable,
          IncomePayerKeyRow,
          $$IncomePayerKeysTableFilterComposer,
          $$IncomePayerKeysTableOrderingComposer,
          $$IncomePayerKeysTableAnnotationComposer,
          $$IncomePayerKeysTableCreateCompanionBuilder,
          $$IncomePayerKeysTableUpdateCompanionBuilder,
          (IncomePayerKeyRow, $$IncomePayerKeysTableReferences),
          IncomePayerKeyRow,
          PrefetchHooks Function({bool incomeId})
        > {
  $$IncomePayerKeysTableTableManager(
    _$BucketsDatabase db,
    $IncomePayerKeysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomePayerKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomePayerKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomePayerKeysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> incomeId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomePayerKeysCompanion(
                incomeId: incomeId,
                position: position,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String incomeId,
                required int position,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => IncomePayerKeysCompanion.insert(
                incomeId: incomeId,
                position: position,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IncomePayerKeysTable, IncomePayerKeyRow>(table),
                  $$IncomePayerKeysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({incomeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (incomeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.incomeId,
                        referencedTable: $$IncomePayerKeysTableReferences
                            ._incomeIdTable(db),
                        referencedColumn: $$IncomePayerKeysTableReferences
                            ._incomeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IncomePayerKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $IncomePayerKeysTable,
      IncomePayerKeyRow,
      $$IncomePayerKeysTableFilterComposer,
      $$IncomePayerKeysTableOrderingComposer,
      $$IncomePayerKeysTableAnnotationComposer,
      $$IncomePayerKeysTableCreateCompanionBuilder,
      $$IncomePayerKeysTableUpdateCompanionBuilder,
      (IncomePayerKeyRow, $$IncomePayerKeysTableReferences),
      IncomePayerKeyRow,
      PrefetchHooks Function({bool incomeId})
    >;
typedef $$SplitProfilesTableCreateCompanionBuilder =
    SplitProfilesCompanion Function({
      required String id,
      required bool holdUntilMonthEnd,
      Value<int> rowid,
    });
typedef $$SplitProfilesTableUpdateCompanionBuilder =
    SplitProfilesCompanion Function({
      Value<String> id,
      Value<bool> holdUntilMonthEnd,
      Value<int> rowid,
    });

final class $$SplitProfilesTableReferences
    extends
        BaseReferences<
          _$BucketsDatabase,
          $SplitProfilesTable,
          SplitProfileRow
        > {
  $$SplitProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SplitAllocationsTable, List<SplitAllocationRow>>
  _splitAllocationsRefsTable(_$BucketsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.splitAllocations,
        aliasName: 'split_profiles__id__split_allocations__profile_id',
      );

  $$SplitAllocationsTableProcessedTableManager get splitAllocationsRefs {
    final manager = $$SplitAllocationsTableTableManager(
      $_db,
      $_db.splitAllocations,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _splitAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SplitProfilesTableFilterComposer
    extends Composer<_$BucketsDatabase, $SplitProfilesTable> {
  $$SplitProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get holdUntilMonthEnd => $composableBuilder(
    column: $table.holdUntilMonthEnd,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> splitAllocationsRefs(
    Expression<bool> Function($$SplitAllocationsTableFilterComposer f) f,
  ) {
    final $$SplitAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.splitAllocations,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SplitAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.splitAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SplitProfilesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $SplitProfilesTable> {
  $$SplitProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get holdUntilMonthEnd => $composableBuilder(
    column: $table.holdUntilMonthEnd,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SplitProfilesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $SplitProfilesTable> {
  $$SplitProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get holdUntilMonthEnd => $composableBuilder(
    column: $table.holdUntilMonthEnd,
    builder: (column) => column,
  );

  Expression<T> splitAllocationsRefs<T extends Object>(
    Expression<T> Function($$SplitAllocationsTableAnnotationComposer a) f,
  ) {
    final $$SplitAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.splitAllocations,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SplitAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.splitAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SplitProfilesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $SplitProfilesTable,
          SplitProfileRow,
          $$SplitProfilesTableFilterComposer,
          $$SplitProfilesTableOrderingComposer,
          $$SplitProfilesTableAnnotationComposer,
          $$SplitProfilesTableCreateCompanionBuilder,
          $$SplitProfilesTableUpdateCompanionBuilder,
          (SplitProfileRow, $$SplitProfilesTableReferences),
          SplitProfileRow,
          PrefetchHooks Function({bool splitAllocationsRefs})
        > {
  $$SplitProfilesTableTableManager(
    _$BucketsDatabase db,
    $SplitProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SplitProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SplitProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SplitProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<bool> holdUntilMonthEnd = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SplitProfilesCompanion(
                id: id,
                holdUntilMonthEnd: holdUntilMonthEnd,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required bool holdUntilMonthEnd,
                Value<int> rowid = const Value.absent(),
              }) => SplitProfilesCompanion.insert(
                id: id,
                holdUntilMonthEnd: holdUntilMonthEnd,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SplitProfilesTable, SplitProfileRow>(table),
                  $$SplitProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({splitAllocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (splitAllocationsRefs) db.splitAllocations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (splitAllocationsRefs)
                    await $_getPrefetchedDataByColumns<
                      SplitProfileRow,
                      $SplitProfilesTable,
                      SplitAllocationRow,
                      $SplitAllocationsTable
                    >(
                      currentTable: table,
                      referencedTable: $$SplitProfilesTableReferences
                          ._splitAllocationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SplitProfilesTableReferences(
                            db,
                            table,
                            p0,
                          ).splitAllocationsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'profile_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SplitProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $SplitProfilesTable,
      SplitProfileRow,
      $$SplitProfilesTableFilterComposer,
      $$SplitProfilesTableOrderingComposer,
      $$SplitProfilesTableAnnotationComposer,
      $$SplitProfilesTableCreateCompanionBuilder,
      $$SplitProfilesTableUpdateCompanionBuilder,
      (SplitProfileRow, $$SplitProfilesTableReferences),
      SplitProfileRow,
      PrefetchHooks Function({bool splitAllocationsRefs})
    >;
typedef $$SplitAllocationsTableCreateCompanionBuilder =
    SplitAllocationsCompanion Function({
      required String profileId,
      required int position,
      required String bucketId,
      required int basisPoints,
      Value<int> rowid,
    });
typedef $$SplitAllocationsTableUpdateCompanionBuilder =
    SplitAllocationsCompanion Function({
      Value<String> profileId,
      Value<int> position,
      Value<String> bucketId,
      Value<int> basisPoints,
      Value<int> rowid,
    });

final class $$SplitAllocationsTableReferences
    extends
        BaseReferences<
          _$BucketsDatabase,
          $SplitAllocationsTable,
          SplitAllocationRow
        > {
  $$SplitAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SplitProfilesTable _profileIdTable(_$BucketsDatabase db) => db
      .splitProfiles
      .createAlias('split_allocations__profile_id__split_profiles__id');

  $$SplitProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$SplitProfilesTableTableManager(
      $_db,
      $_db.splitProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SplitAllocationsTableFilterComposer
    extends Composer<_$BucketsDatabase, $SplitAllocationsTable> {
  $$SplitAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get basisPoints => $composableBuilder(
    column: $table.basisPoints,
    builder: (column) => ColumnFilters(column),
  );

  $$SplitProfilesTableFilterComposer get profileId {
    final $$SplitProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.splitProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SplitProfilesTableFilterComposer(
            $db: $db,
            $table: $db.splitProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SplitAllocationsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $SplitAllocationsTable> {
  $$SplitAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get basisPoints => $composableBuilder(
    column: $table.basisPoints,
    builder: (column) => ColumnOrderings(column),
  );

  $$SplitProfilesTableOrderingComposer get profileId {
    final $$SplitProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.splitProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SplitProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.splitProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SplitAllocationsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $SplitAllocationsTable> {
  $$SplitAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<int> get basisPoints => $composableBuilder(
    column: $table.basisPoints,
    builder: (column) => column,
  );

  $$SplitProfilesTableAnnotationComposer get profileId {
    final $$SplitProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.splitProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SplitProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.splitProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SplitAllocationsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $SplitAllocationsTable,
          SplitAllocationRow,
          $$SplitAllocationsTableFilterComposer,
          $$SplitAllocationsTableOrderingComposer,
          $$SplitAllocationsTableAnnotationComposer,
          $$SplitAllocationsTableCreateCompanionBuilder,
          $$SplitAllocationsTableUpdateCompanionBuilder,
          (SplitAllocationRow, $$SplitAllocationsTableReferences),
          SplitAllocationRow,
          PrefetchHooks Function({bool profileId})
        > {
  $$SplitAllocationsTableTableManager(
    _$BucketsDatabase db,
    $SplitAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SplitAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SplitAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SplitAllocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> profileId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<int> basisPoints = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SplitAllocationsCompanion(
                profileId: profileId,
                position: position,
                bucketId: bucketId,
                basisPoints: basisPoints,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String profileId,
                required int position,
                required String bucketId,
                required int basisPoints,
                Value<int> rowid = const Value.absent(),
              }) => SplitAllocationsCompanion.insert(
                profileId: profileId,
                position: position,
                bucketId: bucketId,
                basisPoints: basisPoints,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SplitAllocationsTable, SplitAllocationRow>(
                    table,
                  ),
                  $$SplitAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$SplitAllocationsTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$SplitAllocationsTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SplitAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $SplitAllocationsTable,
      SplitAllocationRow,
      $$SplitAllocationsTableFilterComposer,
      $$SplitAllocationsTableOrderingComposer,
      $$SplitAllocationsTableAnnotationComposer,
      $$SplitAllocationsTableCreateCompanionBuilder,
      $$SplitAllocationsTableUpdateCompanionBuilder,
      (SplitAllocationRow, $$SplitAllocationsTableReferences),
      SplitAllocationRow,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$BillsTableCreateCompanionBuilder = BillsCompanion Function({
  required String id,
  required String name,
  required int amount,
  required int frequencyMonths,
  Value<int?> dueDay,
  Value<DateTime?> nextDueDate,
  required String paidFromBucketId,
  Value<String?> payeeAccountHint,
  Value<int> rowid,
});
typedef $$BillsTableUpdateCompanionBuilder = BillsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> amount,
  Value<int> frequencyMonths,
  Value<int?> dueDay,
  Value<DateTime?> nextDueDate,
  Value<String> paidFromBucketId,
  Value<String?> payeeAccountHint,
  Value<int> rowid,
});

class $$BillsTableFilterComposer
    extends Composer<_$BucketsDatabase, $BillsTable> {
  $$BillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get frequencyMonths => $composableBuilder(
    column: $table.frequencyMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidFromBucketId => $composableBuilder(
    column: $table.paidFromBucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payeeAccountHint => $composableBuilder(
    column: $table.payeeAccountHint,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $BillsTable> {
  $$BillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequencyMonths => $composableBuilder(
    column: $table.frequencyMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDay => $composableBuilder(
    column: $table.dueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidFromBucketId => $composableBuilder(
    column: $table.paidFromBucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payeeAccountHint => $composableBuilder(
    column: $table.payeeAccountHint,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $BillsTable> {
  $$BillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get frequencyMonths => $composableBuilder(
    column: $table.frequencyMonths,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDay =>
      $composableBuilder(column: $table.dueDay, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
    column: $table.nextDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paidFromBucketId => $composableBuilder(
    column: $table.paidFromBucketId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payeeAccountHint => $composableBuilder(
    column: $table.payeeAccountHint,
    builder: (column) => column,
  );
}

class $$BillsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $BillsTable,
          BillRow,
          $$BillsTableFilterComposer,
          $$BillsTableOrderingComposer,
          $$BillsTableAnnotationComposer,
          $$BillsTableCreateCompanionBuilder,
          $$BillsTableUpdateCompanionBuilder,
          (BillRow, BaseReferences<_$BucketsDatabase, $BillsTable, BillRow>),
          BillRow,
          PrefetchHooks Function()
        > {
  $$BillsTableTableManager(_$BucketsDatabase db, $BillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> frequencyMonths = const Value.absent(),
                Value<int?> dueDay = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                Value<String> paidFromBucketId = const Value.absent(),
                Value<String?> payeeAccountHint = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion(
                id: id,
                name: name,
                amount: amount,
                frequencyMonths: frequencyMonths,
                dueDay: dueDay,
                nextDueDate: nextDueDate,
                paidFromBucketId: paidFromBucketId,
                payeeAccountHint: payeeAccountHint,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int amount,
                required int frequencyMonths,
                Value<int?> dueDay = const Value.absent(),
                Value<DateTime?> nextDueDate = const Value.absent(),
                required String paidFromBucketId,
                Value<String?> payeeAccountHint = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion.insert(
                id: id,
                name: name,
                amount: amount,
                frequencyMonths: frequencyMonths,
                dueDay: dueDay,
                nextDueDate: nextDueDate,
                paidFromBucketId: paidFromBucketId,
                payeeAccountHint: payeeAccountHint,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillsTable, BillRow>(table),
                  BaseReferences<_$BucketsDatabase, $BillsTable, BillRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $BillsTable,
      BillRow,
      $$BillsTableFilterComposer,
      $$BillsTableOrderingComposer,
      $$BillsTableAnnotationComposer,
      $$BillsTableCreateCompanionBuilder,
      $$BillsTableUpdateCompanionBuilder,
      (BillRow, BaseReferences<_$BucketsDatabase, $BillsTable, BillRow>),
      BillRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsRowsTableCreateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      required String timeZone,
      required int quietStartMinutes,
      required int quietEndMinutes,
      required int snoozeLimit,
      required int coolingOffThreshold,
      required int coolingOffHours,
      required int checkInDay,
      required int checkInMinutes,
      required bool appLock,
      Value<LockTimeout> lockTimeout,
      Value<bool> hideAmounts,
      Value<bool> billReminders,
      required bool autoFile,
      required BucketKind goalShareFallback,
      Value<DateTime?> setupCompletedAt,
    });
typedef $$SettingsRowsTableUpdateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      Value<String> timeZone,
      Value<int> quietStartMinutes,
      Value<int> quietEndMinutes,
      Value<int> snoozeLimit,
      Value<int> coolingOffThreshold,
      Value<int> coolingOffHours,
      Value<int> checkInDay,
      Value<int> checkInMinutes,
      Value<bool> appLock,
      Value<LockTimeout> lockTimeout,
      Value<bool> hideAmounts,
      Value<bool> billReminders,
      Value<bool> autoFile,
      Value<BucketKind> goalShareFallback,
      Value<DateTime?> setupCompletedAt,
    });

class $$SettingsRowsTableFilterComposer
    extends Composer<_$BucketsDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quietStartMinutes => $composableBuilder(
    column: $table.quietStartMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quietEndMinutes => $composableBuilder(
    column: $table.quietEndMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeLimit => $composableBuilder(
    column: $table.snoozeLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coolingOffThreshold => $composableBuilder(
    column: $table.coolingOffThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coolingOffHours => $composableBuilder(
    column: $table.coolingOffHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkInDay => $composableBuilder(
    column: $table.checkInDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkInMinutes => $composableBuilder(
    column: $table.checkInMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get appLock => $composableBuilder(
    column: $table.appLock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LockTimeout, LockTimeout, String>
  get lockTimeout => $composableBuilder(
    column: $table.lockTimeout,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get billReminders => $composableBuilder(
    column: $table.billReminders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoFile => $composableBuilder(
    column: $table.autoFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BucketKind, BucketKind, String>
  get goalShareFallback => $composableBuilder(
    column: $table.goalShareFallback,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get setupCompletedAt => $composableBuilder(
    column: $table.setupCompletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsRowsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quietStartMinutes => $composableBuilder(
    column: $table.quietStartMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quietEndMinutes => $composableBuilder(
    column: $table.quietEndMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeLimit => $composableBuilder(
    column: $table.snoozeLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coolingOffThreshold => $composableBuilder(
    column: $table.coolingOffThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coolingOffHours => $composableBuilder(
    column: $table.coolingOffHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkInDay => $composableBuilder(
    column: $table.checkInDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkInMinutes => $composableBuilder(
    column: $table.checkInMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get appLock => $composableBuilder(
    column: $table.appLock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lockTimeout => $composableBuilder(
    column: $table.lockTimeout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get billReminders => $composableBuilder(
    column: $table.billReminders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoFile => $composableBuilder(
    column: $table.autoFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalShareFallback => $composableBuilder(
    column: $table.goalShareFallback,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get setupCompletedAt => $composableBuilder(
    column: $table.setupCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsRowsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get timeZone =>
      $composableBuilder(column: $table.timeZone, builder: (column) => column);

  GeneratedColumn<int> get quietStartMinutes => $composableBuilder(
    column: $table.quietStartMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quietEndMinutes => $composableBuilder(
    column: $table.quietEndMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get snoozeLimit => $composableBuilder(
    column: $table.snoozeLimit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get coolingOffThreshold => $composableBuilder(
    column: $table.coolingOffThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<int> get coolingOffHours => $composableBuilder(
    column: $table.coolingOffHours,
    builder: (column) => column,
  );

  GeneratedColumn<int> get checkInDay => $composableBuilder(
    column: $table.checkInDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get checkInMinutes => $composableBuilder(
    column: $table.checkInMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get appLock =>
      $composableBuilder(column: $table.appLock, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LockTimeout, String> get lockTimeout =>
      $composableBuilder(
        column: $table.lockTimeout,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get billReminders => $composableBuilder(
    column: $table.billReminders,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoFile =>
      $composableBuilder(column: $table.autoFile, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BucketKind, String> get goalShareFallback =>
      $composableBuilder(
        column: $table.goalShareFallback,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get setupCompletedAt => $composableBuilder(
    column: $table.setupCompletedAt,
    builder: (column) => column,
  );
}

class $$SettingsRowsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $SettingsRowsTable,
          SettingsRow,
          $$SettingsRowsTableFilterComposer,
          $$SettingsRowsTableOrderingComposer,
          $$SettingsRowsTableAnnotationComposer,
          $$SettingsRowsTableCreateCompanionBuilder,
          $$SettingsRowsTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<_$BucketsDatabase, $SettingsRowsTable, SettingsRow>,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$SettingsRowsTableTableManager(
    _$BucketsDatabase db,
    $SettingsRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> timeZone = const Value.absent(),
                Value<int> quietStartMinutes = const Value.absent(),
                Value<int> quietEndMinutes = const Value.absent(),
                Value<int> snoozeLimit = const Value.absent(),
                Value<int> coolingOffThreshold = const Value.absent(),
                Value<int> coolingOffHours = const Value.absent(),
                Value<int> checkInDay = const Value.absent(),
                Value<int> checkInMinutes = const Value.absent(),
                Value<bool> appLock = const Value.absent(),
                Value<LockTimeout> lockTimeout = const Value.absent(),
                Value<bool> hideAmounts = const Value.absent(),
                Value<bool> billReminders = const Value.absent(),
                Value<bool> autoFile = const Value.absent(),
                Value<BucketKind> goalShareFallback = const Value.absent(),
                Value<DateTime?> setupCompletedAt = const Value.absent(),
              }) => SettingsRowsCompanion(
                id: id,
                timeZone: timeZone,
                quietStartMinutes: quietStartMinutes,
                quietEndMinutes: quietEndMinutes,
                snoozeLimit: snoozeLimit,
                coolingOffThreshold: coolingOffThreshold,
                coolingOffHours: coolingOffHours,
                checkInDay: checkInDay,
                checkInMinutes: checkInMinutes,
                appLock: appLock,
                lockTimeout: lockTimeout,
                hideAmounts: hideAmounts,
                billReminders: billReminders,
                autoFile: autoFile,
                goalShareFallback: goalShareFallback,
                setupCompletedAt: setupCompletedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String timeZone,
                required int quietStartMinutes,
                required int quietEndMinutes,
                required int snoozeLimit,
                required int coolingOffThreshold,
                required int coolingOffHours,
                required int checkInDay,
                required int checkInMinutes,
                required bool appLock,
                Value<LockTimeout> lockTimeout = const Value.absent(),
                Value<bool> hideAmounts = const Value.absent(),
                Value<bool> billReminders = const Value.absent(),
                required bool autoFile,
                required BucketKind goalShareFallback,
                Value<DateTime?> setupCompletedAt = const Value.absent(),
              }) => SettingsRowsCompanion.insert(
                id: id,
                timeZone: timeZone,
                quietStartMinutes: quietStartMinutes,
                quietEndMinutes: quietEndMinutes,
                snoozeLimit: snoozeLimit,
                coolingOffThreshold: coolingOffThreshold,
                coolingOffHours: coolingOffHours,
                checkInDay: checkInDay,
                checkInMinutes: checkInMinutes,
                appLock: appLock,
                lockTimeout: lockTimeout,
                hideAmounts: hideAmounts,
                billReminders: billReminders,
                autoFile: autoFile,
                goalShareFallback: goalShareFallback,
                setupCompletedAt: setupCompletedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsRowsTable, SettingsRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $SettingsRowsTable,
                    SettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $SettingsRowsTable,
      SettingsRow,
      $$SettingsRowsTableFilterComposer,
      $$SettingsRowsTableOrderingComposer,
      $$SettingsRowsTableAnnotationComposer,
      $$SettingsRowsTableCreateCompanionBuilder,
      $$SettingsRowsTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$BucketsDatabase, $SettingsRowsTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;
typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<String?> displayName,
  required Greeting greeting,
  required String timeZone,
  required DateTime createdAt,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<String?> displayName,
  Value<Greeting> greeting,
  Value<String> timeZone,
  Value<DateTime> createdAt,
});

class $$ProfilesTableFilterComposer
    extends Composer<_$BucketsDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Greeting, Greeting, String> get greeting =>
      $composableBuilder(
        column: $table.greeting,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get greeting => $composableBuilder(
    column: $table.greeting,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Greeting, String> get greeting =>
      $composableBuilder(column: $table.greeting, builder: (column) => column);

  GeneratedColumn<String> get timeZone =>
      $composableBuilder(column: $table.timeZone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $ProfilesTable,
          ProfileRow,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (
            ProfileRow,
            BaseReferences<_$BucketsDatabase, $ProfilesTable, ProfileRow>,
          ),
          ProfileRow,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$BucketsDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<Greeting> greeting = const Value.absent(),
                Value<String> timeZone = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                displayName: displayName,
                greeting: greeting,
                timeZone: timeZone,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                required Greeting greeting,
                required String timeZone,
                required DateTime createdAt,
              }) => ProfilesCompanion.insert(
                id: id,
                displayName: displayName,
                greeting: greeting,
                timeZone: timeZone,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfilesTable, ProfileRow>(table),
                  BaseReferences<_$BucketsDatabase, $ProfilesTable, ProfileRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $ProfilesTable,
      ProfileRow,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (
        ProfileRow,
        BaseReferences<_$BucketsDatabase, $ProfilesTable, ProfileRow>,
      ),
      ProfileRow,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String name,
  Value<bool> isDefault,
  Value<bool> archived,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> name,
  Value<bool> isDefault,
  Value<bool> archived,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$BucketsDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (
            CategoryRow,
            BaseReferences<_$BucketsDatabase, $CategoriesTable, CategoryRow>,
          ),
          CategoryRow,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$BucketsDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                name: name,
                isDefault: isDefault,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String name,
                Value<bool> isDefault = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                name: name,
                isDefault: isDefault,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, CategoryRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $CategoriesTable,
                    CategoryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (
        CategoryRow,
        BaseReferences<_$BucketsDatabase, $CategoriesTable, CategoryRow>,
      ),
      CategoryRow,
      PrefetchHooks Function()
    >;
typedef $$HelpFeedbacksTableCreateCompanionBuilder =
    HelpFeedbacksCompanion Function({
      required String articleId,
      required bool helpful,
      Value<int> rowid,
    });
typedef $$HelpFeedbacksTableUpdateCompanionBuilder =
    HelpFeedbacksCompanion Function({
      Value<String> articleId,
      Value<bool> helpful,
      Value<int> rowid,
    });

class $$HelpFeedbacksTableFilterComposer
    extends Composer<_$BucketsDatabase, $HelpFeedbacksTable> {
  $$HelpFeedbacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get helpful => $composableBuilder(
    column: $table.helpful,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HelpFeedbacksTableOrderingComposer
    extends Composer<_$BucketsDatabase, $HelpFeedbacksTable> {
  $$HelpFeedbacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get articleId => $composableBuilder(
    column: $table.articleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get helpful => $composableBuilder(
    column: $table.helpful,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HelpFeedbacksTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $HelpFeedbacksTable> {
  $$HelpFeedbacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get articleId =>
      $composableBuilder(column: $table.articleId, builder: (column) => column);

  GeneratedColumn<bool> get helpful =>
      $composableBuilder(column: $table.helpful, builder: (column) => column);
}

class $$HelpFeedbacksTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $HelpFeedbacksTable,
          HelpFeedbackRow,
          $$HelpFeedbacksTableFilterComposer,
          $$HelpFeedbacksTableOrderingComposer,
          $$HelpFeedbacksTableAnnotationComposer,
          $$HelpFeedbacksTableCreateCompanionBuilder,
          $$HelpFeedbacksTableUpdateCompanionBuilder,
          (
            HelpFeedbackRow,
            BaseReferences<
              _$BucketsDatabase,
              $HelpFeedbacksTable,
              HelpFeedbackRow
            >,
          ),
          HelpFeedbackRow,
          PrefetchHooks Function()
        > {
  $$HelpFeedbacksTableTableManager(
    _$BucketsDatabase db,
    $HelpFeedbacksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HelpFeedbacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HelpFeedbacksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HelpFeedbacksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> articleId = const Value.absent(),
                Value<bool> helpful = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HelpFeedbacksCompanion(
                articleId: articleId,
                helpful: helpful,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String articleId,
                required bool helpful,
                Value<int> rowid = const Value.absent(),
              }) => HelpFeedbacksCompanion.insert(
                articleId: articleId,
                helpful: helpful,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HelpFeedbacksTable, HelpFeedbackRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $HelpFeedbacksTable,
                    HelpFeedbackRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HelpFeedbacksTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $HelpFeedbacksTable,
      HelpFeedbackRow,
      $$HelpFeedbacksTableFilterComposer,
      $$HelpFeedbacksTableOrderingComposer,
      $$HelpFeedbacksTableAnnotationComposer,
      $$HelpFeedbacksTableCreateCompanionBuilder,
      $$HelpFeedbacksTableUpdateCompanionBuilder,
      (
        HelpFeedbackRow,
        BaseReferences<_$BucketsDatabase, $HelpFeedbacksTable, HelpFeedbackRow>,
      ),
      HelpFeedbackRow,
      PrefetchHooks Function()
    >;
typedef $$LedgerEntriesTableCreateCompanionBuilder =
    LedgerEntriesCompanion Function({
      required String id,
      required DateTime occurredAt,
      required LedgerEntryKind kind,
      required String bucketId,
      required int amount,
      Value<String?> counterBucketId,
      Value<String?> paydayId,
      Value<String?> transferId,
      Value<String?> alertId,
      Value<String?> transactionId,
      Value<String?> receiptId,
      Value<String?> billId,
      Value<String?> carryOverId,
      Value<String?> note,
      Value<String?> reversesEntryId,
      Value<int> rowid,
    });
typedef $$LedgerEntriesTableUpdateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> occurredAt,
      Value<LedgerEntryKind> kind,
      Value<String> bucketId,
      Value<int> amount,
      Value<String?> counterBucketId,
      Value<String?> paydayId,
      Value<String?> transferId,
      Value<String?> alertId,
      Value<String?> transactionId,
      Value<String?> receiptId,
      Value<String?> billId,
      Value<String?> carryOverId,
      Value<String?> note,
      Value<String?> reversesEntryId,
      Value<int> rowid,
    });

class $$LedgerEntriesTableFilterComposer
    extends Composer<_$BucketsDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LedgerEntryKind, LedgerEntryKind, String>
  get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get counterBucketId => $composableBuilder(
    column: $table.counterBucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paydayId => $composableBuilder(
    column: $table.paydayId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferId => $composableBuilder(
    column: $table.transferId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptId => $composableBuilder(
    column: $table.receiptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carryOverId => $composableBuilder(
    column: $table.carryOverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reversesEntryId => $composableBuilder(
    column: $table.reversesEntryId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LedgerEntriesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get counterBucketId => $composableBuilder(
    column: $table.counterBucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paydayId => $composableBuilder(
    column: $table.paydayId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferId => $composableBuilder(
    column: $table.transferId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptId => $composableBuilder(
    column: $table.receiptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carryOverId => $composableBuilder(
    column: $table.carryOverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reversesEntryId => $composableBuilder(
    column: $table.reversesEntryId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LedgerEntriesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LedgerEntryKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get counterBucketId => $composableBuilder(
    column: $table.counterBucketId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paydayId =>
      $composableBuilder(column: $table.paydayId, builder: (column) => column);

  GeneratedColumn<String> get transferId => $composableBuilder(
    column: $table.transferId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alertId =>
      $composableBuilder(column: $table.alertId, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptId =>
      $composableBuilder(column: $table.receiptId, builder: (column) => column);

  GeneratedColumn<String> get billId =>
      $composableBuilder(column: $table.billId, builder: (column) => column);

  GeneratedColumn<String> get carryOverId => $composableBuilder(
    column: $table.carryOverId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get reversesEntryId => $composableBuilder(
    column: $table.reversesEntryId,
    builder: (column) => column,
  );
}

class $$LedgerEntriesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $LedgerEntriesTable,
          LedgerEntryRow,
          $$LedgerEntriesTableFilterComposer,
          $$LedgerEntriesTableOrderingComposer,
          $$LedgerEntriesTableAnnotationComposer,
          $$LedgerEntriesTableCreateCompanionBuilder,
          $$LedgerEntriesTableUpdateCompanionBuilder,
          (
            LedgerEntryRow,
            BaseReferences<
              _$BucketsDatabase,
              $LedgerEntriesTable,
              LedgerEntryRow
            >,
          ),
          LedgerEntryRow,
          PrefetchHooks Function()
        > {
  $$LedgerEntriesTableTableManager(
    _$BucketsDatabase db,
    $LedgerEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LedgerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LedgerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LedgerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<LedgerEntryKind> kind = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String?> counterBucketId = const Value.absent(),
                Value<String?> paydayId = const Value.absent(),
                Value<String?> transferId = const Value.absent(),
                Value<String?> alertId = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<String?> receiptId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<String?> carryOverId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> reversesEntryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LedgerEntriesCompanion(
                id: id,
                occurredAt: occurredAt,
                kind: kind,
                bucketId: bucketId,
                amount: amount,
                counterBucketId: counterBucketId,
                paydayId: paydayId,
                transferId: transferId,
                alertId: alertId,
                transactionId: transactionId,
                receiptId: receiptId,
                billId: billId,
                carryOverId: carryOverId,
                note: note,
                reversesEntryId: reversesEntryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime occurredAt,
                required LedgerEntryKind kind,
                required String bucketId,
                required int amount,
                Value<String?> counterBucketId = const Value.absent(),
                Value<String?> paydayId = const Value.absent(),
                Value<String?> transferId = const Value.absent(),
                Value<String?> alertId = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<String?> receiptId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<String?> carryOverId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> reversesEntryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LedgerEntriesCompanion.insert(
                id: id,
                occurredAt: occurredAt,
                kind: kind,
                bucketId: bucketId,
                amount: amount,
                counterBucketId: counterBucketId,
                paydayId: paydayId,
                transferId: transferId,
                alertId: alertId,
                transactionId: transactionId,
                receiptId: receiptId,
                billId: billId,
                carryOverId: carryOverId,
                note: note,
                reversesEntryId: reversesEntryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LedgerEntriesTable, LedgerEntryRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $LedgerEntriesTable,
                    LedgerEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LedgerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $LedgerEntriesTable,
      LedgerEntryRow,
      $$LedgerEntriesTableFilterComposer,
      $$LedgerEntriesTableOrderingComposer,
      $$LedgerEntriesTableAnnotationComposer,
      $$LedgerEntriesTableCreateCompanionBuilder,
      $$LedgerEntriesTableUpdateCompanionBuilder,
      (
        LedgerEntryRow,
        BaseReferences<_$BucketsDatabase, $LedgerEntriesTable, LedgerEntryRow>,
      ),
      LedgerEntryRow,
      PrefetchHooks Function()
    >;
typedef $$PaydaysTableCreateCompanionBuilder = PaydaysCompanion Function({
  required String id,
  required String incomeSourceId,
  required int amount,
  required DateTime startedAt,
  required int snoozesUsed,
  required PaydayStatus status,
  Value<DateTime?> snoozedUntil,
  Value<int> rowid,
});
typedef $$PaydaysTableUpdateCompanionBuilder = PaydaysCompanion Function({
  Value<String> id,
  Value<String> incomeSourceId,
  Value<int> amount,
  Value<DateTime> startedAt,
  Value<int> snoozesUsed,
  Value<PaydayStatus> status,
  Value<DateTime?> snoozedUntil,
  Value<int> rowid,
});

final class $$PaydaysTableReferences
    extends BaseReferences<_$BucketsDatabase, $PaydaysTable, PaydayRow> {
  $$PaydaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransfersTable, List<TransferRow>>
  _transfersRefsTable(_$BucketsDatabase db) => MultiTypedResultKey.fromTable(
    db.transfers,
    aliasName: 'paydays__id__transfers__payday_id',
  );

  $$TransfersTableProcessedTableManager get transfersRefs {
    final manager = $$TransfersTableTableManager(
      $_db,
      $_db.transfers,
    ).filter((f) => f.paydayId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transfersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaydaysTableFilterComposer
    extends Composer<_$BucketsDatabase, $PaydaysTable> {
  $$PaydaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozesUsed => $composableBuilder(
    column: $table.snoozesUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PaydayStatus, PaydayStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transfersRefs(
    Expression<bool> Function($$TransfersTableFilterComposer f) f,
  ) {
    final $$TransfersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transfers,
      getReferencedColumn: (t) => t.paydayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransfersTableFilterComposer(
            $db: $db,
            $table: $db.transfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaydaysTableOrderingComposer
    extends Composer<_$BucketsDatabase, $PaydaysTable> {
  $$PaydaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozesUsed => $composableBuilder(
    column: $table.snoozesUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaydaysTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $PaydaysTable> {
  $$PaydaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get snoozesUsed => $composableBuilder(
    column: $table.snoozesUsed,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PaydayStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => column,
  );

  Expression<T> transfersRefs<T extends Object>(
    Expression<T> Function($$TransfersTableAnnotationComposer a) f,
  ) {
    final $$TransfersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transfers,
      getReferencedColumn: (t) => t.paydayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransfersTableAnnotationComposer(
            $db: $db,
            $table: $db.transfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaydaysTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $PaydaysTable,
          PaydayRow,
          $$PaydaysTableFilterComposer,
          $$PaydaysTableOrderingComposer,
          $$PaydaysTableAnnotationComposer,
          $$PaydaysTableCreateCompanionBuilder,
          $$PaydaysTableUpdateCompanionBuilder,
          (PaydayRow, $$PaydaysTableReferences),
          PaydayRow,
          PrefetchHooks Function({bool transfersRefs})
        > {
  $$PaydaysTableTableManager(_$BucketsDatabase db, $PaydaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaydaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaydaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaydaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> incomeSourceId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<int> snoozesUsed = const Value.absent(),
                Value<PaydayStatus> status = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaydaysCompanion(
                id: id,
                incomeSourceId: incomeSourceId,
                amount: amount,
                startedAt: startedAt,
                snoozesUsed: snoozesUsed,
                status: status,
                snoozedUntil: snoozedUntil,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String incomeSourceId,
                required int amount,
                required DateTime startedAt,
                required int snoozesUsed,
                required PaydayStatus status,
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaydaysCompanion.insert(
                id: id,
                incomeSourceId: incomeSourceId,
                amount: amount,
                startedAt: startedAt,
                snoozesUsed: snoozesUsed,
                status: status,
                snoozedUntil: snoozedUntil,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaydaysTable, PaydayRow>(table),
                  $$PaydaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transfersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transfersRefs) db.transfers],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transfersRefs)
                    await $_getPrefetchedDataByColumns<
                      PaydayRow,
                      $PaydaysTable,
                      TransferRow,
                      $TransfersTable
                    >(
                      currentTable: table,
                      referencedTable: $$PaydaysTableReferences
                          ._transfersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PaydaysTableReferences(db, table, p0).transfersRefs,
                      currentColumn: 'id',
                      referencedColumn: 'payday_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PaydaysTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $PaydaysTable,
      PaydayRow,
      $$PaydaysTableFilterComposer,
      $$PaydaysTableOrderingComposer,
      $$PaydaysTableAnnotationComposer,
      $$PaydaysTableCreateCompanionBuilder,
      $$PaydaysTableUpdateCompanionBuilder,
      (PaydayRow, $$PaydaysTableReferences),
      PaydayRow,
      PrefetchHooks Function({bool transfersRefs})
    >;
typedef $$TransfersTableCreateCompanionBuilder = TransfersCompanion Function({
  required String id,
  required String paydayId,
  required int position,
  required String bucketId,
  required String toAccountId,
  required int amount,
  required TransferStatus status,
  Value<int?> provenAmount,
  Value<int?> owedAmount,
  Value<DateTime?> provenAt,
  Value<int> rowid,
});
typedef $$TransfersTableUpdateCompanionBuilder = TransfersCompanion Function({
  Value<String> id,
  Value<String> paydayId,
  Value<int> position,
  Value<String> bucketId,
  Value<String> toAccountId,
  Value<int> amount,
  Value<TransferStatus> status,
  Value<int?> provenAmount,
  Value<int?> owedAmount,
  Value<DateTime?> provenAt,
  Value<int> rowid,
});

final class $$TransfersTableReferences
    extends BaseReferences<_$BucketsDatabase, $TransfersTable, TransferRow> {
  $$TransfersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PaydaysTable _paydayIdTable(_$BucketsDatabase db) =>
      db.paydays.createAlias('transfers__payday_id__paydays__id');

  $$PaydaysTableProcessedTableManager get paydayId {
    final $_column = $_itemColumn<String>('payday_id')!;

    final manager = $$PaydaysTableTableManager(
      $_db,
      $_db.paydays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paydayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransferProofRefsTable, List<TransferProofRefRow>>
  _transferProofRefsRefsTable(_$BucketsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transferProofRefs,
        aliasName: 'transfers__id__transfer_proof_refs__transfer_id',
      );

  $$TransferProofRefsTableProcessedTableManager get transferProofRefsRefs {
    final manager = $$TransferProofRefsTableTableManager(
      $_db,
      $_db.transferProofRefs,
    ).filter((f) => f.transferId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transferProofRefsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransfersTableFilterComposer
    extends Composer<_$BucketsDatabase, $TransfersTable> {
  $$TransfersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toAccountId => $composableBuilder(
    column: $table.toAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransferStatus, TransferStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get provenAmount => $composableBuilder(
    column: $table.provenAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get owedAmount => $composableBuilder(
    column: $table.owedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get provenAt => $composableBuilder(
    column: $table.provenAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PaydaysTableFilterComposer get paydayId {
    final $$PaydaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paydayId,
      referencedTable: $db.paydays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaydaysTableFilterComposer(
            $db: $db,
            $table: $db.paydays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transferProofRefsRefs(
    Expression<bool> Function($$TransferProofRefsTableFilterComposer f) f,
  ) {
    final $$TransferProofRefsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transferProofRefs,
      getReferencedColumn: (t) => t.transferId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransferProofRefsTableFilterComposer(
            $db: $db,
            $table: $db.transferProofRefs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransfersTableOrderingComposer
    extends Composer<_$BucketsDatabase, $TransfersTable> {
  $$TransfersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toAccountId => $composableBuilder(
    column: $table.toAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get provenAmount => $composableBuilder(
    column: $table.provenAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get owedAmount => $composableBuilder(
    column: $table.owedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get provenAt => $composableBuilder(
    column: $table.provenAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaydaysTableOrderingComposer get paydayId {
    final $$PaydaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paydayId,
      referencedTable: $db.paydays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaydaysTableOrderingComposer(
            $db: $db,
            $table: $db.paydays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransfersTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $TransfersTable> {
  $$TransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<String> get toAccountId => $composableBuilder(
    column: $table.toAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransferStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get provenAmount => $composableBuilder(
    column: $table.provenAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get owedAmount => $composableBuilder(
    column: $table.owedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get provenAt =>
      $composableBuilder(column: $table.provenAt, builder: (column) => column);

  $$PaydaysTableAnnotationComposer get paydayId {
    final $$PaydaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paydayId,
      referencedTable: $db.paydays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaydaysTableAnnotationComposer(
            $db: $db,
            $table: $db.paydays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transferProofRefsRefs<T extends Object>(
    Expression<T> Function($$TransferProofRefsTableAnnotationComposer a) f,
  ) {
    final $$TransferProofRefsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transferProofRefs,
          getReferencedColumn: (t) => t.transferId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransferProofRefsTableAnnotationComposer(
                $db: $db,
                $table: $db.transferProofRefs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TransfersTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $TransfersTable,
          TransferRow,
          $$TransfersTableFilterComposer,
          $$TransfersTableOrderingComposer,
          $$TransfersTableAnnotationComposer,
          $$TransfersTableCreateCompanionBuilder,
          $$TransfersTableUpdateCompanionBuilder,
          (TransferRow, $$TransfersTableReferences),
          TransferRow,
          PrefetchHooks Function({bool paydayId, bool transferProofRefsRefs})
        > {
  $$TransfersTableTableManager(_$BucketsDatabase db, $TransfersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> paydayId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<String> toAccountId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<TransferStatus> status = const Value.absent(),
                Value<int?> provenAmount = const Value.absent(),
                Value<int?> owedAmount = const Value.absent(),
                Value<DateTime?> provenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransfersCompanion(
                id: id,
                paydayId: paydayId,
                position: position,
                bucketId: bucketId,
                toAccountId: toAccountId,
                amount: amount,
                status: status,
                provenAmount: provenAmount,
                owedAmount: owedAmount,
                provenAt: provenAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String paydayId,
                required int position,
                required String bucketId,
                required String toAccountId,
                required int amount,
                required TransferStatus status,
                Value<int?> provenAmount = const Value.absent(),
                Value<int?> owedAmount = const Value.absent(),
                Value<DateTime?> provenAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransfersCompanion.insert(
                id: id,
                paydayId: paydayId,
                position: position,
                bucketId: bucketId,
                toAccountId: toAccountId,
                amount: amount,
                status: status,
                provenAmount: provenAmount,
                owedAmount: owedAmount,
                provenAt: provenAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransfersTable, TransferRow>(table),
                  $$TransfersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({paydayId = false, transferProofRefsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transferProofRefsRefs) db.transferProofRefs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (paydayId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.paydayId,
                            referencedTable: $$TransfersTableReferences
                                ._paydayIdTable(db),
                            referencedColumn: $$TransfersTableReferences
                                ._paydayIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transferProofRefsRefs)
                        await $_getPrefetchedDataByColumns<
                          TransferRow,
                          $TransfersTable,
                          TransferProofRefRow,
                          $TransferProofRefsTable
                        >(
                          currentTable: table,
                          referencedTable: $$TransfersTableReferences
                              ._transferProofRefsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransfersTableReferences(
                                db,
                                table,
                                p0,
                              ).transferProofRefsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'transfer_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $TransfersTable,
      TransferRow,
      $$TransfersTableFilterComposer,
      $$TransfersTableOrderingComposer,
      $$TransfersTableAnnotationComposer,
      $$TransfersTableCreateCompanionBuilder,
      $$TransfersTableUpdateCompanionBuilder,
      (TransferRow, $$TransfersTableReferences),
      TransferRow,
      PrefetchHooks Function({bool paydayId, bool transferProofRefsRefs})
    >;
typedef $$TransferProofRefsTableCreateCompanionBuilder =
    TransferProofRefsCompanion Function({
      required String transferId,
      required int position,
      required String reference,
      Value<int> rowid,
    });
typedef $$TransferProofRefsTableUpdateCompanionBuilder =
    TransferProofRefsCompanion Function({
      Value<String> transferId,
      Value<int> position,
      Value<String> reference,
      Value<int> rowid,
    });

final class $$TransferProofRefsTableReferences
    extends
        BaseReferences<
          _$BucketsDatabase,
          $TransferProofRefsTable,
          TransferProofRefRow
        > {
  $$TransferProofRefsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransfersTable _transferIdTable(_$BucketsDatabase db) => db.transfers
      .createAlias('transfer_proof_refs__transfer_id__transfers__id');

  $$TransfersTableProcessedTableManager get transferId {
    final $_column = $_itemColumn<String>('transfer_id')!;

    final manager = $$TransfersTableTableManager(
      $_db,
      $_db.transfers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transferIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransferProofRefsTableFilterComposer
    extends Composer<_$BucketsDatabase, $TransferProofRefsTable> {
  $$TransferProofRefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  $$TransfersTableFilterComposer get transferId {
    final $$TransfersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferId,
      referencedTable: $db.transfers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransfersTableFilterComposer(
            $db: $db,
            $table: $db.transfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferProofRefsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $TransferProofRefsTable> {
  $$TransferProofRefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransfersTableOrderingComposer get transferId {
    final $$TransfersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferId,
      referencedTable: $db.transfers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransfersTableOrderingComposer(
            $db: $db,
            $table: $db.transfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferProofRefsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $TransferProofRefsTable> {
  $$TransferProofRefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  $$TransfersTableAnnotationComposer get transferId {
    final $$TransfersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transferId,
      referencedTable: $db.transfers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransfersTableAnnotationComposer(
            $db: $db,
            $table: $db.transfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransferProofRefsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $TransferProofRefsTable,
          TransferProofRefRow,
          $$TransferProofRefsTableFilterComposer,
          $$TransferProofRefsTableOrderingComposer,
          $$TransferProofRefsTableAnnotationComposer,
          $$TransferProofRefsTableCreateCompanionBuilder,
          $$TransferProofRefsTableUpdateCompanionBuilder,
          (TransferProofRefRow, $$TransferProofRefsTableReferences),
          TransferProofRefRow,
          PrefetchHooks Function({bool transferId})
        > {
  $$TransferProofRefsTableTableManager(
    _$BucketsDatabase db,
    $TransferProofRefsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransferProofRefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransferProofRefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransferProofRefsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> transferId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransferProofRefsCompanion(
                transferId: transferId,
                position: position,
                reference: reference,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String transferId,
                required int position,
                required String reference,
                Value<int> rowid = const Value.absent(),
              }) => TransferProofRefsCompanion.insert(
                transferId: transferId,
                position: position,
                reference: reference,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransferProofRefsTable, TransferProofRefRow>(
                    table,
                  ),
                  $$TransferProofRefsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transferId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (transferId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.transferId,
                        referencedTable: $$TransferProofRefsTableReferences
                            ._transferIdTable(db),
                        referencedColumn: $$TransferProofRefsTableReferences
                            ._transferIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransferProofRefsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $TransferProofRefsTable,
      TransferProofRefRow,
      $$TransferProofRefsTableFilterComposer,
      $$TransferProofRefsTableOrderingComposer,
      $$TransferProofRefsTableAnnotationComposer,
      $$TransferProofRefsTableCreateCompanionBuilder,
      $$TransferProofRefsTableUpdateCompanionBuilder,
      (TransferProofRefRow, $$TransferProofRefsTableReferences),
      TransferProofRefRow,
      PrefetchHooks Function({bool transferId})
    >;
typedef $$HeldIncomesTableCreateCompanionBuilder =
    HeldIncomesCompanion Function({
      required String id,
      required String incomeSourceId,
      required int amount,
      required DateTime receivedAt,
      Value<String?> alertId,
      Value<int> rowid,
    });
typedef $$HeldIncomesTableUpdateCompanionBuilder =
    HeldIncomesCompanion Function({
      Value<String> id,
      Value<String> incomeSourceId,
      Value<int> amount,
      Value<DateTime> receivedAt,
      Value<String?> alertId,
      Value<int> rowid,
    });

class $$HeldIncomesTableFilterComposer
    extends Composer<_$BucketsDatabase, $HeldIncomesTable> {
  $$HeldIncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HeldIncomesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $HeldIncomesTable> {
  $$HeldIncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HeldIncomesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $HeldIncomesTable> {
  $$HeldIncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alertId =>
      $composableBuilder(column: $table.alertId, builder: (column) => column);
}

class $$HeldIncomesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $HeldIncomesTable,
          HeldIncomeRow,
          $$HeldIncomesTableFilterComposer,
          $$HeldIncomesTableOrderingComposer,
          $$HeldIncomesTableAnnotationComposer,
          $$HeldIncomesTableCreateCompanionBuilder,
          $$HeldIncomesTableUpdateCompanionBuilder,
          (
            HeldIncomeRow,
            BaseReferences<_$BucketsDatabase, $HeldIncomesTable, HeldIncomeRow>,
          ),
          HeldIncomeRow,
          PrefetchHooks Function()
        > {
  $$HeldIncomesTableTableManager(_$BucketsDatabase db, $HeldIncomesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HeldIncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HeldIncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HeldIncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> incomeSourceId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<String?> alertId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HeldIncomesCompanion(
                id: id,
                incomeSourceId: incomeSourceId,
                amount: amount,
                receivedAt: receivedAt,
                alertId: alertId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String incomeSourceId,
                required int amount,
                required DateTime receivedAt,
                Value<String?> alertId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HeldIncomesCompanion.insert(
                id: id,
                incomeSourceId: incomeSourceId,
                amount: amount,
                receivedAt: receivedAt,
                alertId: alertId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HeldIncomesTable, HeldIncomeRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $HeldIncomesTable,
                    HeldIncomeRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HeldIncomesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $HeldIncomesTable,
      HeldIncomeRow,
      $$HeldIncomesTableFilterComposer,
      $$HeldIncomesTableOrderingComposer,
      $$HeldIncomesTableAnnotationComposer,
      $$HeldIncomesTableCreateCompanionBuilder,
      $$HeldIncomesTableUpdateCompanionBuilder,
      (
        HeldIncomeRow,
        BaseReferences<_$BucketsDatabase, $HeldIncomesTable, HeldIncomeRow>,
      ),
      HeldIncomeRow,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String bucketId,
  required int target,
  Value<DateTime?> targetDate,
  Value<DateTime?> celebratedAt,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> bucketId,
  Value<int> target,
  Value<DateTime?> targetDate,
  Value<DateTime?> celebratedAt,
  Value<int> rowid,
});

class $$GoalsTableFilterComposer
    extends Composer<_$BucketsDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get celebratedAt => $composableBuilder(
    column: $table.celebratedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get celebratedAt => $composableBuilder(
    column: $table.celebratedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get celebratedAt => $composableBuilder(
    column: $table.celebratedAt,
    builder: (column) => column,
  );
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $GoalsTable,
          GoalRow,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (GoalRow, BaseReferences<_$BucketsDatabase, $GoalsTable, GoalRow>),
          GoalRow,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableManager(_$BucketsDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> bucketId = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<DateTime?> celebratedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                bucketId: bucketId,
                target: target,
                targetDate: targetDate,
                celebratedAt: celebratedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String bucketId,
                required int target,
                Value<DateTime?> targetDate = const Value.absent(),
                Value<DateTime?> celebratedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                bucketId: bucketId,
                target: target,
                targetDate: targetDate,
                celebratedAt: celebratedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalsTable, GoalRow>(table),
                  BaseReferences<_$BucketsDatabase, $GoalsTable, GoalRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $GoalsTable,
      GoalRow,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (GoalRow, BaseReferences<_$BucketsDatabase, $GoalsTable, GoalRow>),
      GoalRow,
      PrefetchHooks Function()
    >;
typedef $$CheckInsTableCreateCompanionBuilder = CheckInsCompanion Function({
  required String id,
  required DateTime countedAt,
  required int expectedCash,
  required int countedCash,
  Value<int> rowid,
});
typedef $$CheckInsTableUpdateCompanionBuilder = CheckInsCompanion Function({
  Value<String> id,
  Value<DateTime> countedAt,
  Value<int> expectedCash,
  Value<int> countedCash,
  Value<int> rowid,
});

class $$CheckInsTableFilterComposer
    extends Composer<_$BucketsDatabase, $CheckInsTable> {
  $$CheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get countedAt => $composableBuilder(
    column: $table.countedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get countedCash => $composableBuilder(
    column: $table.countedCash,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CheckInsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $CheckInsTable> {
  $$CheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get countedAt => $composableBuilder(
    column: $table.countedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get countedCash => $composableBuilder(
    column: $table.countedCash,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheckInsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $CheckInsTable> {
  $$CheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get countedAt =>
      $composableBuilder(column: $table.countedAt, builder: (column) => column);

  GeneratedColumn<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get countedCash => $composableBuilder(
    column: $table.countedCash,
    builder: (column) => column,
  );
}

class $$CheckInsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $CheckInsTable,
          CheckInRow,
          $$CheckInsTableFilterComposer,
          $$CheckInsTableOrderingComposer,
          $$CheckInsTableAnnotationComposer,
          $$CheckInsTableCreateCompanionBuilder,
          $$CheckInsTableUpdateCompanionBuilder,
          (
            CheckInRow,
            BaseReferences<_$BucketsDatabase, $CheckInsTable, CheckInRow>,
          ),
          CheckInRow,
          PrefetchHooks Function()
        > {
  $$CheckInsTableTableManager(_$BucketsDatabase db, $CheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> countedAt = const Value.absent(),
                Value<int> expectedCash = const Value.absent(),
                Value<int> countedCash = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckInsCompanion(
                id: id,
                countedAt: countedAt,
                expectedCash: expectedCash,
                countedCash: countedCash,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime countedAt,
                required int expectedCash,
                required int countedCash,
                Value<int> rowid = const Value.absent(),
              }) => CheckInsCompanion.insert(
                id: id,
                countedAt: countedAt,
                expectedCash: expectedCash,
                countedCash: countedCash,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CheckInsTable, CheckInRow>(table),
                  BaseReferences<_$BucketsDatabase, $CheckInsTable, CheckInRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $CheckInsTable,
      CheckInRow,
      $$CheckInsTableFilterComposer,
      $$CheckInsTableOrderingComposer,
      $$CheckInsTableAnnotationComposer,
      $$CheckInsTableCreateCompanionBuilder,
      $$CheckInsTableUpdateCompanionBuilder,
      (
        CheckInRow,
        BaseReferences<_$BucketsDatabase, $CheckInsTable, CheckInRow>,
      ),
      CheckInRow,
      PrefetchHooks Function()
    >;
typedef $$PaymentAlertsTableCreateCompanionBuilder =
    PaymentAlertsCompanion Function({
      required String id,
      Value<String?> rawText,
      required AlertSource source,
      required DateTime receivedAt,
      required AlertStatus status,
      Value<MessageDirection?> direction,
      Value<int?> amount,
      Value<int?> fee,
      Value<String?> counterparty,
      Value<String?> reference,
      Value<DateTime?> occurredAt,
      Value<int?> balanceAfter,
      required double confidence,
      required bool isWithdrawal,
      Value<int> rowid,
    });
typedef $$PaymentAlertsTableUpdateCompanionBuilder =
    PaymentAlertsCompanion Function({
      Value<String> id,
      Value<String?> rawText,
      Value<AlertSource> source,
      Value<DateTime> receivedAt,
      Value<AlertStatus> status,
      Value<MessageDirection?> direction,
      Value<int?> amount,
      Value<int?> fee,
      Value<String?> counterparty,
      Value<String?> reference,
      Value<DateTime?> occurredAt,
      Value<int?> balanceAfter,
      Value<double> confidence,
      Value<bool> isWithdrawal,
      Value<int> rowid,
    });

class $$PaymentAlertsTableFilterComposer
    extends Composer<_$BucketsDatabase, $PaymentAlertsTable> {
  $$PaymentAlertsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AlertSource, AlertSource, String> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AlertStatus, AlertStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<MessageDirection?, MessageDirection, String>
  get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fee => $composableBuilder(
    column: $table.fee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isWithdrawal => $composableBuilder(
    column: $table.isWithdrawal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentAlertsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $PaymentAlertsTable> {
  $$PaymentAlertsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fee => $composableBuilder(
    column: $table.fee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isWithdrawal => $composableBuilder(
    column: $table.isWithdrawal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentAlertsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $PaymentAlertsTable> {
  $$PaymentAlertsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AlertSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AlertStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MessageDirection?, String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get fee =>
      $composableBuilder(column: $table.fee, builder: (column) => column);

  GeneratedColumn<String> get counterparty => $composableBuilder(
    column: $table.counterparty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isWithdrawal => $composableBuilder(
    column: $table.isWithdrawal,
    builder: (column) => column,
  );
}

class $$PaymentAlertsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $PaymentAlertsTable,
          PaymentAlertRow,
          $$PaymentAlertsTableFilterComposer,
          $$PaymentAlertsTableOrderingComposer,
          $$PaymentAlertsTableAnnotationComposer,
          $$PaymentAlertsTableCreateCompanionBuilder,
          $$PaymentAlertsTableUpdateCompanionBuilder,
          (
            PaymentAlertRow,
            BaseReferences<
              _$BucketsDatabase,
              $PaymentAlertsTable,
              PaymentAlertRow
            >,
          ),
          PaymentAlertRow,
          PrefetchHooks Function()
        > {
  $$PaymentAlertsTableTableManager(
    _$BucketsDatabase db,
    $PaymentAlertsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentAlertsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentAlertsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentAlertsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> rawText = const Value.absent(),
                Value<AlertSource> source = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
                Value<AlertStatus> status = const Value.absent(),
                Value<MessageDirection?> direction = const Value.absent(),
                Value<int?> amount = const Value.absent(),
                Value<int?> fee = const Value.absent(),
                Value<String?> counterparty = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<DateTime?> occurredAt = const Value.absent(),
                Value<int?> balanceAfter = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<bool> isWithdrawal = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentAlertsCompanion(
                id: id,
                rawText: rawText,
                source: source,
                receivedAt: receivedAt,
                status: status,
                direction: direction,
                amount: amount,
                fee: fee,
                counterparty: counterparty,
                reference: reference,
                occurredAt: occurredAt,
                balanceAfter: balanceAfter,
                confidence: confidence,
                isWithdrawal: isWithdrawal,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> rawText = const Value.absent(),
                required AlertSource source,
                required DateTime receivedAt,
                required AlertStatus status,
                Value<MessageDirection?> direction = const Value.absent(),
                Value<int?> amount = const Value.absent(),
                Value<int?> fee = const Value.absent(),
                Value<String?> counterparty = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<DateTime?> occurredAt = const Value.absent(),
                Value<int?> balanceAfter = const Value.absent(),
                required double confidence,
                required bool isWithdrawal,
                Value<int> rowid = const Value.absent(),
              }) => PaymentAlertsCompanion.insert(
                id: id,
                rawText: rawText,
                source: source,
                receivedAt: receivedAt,
                status: status,
                direction: direction,
                amount: amount,
                fee: fee,
                counterparty: counterparty,
                reference: reference,
                occurredAt: occurredAt,
                balanceAfter: balanceAfter,
                confidence: confidence,
                isWithdrawal: isWithdrawal,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentAlertsTable, PaymentAlertRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $PaymentAlertsTable,
                    PaymentAlertRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentAlertsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $PaymentAlertsTable,
      PaymentAlertRow,
      $$PaymentAlertsTableFilterComposer,
      $$PaymentAlertsTableOrderingComposer,
      $$PaymentAlertsTableAnnotationComposer,
      $$PaymentAlertsTableCreateCompanionBuilder,
      $$PaymentAlertsTableUpdateCompanionBuilder,
      (
        PaymentAlertRow,
        BaseReferences<_$BucketsDatabase, $PaymentAlertsTable, PaymentAlertRow>,
      ),
      PaymentAlertRow,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required int amount,
      required String bucketId,
      required String category,
      required String accountId,
      required DateTime occurredAt,
      required TransactionSource source,
      Value<String?> note,
      Value<String?> alertId,
      Value<String?> receiptId,
      Value<String?> billId,
      Value<FeeType?> feeType,
      Value<AlertSource?> provider,
      Value<FeeSource?> feeSource,
      Value<String?> parentTransactionId,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<int> amount,
      Value<String> bucketId,
      Value<String> category,
      Value<String> accountId,
      Value<DateTime> occurredAt,
      Value<TransactionSource> source,
      Value<String?> note,
      Value<String?> alertId,
      Value<String?> receiptId,
      Value<String?> billId,
      Value<FeeType?> feeType,
      Value<AlertSource?> provider,
      Value<FeeSource?> feeSource,
      Value<String?> parentTransactionId,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends
        BaseReferences<_$BucketsDatabase, $TransactionsTable, TransactionRow> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionLinesTable, List<TransactionLineRow>>
  _transactionLinesRefsTable(_$BucketsDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionLines,
        aliasName: 'transactions__id__transaction_lines__transaction_id',
      );

  $$TransactionLinesTableProcessedTableManager get transactionLinesRefs {
    final manager = $$TransactionLinesTableTableManager(
      $_db,
      $_db.transactionLines,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionLinesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$BucketsDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionSource, TransactionSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptId => $composableBuilder(
    column: $table.receiptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FeeType?, FeeType, String> get feeType =>
      $composableBuilder(
        column: $table.feeType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<AlertSource?, AlertSource, String>
  get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<FeeSource?, FeeSource, String> get feeSource =>
      $composableBuilder(
        column: $table.feeSource,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionLinesRefs(
    Expression<bool> Function($$TransactionLinesTableFilterComposer f) f,
  ) {
    final $$TransactionLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionLines,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionLinesTableFilterComposer(
            $db: $db,
            $table: $db.transactionLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptId => $composableBuilder(
    column: $table.receiptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feeType => $composableBuilder(
    column: $table.feeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feeSource => $composableBuilder(
    column: $table.feeSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TransactionSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get alertId =>
      $composableBuilder(column: $table.alertId, builder: (column) => column);

  GeneratedColumn<String> get receiptId =>
      $composableBuilder(column: $table.receiptId, builder: (column) => column);

  GeneratedColumn<String> get billId =>
      $composableBuilder(column: $table.billId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeeType?, String> get feeType =>
      $composableBuilder(column: $table.feeType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AlertSource?, String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeeSource?, String> get feeSource =>
      $composableBuilder(column: $table.feeSource, builder: (column) => column);

  GeneratedColumn<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => column,
  );

  Expression<T> transactionLinesRefs<T extends Object>(
    Expression<T> Function($$TransactionLinesTableAnnotationComposer a) f,
  ) {
    final $$TransactionLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionLines,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.transactionLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (TransactionRow, $$TransactionsTableReferences),
          TransactionRow,
          PrefetchHooks Function({bool transactionLinesRefs})
        > {
  $$TransactionsTableTableManager(
    _$BucketsDatabase db,
    $TransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<TransactionSource> source = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> alertId = const Value.absent(),
                Value<String?> receiptId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<FeeType?> feeType = const Value.absent(),
                Value<AlertSource?> provider = const Value.absent(),
                Value<FeeSource?> feeSource = const Value.absent(),
                Value<String?> parentTransactionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                amount: amount,
                bucketId: bucketId,
                category: category,
                accountId: accountId,
                occurredAt: occurredAt,
                source: source,
                note: note,
                alertId: alertId,
                receiptId: receiptId,
                billId: billId,
                feeType: feeType,
                provider: provider,
                feeSource: feeSource,
                parentTransactionId: parentTransactionId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int amount,
                required String bucketId,
                required String category,
                required String accountId,
                required DateTime occurredAt,
                required TransactionSource source,
                Value<String?> note = const Value.absent(),
                Value<String?> alertId = const Value.absent(),
                Value<String?> receiptId = const Value.absent(),
                Value<String?> billId = const Value.absent(),
                Value<FeeType?> feeType = const Value.absent(),
                Value<AlertSource?> provider = const Value.absent(),
                Value<FeeSource?> feeSource = const Value.absent(),
                Value<String?> parentTransactionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                amount: amount,
                bucketId: bucketId,
                category: category,
                accountId: accountId,
                occurredAt: occurredAt,
                source: source,
                note: note,
                alertId: alertId,
                receiptId: receiptId,
                billId: billId,
                feeType: feeType,
                provider: provider,
                feeSource: feeSource,
                parentTransactionId: parentTransactionId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, TransactionRow>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionLinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionLinesRefs) db.transactionLines,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionLinesRefs)
                    await $_getPrefetchedDataByColumns<
                      TransactionRow,
                      $TransactionsTable,
                      TransactionLineRow,
                      $TransactionLinesTable
                    >(
                      currentTable: table,
                      referencedTable: $$TransactionsTableReferences
                          ._transactionLinesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TransactionsTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionLinesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'transaction_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (TransactionRow, $$TransactionsTableReferences),
      TransactionRow,
      PrefetchHooks Function({bool transactionLinesRefs})
    >;
typedef $$TransactionLinesTableCreateCompanionBuilder =
    TransactionLinesCompanion Function({
      required String transactionId,
      required int position,
      required String bucketId,
      required int amount,
      Value<int> rowid,
    });
typedef $$TransactionLinesTableUpdateCompanionBuilder =
    TransactionLinesCompanion Function({
      Value<String> transactionId,
      Value<int> position,
      Value<String> bucketId,
      Value<int> amount,
      Value<int> rowid,
    });

final class $$TransactionLinesTableReferences
    extends
        BaseReferences<
          _$BucketsDatabase,
          $TransactionLinesTable,
          TransactionLineRow
        > {
  $$TransactionLinesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransactionsTable _transactionIdTable(_$BucketsDatabase db) => db
      .transactions
      .createAlias('transaction_lines__transaction_id__transactions__id');

  $$TransactionsTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<String>('transaction_id')!;

    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionLinesTableFilterComposer
    extends Composer<_$BucketsDatabase, $TransactionLinesTable> {
  $$TransactionLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  $$TransactionsTableFilterComposer get transactionId {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionLinesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $TransactionLinesTable> {
  $$TransactionLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionsTableOrderingComposer get transactionId {
    final $$TransactionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableOrderingComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionLinesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $TransactionLinesTable> {
  $$TransactionLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$TransactionsTableAnnotationComposer get transactionId {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionLinesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $TransactionLinesTable,
          TransactionLineRow,
          $$TransactionLinesTableFilterComposer,
          $$TransactionLinesTableOrderingComposer,
          $$TransactionLinesTableAnnotationComposer,
          $$TransactionLinesTableCreateCompanionBuilder,
          $$TransactionLinesTableUpdateCompanionBuilder,
          (TransactionLineRow, $$TransactionLinesTableReferences),
          TransactionLineRow,
          PrefetchHooks Function({bool transactionId})
        > {
  $$TransactionLinesTableTableManager(
    _$BucketsDatabase db,
    $TransactionLinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> transactionId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionLinesCompanion(
                transactionId: transactionId,
                position: position,
                bucketId: bucketId,
                amount: amount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String transactionId,
                required int position,
                required String bucketId,
                required int amount,
                Value<int> rowid = const Value.absent(),
              }) => TransactionLinesCompanion.insert(
                transactionId: transactionId,
                position: position,
                bucketId: bucketId,
                amount: amount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionLinesTable, TransactionLineRow>(
                    table,
                  ),
                  $$TransactionLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (transactionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.transactionId,
                        referencedTable: $$TransactionLinesTableReferences
                            ._transactionIdTable(db),
                        referencedColumn: $$TransactionLinesTableReferences
                            ._transactionIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $TransactionLinesTable,
      TransactionLineRow,
      $$TransactionLinesTableFilterComposer,
      $$TransactionLinesTableOrderingComposer,
      $$TransactionLinesTableAnnotationComposer,
      $$TransactionLinesTableCreateCompanionBuilder,
      $$TransactionLinesTableUpdateCompanionBuilder,
      (TransactionLineRow, $$TransactionLinesTableReferences),
      TransactionLineRow,
      PrefetchHooks Function({bool transactionId})
    >;
typedef $$CashWithdrawalsTableCreateCompanionBuilder =
    CashWithdrawalsCompanion Function({
      required String id,
      required int amount,
      required String fromAccountId,
      required String cashAccountId,
      required DateTime occurredAt,
      Value<String?> alertId,
      Value<int> rowid,
    });
typedef $$CashWithdrawalsTableUpdateCompanionBuilder =
    CashWithdrawalsCompanion Function({
      Value<String> id,
      Value<int> amount,
      Value<String> fromAccountId,
      Value<String> cashAccountId,
      Value<DateTime> occurredAt,
      Value<String?> alertId,
      Value<int> rowid,
    });

class $$CashWithdrawalsTableFilterComposer
    extends Composer<_$BucketsDatabase, $CashWithdrawalsTable> {
  $$CashWithdrawalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromAccountId => $composableBuilder(
    column: $table.fromAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cashAccountId => $composableBuilder(
    column: $table.cashAccountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashWithdrawalsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $CashWithdrawalsTable> {
  $$CashWithdrawalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromAccountId => $composableBuilder(
    column: $table.fromAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cashAccountId => $composableBuilder(
    column: $table.cashAccountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alertId => $composableBuilder(
    column: $table.alertId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashWithdrawalsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $CashWithdrawalsTable> {
  $$CashWithdrawalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get fromAccountId => $composableBuilder(
    column: $table.fromAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cashAccountId => $composableBuilder(
    column: $table.cashAccountId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alertId =>
      $composableBuilder(column: $table.alertId, builder: (column) => column);
}

class $$CashWithdrawalsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $CashWithdrawalsTable,
          CashWithdrawalRow,
          $$CashWithdrawalsTableFilterComposer,
          $$CashWithdrawalsTableOrderingComposer,
          $$CashWithdrawalsTableAnnotationComposer,
          $$CashWithdrawalsTableCreateCompanionBuilder,
          $$CashWithdrawalsTableUpdateCompanionBuilder,
          (
            CashWithdrawalRow,
            BaseReferences<
              _$BucketsDatabase,
              $CashWithdrawalsTable,
              CashWithdrawalRow
            >,
          ),
          CashWithdrawalRow,
          PrefetchHooks Function()
        > {
  $$CashWithdrawalsTableTableManager(
    _$BucketsDatabase db,
    $CashWithdrawalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashWithdrawalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashWithdrawalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashWithdrawalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> fromAccountId = const Value.absent(),
                Value<String> cashAccountId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> alertId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashWithdrawalsCompanion(
                id: id,
                amount: amount,
                fromAccountId: fromAccountId,
                cashAccountId: cashAccountId,
                occurredAt: occurredAt,
                alertId: alertId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int amount,
                required String fromAccountId,
                required String cashAccountId,
                required DateTime occurredAt,
                Value<String?> alertId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashWithdrawalsCompanion.insert(
                id: id,
                amount: amount,
                fromAccountId: fromAccountId,
                cashAccountId: cashAccountId,
                occurredAt: occurredAt,
                alertId: alertId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CashWithdrawalsTable, CashWithdrawalRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $CashWithdrawalsTable,
                    CashWithdrawalRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashWithdrawalsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $CashWithdrawalsTable,
      CashWithdrawalRow,
      $$CashWithdrawalsTableFilterComposer,
      $$CashWithdrawalsTableOrderingComposer,
      $$CashWithdrawalsTableAnnotationComposer,
      $$CashWithdrawalsTableCreateCompanionBuilder,
      $$CashWithdrawalsTableUpdateCompanionBuilder,
      (
        CashWithdrawalRow,
        BaseReferences<
          _$BucketsDatabase,
          $CashWithdrawalsTable,
          CashWithdrawalRow
        >,
      ),
      CashWithdrawalRow,
      PrefetchHooks Function()
    >;
typedef $$MerchantRulesTableCreateCompanionBuilder =
    MerchantRulesCompanion Function({
      required String id,
      required String merchantKey,
      required String category,
      required String bucketId,
      Value<int> rowid,
    });
typedef $$MerchantRulesTableUpdateCompanionBuilder =
    MerchantRulesCompanion Function({
      Value<String> id,
      Value<String> merchantKey,
      Value<String> category,
      Value<String> bucketId,
      Value<int> rowid,
    });

class $$MerchantRulesTableFilterComposer
    extends Composer<_$BucketsDatabase, $MerchantRulesTable> {
  $$MerchantRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantKey => $composableBuilder(
    column: $table.merchantKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MerchantRulesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $MerchantRulesTable> {
  $$MerchantRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantKey => $composableBuilder(
    column: $table.merchantKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MerchantRulesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $MerchantRulesTable> {
  $$MerchantRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get merchantKey => $composableBuilder(
    column: $table.merchantKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);
}

class $$MerchantRulesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $MerchantRulesTable,
          MerchantRuleRow,
          $$MerchantRulesTableFilterComposer,
          $$MerchantRulesTableOrderingComposer,
          $$MerchantRulesTableAnnotationComposer,
          $$MerchantRulesTableCreateCompanionBuilder,
          $$MerchantRulesTableUpdateCompanionBuilder,
          (
            MerchantRuleRow,
            BaseReferences<
              _$BucketsDatabase,
              $MerchantRulesTable,
              MerchantRuleRow
            >,
          ),
          MerchantRuleRow,
          PrefetchHooks Function()
        > {
  $$MerchantRulesTableTableManager(
    _$BucketsDatabase db,
    $MerchantRulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MerchantRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MerchantRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MerchantRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> merchantKey = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantRulesCompanion(
                id: id,
                merchantKey: merchantKey,
                category: category,
                bucketId: bucketId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String merchantKey,
                required String category,
                required String bucketId,
                Value<int> rowid = const Value.absent(),
              }) => MerchantRulesCompanion.insert(
                id: id,
                merchantKey: merchantKey,
                category: category,
                bucketId: bucketId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MerchantRulesTable, MerchantRuleRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $MerchantRulesTable,
                    MerchantRuleRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MerchantRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $MerchantRulesTable,
      MerchantRuleRow,
      $$MerchantRulesTableFilterComposer,
      $$MerchantRulesTableOrderingComposer,
      $$MerchantRulesTableAnnotationComposer,
      $$MerchantRulesTableCreateCompanionBuilder,
      $$MerchantRulesTableUpdateCompanionBuilder,
      (
        MerchantRuleRow,
        BaseReferences<_$BucketsDatabase, $MerchantRulesTable, MerchantRuleRow>,
      ),
      MerchantRuleRow,
      PrefetchHooks Function()
    >;
typedef $$ReceiptsTableCreateCompanionBuilder = ReceiptsCompanion Function({
  required String id,
  required String imagePath,
  required String draftJson,
  Value<int> rowid,
});
typedef $$ReceiptsTableUpdateCompanionBuilder = ReceiptsCompanion Function({
  Value<String> id,
  Value<String> imagePath,
  Value<String> draftJson,
  Value<int> rowid,
});

class $$ReceiptsTableFilterComposer
    extends Composer<_$BucketsDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get draftJson => $composableBuilder(
    column: $table.draftJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get draftJson => $composableBuilder(
    column: $table.draftJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get draftJson =>
      $composableBuilder(column: $table.draftJson, builder: (column) => column);
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $ReceiptsTable,
          ReceiptRow,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (
            ReceiptRow,
            BaseReferences<_$BucketsDatabase, $ReceiptsTable, ReceiptRow>,
          ),
          ReceiptRow,
          PrefetchHooks Function()
        > {
  $$ReceiptsTableTableManager(_$BucketsDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> draftJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                imagePath: imagePath,
                draftJson: draftJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String imagePath,
                required String draftJson,
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                imagePath: imagePath,
                draftJson: draftJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReceiptsTable, ReceiptRow>(table),
                  BaseReferences<_$BucketsDatabase, $ReceiptsTable, ReceiptRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $ReceiptsTable,
      ReceiptRow,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (
        ReceiptRow,
        BaseReferences<_$BucketsDatabase, $ReceiptsTable, ReceiptRow>,
      ),
      ReceiptRow,
      PrefetchHooks Function()
    >;
typedef $$PlannedPurchasesTableCreateCompanionBuilder =
    PlannedPurchasesCompanion Function({
      required String id,
      required String name,
      required int amount,
      required String bucketId,
      Value<DateTime?> due,
      Value<int?> repeatEverySeconds,
      required bool done,
      Value<String?> transactionId,
      Value<int> rowid,
    });
typedef $$PlannedPurchasesTableUpdateCompanionBuilder =
    PlannedPurchasesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> amount,
      Value<String> bucketId,
      Value<DateTime?> due,
      Value<int?> repeatEverySeconds,
      Value<bool> done,
      Value<String?> transactionId,
      Value<int> rowid,
    });

class $$PlannedPurchasesTableFilterComposer
    extends Composer<_$BucketsDatabase, $PlannedPurchasesTable> {
  $$PlannedPurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatEverySeconds => $composableBuilder(
    column: $table.repeatEverySeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlannedPurchasesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $PlannedPurchasesTable> {
  $$PlannedPurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get due => $composableBuilder(
    column: $table.due,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatEverySeconds => $composableBuilder(
    column: $table.repeatEverySeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlannedPurchasesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $PlannedPurchasesTable> {
  $$PlannedPurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<DateTime> get due =>
      $composableBuilder(column: $table.due, builder: (column) => column);

  GeneratedColumn<int> get repeatEverySeconds => $composableBuilder(
    column: $table.repeatEverySeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );
}

class $$PlannedPurchasesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $PlannedPurchasesTable,
          PlannedPurchaseRow,
          $$PlannedPurchasesTableFilterComposer,
          $$PlannedPurchasesTableOrderingComposer,
          $$PlannedPurchasesTableAnnotationComposer,
          $$PlannedPurchasesTableCreateCompanionBuilder,
          $$PlannedPurchasesTableUpdateCompanionBuilder,
          (
            PlannedPurchaseRow,
            BaseReferences<
              _$BucketsDatabase,
              $PlannedPurchasesTable,
              PlannedPurchaseRow
            >,
          ),
          PlannedPurchaseRow,
          PrefetchHooks Function()
        > {
  $$PlannedPurchasesTableTableManager(
    _$BucketsDatabase db,
    $PlannedPurchasesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlannedPurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlannedPurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlannedPurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<DateTime?> due = const Value.absent(),
                Value<int?> repeatEverySeconds = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlannedPurchasesCompanion(
                id: id,
                name: name,
                amount: amount,
                bucketId: bucketId,
                due: due,
                repeatEverySeconds: repeatEverySeconds,
                done: done,
                transactionId: transactionId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int amount,
                required String bucketId,
                Value<DateTime?> due = const Value.absent(),
                Value<int?> repeatEverySeconds = const Value.absent(),
                required bool done,
                Value<String?> transactionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlannedPurchasesCompanion.insert(
                id: id,
                name: name,
                amount: amount,
                bucketId: bucketId,
                due: due,
                repeatEverySeconds: repeatEverySeconds,
                done: done,
                transactionId: transactionId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlannedPurchasesTable, PlannedPurchaseRow>(
                    table,
                  ),
                  BaseReferences<
                    _$BucketsDatabase,
                    $PlannedPurchasesTable,
                    PlannedPurchaseRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlannedPurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $PlannedPurchasesTable,
      PlannedPurchaseRow,
      $$PlannedPurchasesTableFilterComposer,
      $$PlannedPurchasesTableOrderingComposer,
      $$PlannedPurchasesTableAnnotationComposer,
      $$PlannedPurchasesTableCreateCompanionBuilder,
      $$PlannedPurchasesTableUpdateCompanionBuilder,
      (
        PlannedPurchaseRow,
        BaseReferences<
          _$BucketsDatabase,
          $PlannedPurchasesTable,
          PlannedPurchaseRow
        >,
      ),
      PlannedPurchaseRow,
      PrefetchHooks Function()
    >;
typedef $$WishesTableCreateCompanionBuilder = WishesCompanion Function({
  required String id,
  required String name,
  required int amount,
  required String bucketId,
  required DateTime createdAt,
  required DateTime endsAt,
  required WishStatus status,
  Value<int> rowid,
});
typedef $$WishesTableUpdateCompanionBuilder = WishesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> amount,
  Value<String> bucketId,
  Value<DateTime> createdAt,
  Value<DateTime> endsAt,
  Value<WishStatus> status,
  Value<int> rowid,
});

class $$WishesTableFilterComposer
    extends Composer<_$BucketsDatabase, $WishesTable> {
  $$WishesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WishStatus, WishStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$WishesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $WishesTable> {
  $$WishesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bucketId => $composableBuilder(
    column: $table.bucketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WishesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $WishesTable> {
  $$WishesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get bucketId =>
      $composableBuilder(column: $table.bucketId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WishStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$WishesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $WishesTable,
          WishRow,
          $$WishesTableFilterComposer,
          $$WishesTableOrderingComposer,
          $$WishesTableAnnotationComposer,
          $$WishesTableCreateCompanionBuilder,
          $$WishesTableUpdateCompanionBuilder,
          (WishRow, BaseReferences<_$BucketsDatabase, $WishesTable, WishRow>),
          WishRow,
          PrefetchHooks Function()
        > {
  $$WishesTableTableManager(_$BucketsDatabase db, $WishesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> bucketId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> endsAt = const Value.absent(),
                Value<WishStatus> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WishesCompanion(
                id: id,
                name: name,
                amount: amount,
                bucketId: bucketId,
                createdAt: createdAt,
                endsAt: endsAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int amount,
                required String bucketId,
                required DateTime createdAt,
                required DateTime endsAt,
                required WishStatus status,
                Value<int> rowid = const Value.absent(),
              }) => WishesCompanion.insert(
                id: id,
                name: name,
                amount: amount,
                bucketId: bucketId,
                createdAt: createdAt,
                endsAt: endsAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WishesTable, WishRow>(table),
                  BaseReferences<_$BucketsDatabase, $WishesTable, WishRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WishesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $WishesTable,
      WishRow,
      $$WishesTableFilterComposer,
      $$WishesTableOrderingComposer,
      $$WishesTableAnnotationComposer,
      $$WishesTableCreateCompanionBuilder,
      $$WishesTableUpdateCompanionBuilder,
      (WishRow, BaseReferences<_$BucketsDatabase, $WishesTable, WishRow>),
      WishRow,
      PrefetchHooks Function()
    >;
typedef $$BillOccurrencesTableCreateCompanionBuilder =
    BillOccurrencesCompanion Function({
      required String id,
      required String billId,
      required String cycleStart,
      required String dueDate,
      required int expectedAmount,
      required BillStatus status,
      Value<int?> paidAmount,
      Value<DateTime?> paidAt,
      Value<String?> accountId,
      Value<String?> feeTransactionId,
      Value<String?> proofRef,
      Value<int> rowid,
    });
typedef $$BillOccurrencesTableUpdateCompanionBuilder =
    BillOccurrencesCompanion Function({
      Value<String> id,
      Value<String> billId,
      Value<String> cycleStart,
      Value<String> dueDate,
      Value<int> expectedAmount,
      Value<BillStatus> status,
      Value<int?> paidAmount,
      Value<DateTime?> paidAt,
      Value<String?> accountId,
      Value<String?> feeTransactionId,
      Value<String?> proofRef,
      Value<int> rowid,
    });

class $$BillOccurrencesTableFilterComposer
    extends Composer<_$BucketsDatabase, $BillOccurrencesTable> {
  $$BillOccurrencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cycleStart => $composableBuilder(
    column: $table.cycleStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BillStatus, BillStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feeTransactionId => $composableBuilder(
    column: $table.feeTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proofRef => $composableBuilder(
    column: $table.proofRef,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillOccurrencesTableOrderingComposer
    extends Composer<_$BucketsDatabase, $BillOccurrencesTable> {
  $$BillOccurrencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cycleStart => $composableBuilder(
    column: $table.cycleStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feeTransactionId => $composableBuilder(
    column: $table.feeTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proofRef => $composableBuilder(
    column: $table.proofRef,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillOccurrencesTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $BillOccurrencesTable> {
  $$BillOccurrencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get billId =>
      $composableBuilder(column: $table.billId, builder: (column) => column);

  GeneratedColumn<String> get cycleStart => $composableBuilder(
    column: $table.cycleStart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BillStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get feeTransactionId => $composableBuilder(
    column: $table.feeTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proofRef =>
      $composableBuilder(column: $table.proofRef, builder: (column) => column);
}

class $$BillOccurrencesTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $BillOccurrencesTable,
          BillOccurrenceRow,
          $$BillOccurrencesTableFilterComposer,
          $$BillOccurrencesTableOrderingComposer,
          $$BillOccurrencesTableAnnotationComposer,
          $$BillOccurrencesTableCreateCompanionBuilder,
          $$BillOccurrencesTableUpdateCompanionBuilder,
          (
            BillOccurrenceRow,
            BaseReferences<
              _$BucketsDatabase,
              $BillOccurrencesTable,
              BillOccurrenceRow
            >,
          ),
          BillOccurrenceRow,
          PrefetchHooks Function()
        > {
  $$BillOccurrencesTableTableManager(
    _$BucketsDatabase db,
    $BillOccurrencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillOccurrencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillOccurrencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillOccurrencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> billId = const Value.absent(),
                Value<String> cycleStart = const Value.absent(),
                Value<String> dueDate = const Value.absent(),
                Value<int> expectedAmount = const Value.absent(),
                Value<BillStatus> status = const Value.absent(),
                Value<int?> paidAmount = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> feeTransactionId = const Value.absent(),
                Value<String?> proofRef = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillOccurrencesCompanion(
                id: id,
                billId: billId,
                cycleStart: cycleStart,
                dueDate: dueDate,
                expectedAmount: expectedAmount,
                status: status,
                paidAmount: paidAmount,
                paidAt: paidAt,
                accountId: accountId,
                feeTransactionId: feeTransactionId,
                proofRef: proofRef,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String billId,
                required String cycleStart,
                required String dueDate,
                required int expectedAmount,
                required BillStatus status,
                Value<int?> paidAmount = const Value.absent(),
                Value<DateTime?> paidAt = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> feeTransactionId = const Value.absent(),
                Value<String?> proofRef = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillOccurrencesCompanion.insert(
                id: id,
                billId: billId,
                cycleStart: cycleStart,
                dueDate: dueDate,
                expectedAmount: expectedAmount,
                status: status,
                paidAmount: paidAmount,
                paidAt: paidAt,
                accountId: accountId,
                feeTransactionId: feeTransactionId,
                proofRef: proofRef,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillOccurrencesTable, BillOccurrenceRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $BillOccurrencesTable,
                    BillOccurrenceRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillOccurrencesTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $BillOccurrencesTable,
      BillOccurrenceRow,
      $$BillOccurrencesTableFilterComposer,
      $$BillOccurrencesTableOrderingComposer,
      $$BillOccurrencesTableAnnotationComposer,
      $$BillOccurrencesTableCreateCompanionBuilder,
      $$BillOccurrencesTableUpdateCompanionBuilder,
      (
        BillOccurrenceRow,
        BaseReferences<
          _$BucketsDatabase,
          $BillOccurrencesTable,
          BillOccurrenceRow
        >,
      ),
      BillOccurrenceRow,
      PrefetchHooks Function()
    >;
typedef $$FeeTariffsTableCreateCompanionBuilder = FeeTariffsCompanion Function({
  required AlertSource provider,
  required FeeType feeType,
  Value<int> rowid,
});
typedef $$FeeTariffsTableUpdateCompanionBuilder = FeeTariffsCompanion Function({
  Value<AlertSource> provider,
  Value<FeeType> feeType,
  Value<int> rowid,
});

class $$FeeTariffsTableFilterComposer
    extends Composer<_$BucketsDatabase, $FeeTariffsTable> {
  $$FeeTariffsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<AlertSource, AlertSource, String>
  get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<FeeType, FeeType, String> get feeType =>
      $composableBuilder(
        column: $table.feeType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$FeeTariffsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $FeeTariffsTable> {
  $$FeeTariffsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feeType => $composableBuilder(
    column: $table.feeType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeeTariffsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $FeeTariffsTable> {
  $$FeeTariffsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<AlertSource, String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeeType, String> get feeType =>
      $composableBuilder(column: $table.feeType, builder: (column) => column);
}

class $$FeeTariffsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $FeeTariffsTable,
          FeeTariffRow,
          $$FeeTariffsTableFilterComposer,
          $$FeeTariffsTableOrderingComposer,
          $$FeeTariffsTableAnnotationComposer,
          $$FeeTariffsTableCreateCompanionBuilder,
          $$FeeTariffsTableUpdateCompanionBuilder,
          (
            FeeTariffRow,
            BaseReferences<_$BucketsDatabase, $FeeTariffsTable, FeeTariffRow>,
          ),
          FeeTariffRow,
          PrefetchHooks Function()
        > {
  $$FeeTariffsTableTableManager(_$BucketsDatabase db, $FeeTariffsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeTariffsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeTariffsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeTariffsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<AlertSource> provider = const Value.absent(),
                Value<FeeType> feeType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeTariffsCompanion(
                provider: provider,
                feeType: feeType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required AlertSource provider,
                required FeeType feeType,
                Value<int> rowid = const Value.absent(),
              }) => FeeTariffsCompanion.insert(
                provider: provider,
                feeType: feeType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeeTariffsTable, FeeTariffRow>(table),
                  BaseReferences<
                    _$BucketsDatabase,
                    $FeeTariffsTable,
                    FeeTariffRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeeTariffsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $FeeTariffsTable,
      FeeTariffRow,
      $$FeeTariffsTableFilterComposer,
      $$FeeTariffsTableOrderingComposer,
      $$FeeTariffsTableAnnotationComposer,
      $$FeeTariffsTableCreateCompanionBuilder,
      $$FeeTariffsTableUpdateCompanionBuilder,
      (
        FeeTariffRow,
        BaseReferences<_$BucketsDatabase, $FeeTariffsTable, FeeTariffRow>,
      ),
      FeeTariffRow,
      PrefetchHooks Function()
    >;
typedef $$FeeBandsTableCreateCompanionBuilder = FeeBandsCompanion Function({
  required AlertSource provider,
  required FeeType feeType,
  required int minAmount,
  required int maxAmount,
  required int fee,
  required FeeBandSource source,
  Value<int> observations,
  Value<int> rowid,
});
typedef $$FeeBandsTableUpdateCompanionBuilder = FeeBandsCompanion Function({
  Value<AlertSource> provider,
  Value<FeeType> feeType,
  Value<int> minAmount,
  Value<int> maxAmount,
  Value<int> fee,
  Value<FeeBandSource> source,
  Value<int> observations,
  Value<int> rowid,
});

class $$FeeBandsTableFilterComposer
    extends Composer<_$BucketsDatabase, $FeeBandsTable> {
  $$FeeBandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<AlertSource, AlertSource, String>
  get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<FeeType, FeeType, String> get feeType =>
      $composableBuilder(
        column: $table.feeType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get minAmount => $composableBuilder(
    column: $table.minAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxAmount => $composableBuilder(
    column: $table.maxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fee => $composableBuilder(
    column: $table.fee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FeeBandSource, FeeBandSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get observations => $composableBuilder(
    column: $table.observations,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeeBandsTableOrderingComposer
    extends Composer<_$BucketsDatabase, $FeeBandsTable> {
  $$FeeBandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feeType => $composableBuilder(
    column: $table.feeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minAmount => $composableBuilder(
    column: $table.minAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxAmount => $composableBuilder(
    column: $table.maxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fee => $composableBuilder(
    column: $table.fee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get observations => $composableBuilder(
    column: $table.observations,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeeBandsTableAnnotationComposer
    extends Composer<_$BucketsDatabase, $FeeBandsTable> {
  $$FeeBandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<AlertSource, String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeeType, String> get feeType =>
      $composableBuilder(column: $table.feeType, builder: (column) => column);

  GeneratedColumn<int> get minAmount =>
      $composableBuilder(column: $table.minAmount, builder: (column) => column);

  GeneratedColumn<int> get maxAmount =>
      $composableBuilder(column: $table.maxAmount, builder: (column) => column);

  GeneratedColumn<int> get fee =>
      $composableBuilder(column: $table.fee, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeeBandSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get observations => $composableBuilder(
    column: $table.observations,
    builder: (column) => column,
  );
}

class $$FeeBandsTableTableManager
    extends
        RootTableManager<
          _$BucketsDatabase,
          $FeeBandsTable,
          FeeBandRow,
          $$FeeBandsTableFilterComposer,
          $$FeeBandsTableOrderingComposer,
          $$FeeBandsTableAnnotationComposer,
          $$FeeBandsTableCreateCompanionBuilder,
          $$FeeBandsTableUpdateCompanionBuilder,
          (
            FeeBandRow,
            BaseReferences<_$BucketsDatabase, $FeeBandsTable, FeeBandRow>,
          ),
          FeeBandRow,
          PrefetchHooks Function()
        > {
  $$FeeBandsTableTableManager(_$BucketsDatabase db, $FeeBandsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeeBandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeeBandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeeBandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<AlertSource> provider = const Value.absent(),
                Value<FeeType> feeType = const Value.absent(),
                Value<int> minAmount = const Value.absent(),
                Value<int> maxAmount = const Value.absent(),
                Value<int> fee = const Value.absent(),
                Value<FeeBandSource> source = const Value.absent(),
                Value<int> observations = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeBandsCompanion(
                provider: provider,
                feeType: feeType,
                minAmount: minAmount,
                maxAmount: maxAmount,
                fee: fee,
                source: source,
                observations: observations,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required AlertSource provider,
                required FeeType feeType,
                required int minAmount,
                required int maxAmount,
                required int fee,
                required FeeBandSource source,
                Value<int> observations = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeeBandsCompanion.insert(
                provider: provider,
                feeType: feeType,
                minAmount: minAmount,
                maxAmount: maxAmount,
                fee: fee,
                source: source,
                observations: observations,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeeBandsTable, FeeBandRow>(table),
                  BaseReferences<_$BucketsDatabase, $FeeBandsTable, FeeBandRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeeBandsTableProcessedTableManager =
    ProcessedTableManager<
      _$BucketsDatabase,
      $FeeBandsTable,
      FeeBandRow,
      $$FeeBandsTableFilterComposer,
      $$FeeBandsTableOrderingComposer,
      $$FeeBandsTableAnnotationComposer,
      $$FeeBandsTableCreateCompanionBuilder,
      $$FeeBandsTableUpdateCompanionBuilder,
      (
        FeeBandRow,
        BaseReferences<_$BucketsDatabase, $FeeBandsTable, FeeBandRow>,
      ),
      FeeBandRow,
      PrefetchHooks Function()
    >;

class $BucketsDatabaseManager {
  final _$BucketsDatabase _db;
  $BucketsDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$AccountMatchKeysTableTableManager get accountMatchKeys =>
      $$AccountMatchKeysTableTableManager(_db, _db.accountMatchKeys);
  $$BucketsTableTableManager get buckets =>
      $$BucketsTableTableManager(_db, _db.buckets);
  $$IncomeSourcesTableTableManager get incomeSources =>
      $$IncomeSourcesTableTableManager(_db, _db.incomeSources);
  $$IncomePayerKeysTableTableManager get incomePayerKeys =>
      $$IncomePayerKeysTableTableManager(_db, _db.incomePayerKeys);
  $$SplitProfilesTableTableManager get splitProfiles =>
      $$SplitProfilesTableTableManager(_db, _db.splitProfiles);
  $$SplitAllocationsTableTableManager get splitAllocations =>
      $$SplitAllocationsTableTableManager(_db, _db.splitAllocations);
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db, _db.bills);
  $$SettingsRowsTableTableManager get settingsRows =>
      $$SettingsRowsTableTableManager(_db, _db.settingsRows);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$HelpFeedbacksTableTableManager get helpFeedbacks =>
      $$HelpFeedbacksTableTableManager(_db, _db.helpFeedbacks);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
  $$PaydaysTableTableManager get paydays =>
      $$PaydaysTableTableManager(_db, _db.paydays);
  $$TransfersTableTableManager get transfers =>
      $$TransfersTableTableManager(_db, _db.transfers);
  $$TransferProofRefsTableTableManager get transferProofRefs =>
      $$TransferProofRefsTableTableManager(_db, _db.transferProofRefs);
  $$HeldIncomesTableTableManager get heldIncomes =>
      $$HeldIncomesTableTableManager(_db, _db.heldIncomes);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db, _db.checkIns);
  $$PaymentAlertsTableTableManager get paymentAlerts =>
      $$PaymentAlertsTableTableManager(_db, _db.paymentAlerts);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$TransactionLinesTableTableManager get transactionLines =>
      $$TransactionLinesTableTableManager(_db, _db.transactionLines);
  $$CashWithdrawalsTableTableManager get cashWithdrawals =>
      $$CashWithdrawalsTableTableManager(_db, _db.cashWithdrawals);
  $$MerchantRulesTableTableManager get merchantRules =>
      $$MerchantRulesTableTableManager(_db, _db.merchantRules);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$PlannedPurchasesTableTableManager get plannedPurchases =>
      $$PlannedPurchasesTableTableManager(_db, _db.plannedPurchases);
  $$WishesTableTableManager get wishes =>
      $$WishesTableTableManager(_db, _db.wishes);
  $$BillOccurrencesTableTableManager get billOccurrences =>
      $$BillOccurrencesTableTableManager(_db, _db.billOccurrences);
  $$FeeTariffsTableTableManager get feeTariffs =>
      $$FeeTariffsTableTableManager(_db, _db.feeTariffs);
  $$FeeBandsTableTableManager get feeBands =>
      $$FeeBandsTableTableManager(_db, _db.feeBands);
}
