// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_view_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BucketTileVm {

 String get id; String get name; BucketKind get kind; BucketColor get color; Money get balance;
/// Create a copy of BucketTileVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketTileVmCopyWith<BucketTileVm> get copyWith => _$BucketTileVmCopyWithImpl<BucketTileVm>(this as BucketTileVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BucketTileVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketTileVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.balance, _this.balance) || other.balance == _this.balance));
}


@override
int get hashCode {
  final _this = this as BucketTileVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.color,_this.balance);
}

@override
String toString() {
  final _this = this as BucketTileVm;
  return 'BucketTileVm(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, color: ${_this.color}, balance: ${_this.balance})';
}


}

/// @nodoc
abstract mixin class $BucketTileVmCopyWith<$Res>  {
  factory $BucketTileVmCopyWith(BucketTileVm value, $Res Function(BucketTileVm) _then) = _$BucketTileVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, BucketKind kind, BucketColor color, Money balance
});




}
/// @nodoc
class _$BucketTileVmCopyWithImpl<$Res>
    implements $BucketTileVmCopyWith<$Res> {
  _$BucketTileVmCopyWithImpl(this._self, this._then);

  final BucketTileVm _self;
  final $Res Function(BucketTileVm) _then;

/// Create a copy of BucketTileVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? color = null,Object? balance = null,}) {
  return _then(BucketTileVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as BucketKind,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [BucketTileVm].
extension BucketTileVmPatterns on BucketTileVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BucketTileVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BucketTileVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BucketTileVm value)  $default,){
final _that = this;
switch (_that) {
case _BucketTileVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BucketTileVm value)?  $default,){
final _that = this;
switch (_that) {
case _BucketTileVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  BucketKind kind,  BucketColor color,  Money balance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BucketTileVm() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.color,_that.balance);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  BucketKind kind,  BucketColor color,  Money balance)  $default,) {final _that = this;
switch (_that) {
case _BucketTileVm():
return $default(_that.id,_that.name,_that.kind,_that.color,_that.balance);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  BucketKind kind,  BucketColor color,  Money balance)?  $default,) {final _that = this;
switch (_that) {
case _BucketTileVm() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.color,_that.balance);case _:
  return null;

}
}

}

/// @nodoc


class _BucketTileVm implements BucketTileVm {
  const _BucketTileVm({required this.id, required this.name, required this.kind, required this.color, required this.balance});
  

@override final  String id;
@override final  String name;
@override final  BucketKind kind;
@override final  BucketColor color;
@override final  Money balance;

/// Create a copy of BucketTileVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BucketTileVmCopyWith<_BucketTileVm> get copyWith => __$BucketTileVmCopyWithImpl<_BucketTileVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BucketTileVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.color, color) || other.color == color)&&(identical(other.balance, balance) || other.balance == balance));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,color,balance);
}

@override
String toString() {
    return 'BucketTileVm(id: $id, name: $name, kind: $kind, color: $color, balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$BucketTileVmCopyWith<$Res> implements $BucketTileVmCopyWith<$Res> {
  factory _$BucketTileVmCopyWith(_BucketTileVm value, $Res Function(_BucketTileVm) _then) = __$BucketTileVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, BucketKind kind, BucketColor color, Money balance
});




}
/// @nodoc
class __$BucketTileVmCopyWithImpl<$Res>
    implements _$BucketTileVmCopyWith<$Res> {
  __$BucketTileVmCopyWithImpl(this._self, this._then);

  final _BucketTileVm _self;
  final $Res Function(_BucketTileVm) _then;

/// Create a copy of BucketTileVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? color = null,Object? balance = null,}) {
  return _then(_BucketTileVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as BucketKind,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$TransactionRowVm {

 String get id; Money get amount; String get category; String get bucketId; DateTime get occurredAt;
/// Create a copy of TransactionRowVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionRowVmCopyWith<TransactionRowVm> get copyWith => _$TransactionRowVmCopyWithImpl<TransactionRowVm>(this as TransactionRowVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransactionRowVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionRowVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.bucketId, _this.bucketId) || other.bucketId == _this.bucketId)&&(identical(other.occurredAt, _this.occurredAt) || other.occurredAt == _this.occurredAt));
}


@override
int get hashCode {
  final _this = this as TransactionRowVm;
  return Object.hash(runtimeType,_this.id,_this.amount,_this.category,_this.bucketId,_this.occurredAt);
}

@override
String toString() {
  final _this = this as TransactionRowVm;
  return 'TransactionRowVm(id: ${_this.id}, amount: ${_this.amount}, category: ${_this.category}, bucketId: ${_this.bucketId}, occurredAt: ${_this.occurredAt})';
}


}

/// @nodoc
abstract mixin class $TransactionRowVmCopyWith<$Res>  {
  factory $TransactionRowVmCopyWith(TransactionRowVm value, $Res Function(TransactionRowVm) _then) = _$TransactionRowVmCopyWithImpl;
@useResult
$Res call({
 String id, Money amount, String category, String bucketId, DateTime occurredAt
});




}
/// @nodoc
class _$TransactionRowVmCopyWithImpl<$Res>
    implements $TransactionRowVmCopyWith<$Res> {
  _$TransactionRowVmCopyWithImpl(this._self, this._then);

  final TransactionRowVm _self;
  final $Res Function(TransactionRowVm) _then;

/// Create a copy of TransactionRowVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? category = null,Object? bucketId = null,Object? occurredAt = null,}) {
  return _then(TransactionRowVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionRowVm].
extension TransactionRowVmPatterns on TransactionRowVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionRowVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionRowVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionRowVm value)  $default,){
final _that = this;
switch (_that) {
case _TransactionRowVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionRowVm value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionRowVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Money amount,  String category,  String bucketId,  DateTime occurredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionRowVm() when $default != null:
return $default(_that.id,_that.amount,_that.category,_that.bucketId,_that.occurredAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Money amount,  String category,  String bucketId,  DateTime occurredAt)  $default,) {final _that = this;
switch (_that) {
case _TransactionRowVm():
return $default(_that.id,_that.amount,_that.category,_that.bucketId,_that.occurredAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Money amount,  String category,  String bucketId,  DateTime occurredAt)?  $default,) {final _that = this;
switch (_that) {
case _TransactionRowVm() when $default != null:
return $default(_that.id,_that.amount,_that.category,_that.bucketId,_that.occurredAt);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionRowVm implements TransactionRowVm {
  const _TransactionRowVm({required this.id, required this.amount, required this.category, required this.bucketId, required this.occurredAt});
  

@override final  String id;
@override final  Money amount;
@override final  String category;
@override final  String bucketId;
@override final  DateTime occurredAt;

/// Create a copy of TransactionRowVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionRowVmCopyWith<_TransactionRowVm> get copyWith => __$TransactionRowVmCopyWithImpl<_TransactionRowVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionRowVm&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,amount,category,bucketId,occurredAt);
}

@override
String toString() {
    return 'TransactionRowVm(id: $id, amount: $amount, category: $category, bucketId: $bucketId, occurredAt: $occurredAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionRowVmCopyWith<$Res> implements $TransactionRowVmCopyWith<$Res> {
  factory _$TransactionRowVmCopyWith(_TransactionRowVm value, $Res Function(_TransactionRowVm) _then) = __$TransactionRowVmCopyWithImpl;
@override @useResult
$Res call({
 String id, Money amount, String category, String bucketId, DateTime occurredAt
});




}
/// @nodoc
class __$TransactionRowVmCopyWithImpl<$Res>
    implements _$TransactionRowVmCopyWith<$Res> {
  __$TransactionRowVmCopyWithImpl(this._self, this._then);

  final _TransactionRowVm _self;
  final $Res Function(_TransactionRowVm) _then;

/// Create a copy of TransactionRowVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? category = null,Object? bucketId = null,Object? occurredAt = null,}) {
  return _then(_TransactionRowVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$PaydayBannerVm {

 String get paydayId; int get pending; Money get pendingAmount;
/// Create a copy of PaydayBannerVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaydayBannerVmCopyWith<PaydayBannerVm> get copyWith => _$PaydayBannerVmCopyWithImpl<PaydayBannerVm>(this as PaydayBannerVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PaydayBannerVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaydayBannerVm&&(identical(other.paydayId, _this.paydayId) || other.paydayId == _this.paydayId)&&(identical(other.pending, _this.pending) || other.pending == _this.pending)&&(identical(other.pendingAmount, _this.pendingAmount) || other.pendingAmount == _this.pendingAmount));
}


@override
int get hashCode {
  final _this = this as PaydayBannerVm;
  return Object.hash(runtimeType,_this.paydayId,_this.pending,_this.pendingAmount);
}

@override
String toString() {
  final _this = this as PaydayBannerVm;
  return 'PaydayBannerVm(paydayId: ${_this.paydayId}, pending: ${_this.pending}, pendingAmount: ${_this.pendingAmount})';
}


}

/// @nodoc
abstract mixin class $PaydayBannerVmCopyWith<$Res>  {
  factory $PaydayBannerVmCopyWith(PaydayBannerVm value, $Res Function(PaydayBannerVm) _then) = _$PaydayBannerVmCopyWithImpl;
@useResult
$Res call({
 String paydayId, int pending, Money pendingAmount
});




}
/// @nodoc
class _$PaydayBannerVmCopyWithImpl<$Res>
    implements $PaydayBannerVmCopyWith<$Res> {
  _$PaydayBannerVmCopyWithImpl(this._self, this._then);

  final PaydayBannerVm _self;
  final $Res Function(PaydayBannerVm) _then;

/// Create a copy of PaydayBannerVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paydayId = null,Object? pending = null,Object? pendingAmount = null,}) {
  return _then(PaydayBannerVm(
paydayId: null == paydayId ? _self.paydayId : paydayId // ignore: cast_nullable_to_non_nullable
as String,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,pendingAmount: null == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [PaydayBannerVm].
extension PaydayBannerVmPatterns on PaydayBannerVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaydayBannerVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaydayBannerVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaydayBannerVm value)  $default,){
final _that = this;
switch (_that) {
case _PaydayBannerVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaydayBannerVm value)?  $default,){
final _that = this;
switch (_that) {
case _PaydayBannerVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paydayId,  int pending,  Money pendingAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaydayBannerVm() when $default != null:
return $default(_that.paydayId,_that.pending,_that.pendingAmount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paydayId,  int pending,  Money pendingAmount)  $default,) {final _that = this;
switch (_that) {
case _PaydayBannerVm():
return $default(_that.paydayId,_that.pending,_that.pendingAmount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paydayId,  int pending,  Money pendingAmount)?  $default,) {final _that = this;
switch (_that) {
case _PaydayBannerVm() when $default != null:
return $default(_that.paydayId,_that.pending,_that.pendingAmount);case _:
  return null;

}
}

}

/// @nodoc


class _PaydayBannerVm implements PaydayBannerVm {
  const _PaydayBannerVm({required this.paydayId, required this.pending, required this.pendingAmount});
  

@override final  String paydayId;
@override final  int pending;
@override final  Money pendingAmount;

/// Create a copy of PaydayBannerVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaydayBannerVmCopyWith<_PaydayBannerVm> get copyWith => __$PaydayBannerVmCopyWithImpl<_PaydayBannerVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaydayBannerVm&&(identical(other.paydayId, paydayId) || other.paydayId == paydayId)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.pendingAmount, pendingAmount) || other.pendingAmount == pendingAmount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,paydayId,pending,pendingAmount);
}

@override
String toString() {
    return 'PaydayBannerVm(paydayId: $paydayId, pending: $pending, pendingAmount: $pendingAmount)';
}


}

/// @nodoc
abstract mixin class _$PaydayBannerVmCopyWith<$Res> implements $PaydayBannerVmCopyWith<$Res> {
  factory _$PaydayBannerVmCopyWith(_PaydayBannerVm value, $Res Function(_PaydayBannerVm) _then) = __$PaydayBannerVmCopyWithImpl;
@override @useResult
$Res call({
 String paydayId, int pending, Money pendingAmount
});




}
/// @nodoc
class __$PaydayBannerVmCopyWithImpl<$Res>
    implements _$PaydayBannerVmCopyWith<$Res> {
  __$PaydayBannerVmCopyWithImpl(this._self, this._then);

  final _PaydayBannerVm _self;
  final $Res Function(_PaydayBannerVm) _then;

/// Create a copy of PaydayBannerVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paydayId = null,Object? pending = null,Object? pendingAmount = null,}) {
  return _then(_PaydayBannerVm(
paydayId: null == paydayId ? _self.paydayId : paydayId // ignore: cast_nullable_to_non_nullable
as String,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,pendingAmount: null == pendingAmount ? _self.pendingAmount : pendingAmount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$EntryRowVm {

 String get id; LedgerEntryKind get kind; Money get amount; DateTime get occurredAt; String? get note;
/// Create a copy of EntryRowVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryRowVmCopyWith<EntryRowVm> get copyWith => _$EntryRowVmCopyWithImpl<EntryRowVm>(this as EntryRowVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EntryRowVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryRowVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.occurredAt, _this.occurredAt) || other.occurredAt == _this.occurredAt)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as EntryRowVm;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.amount,_this.occurredAt,_this.note);
}

@override
String toString() {
  final _this = this as EntryRowVm;
  return 'EntryRowVm(id: ${_this.id}, kind: ${_this.kind}, amount: ${_this.amount}, occurredAt: ${_this.occurredAt}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $EntryRowVmCopyWith<$Res>  {
  factory $EntryRowVmCopyWith(EntryRowVm value, $Res Function(EntryRowVm) _then) = _$EntryRowVmCopyWithImpl;
@useResult
$Res call({
 String id, LedgerEntryKind kind, Money amount, DateTime occurredAt, String? note
});




}
/// @nodoc
class _$EntryRowVmCopyWithImpl<$Res>
    implements $EntryRowVmCopyWith<$Res> {
  _$EntryRowVmCopyWithImpl(this._self, this._then);

  final EntryRowVm _self;
  final $Res Function(EntryRowVm) _then;

/// Create a copy of EntryRowVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? amount = null,Object? occurredAt = null,Object? note = freezed,}) {
  return _then(EntryRowVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerEntryKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EntryRowVm].
extension EntryRowVmPatterns on EntryRowVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntryRowVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntryRowVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntryRowVm value)  $default,){
final _that = this;
switch (_that) {
case _EntryRowVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntryRowVm value)?  $default,){
final _that = this;
switch (_that) {
case _EntryRowVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LedgerEntryKind kind,  Money amount,  DateTime occurredAt,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntryRowVm() when $default != null:
return $default(_that.id,_that.kind,_that.amount,_that.occurredAt,_that.note);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LedgerEntryKind kind,  Money amount,  DateTime occurredAt,  String? note)  $default,) {final _that = this;
switch (_that) {
case _EntryRowVm():
return $default(_that.id,_that.kind,_that.amount,_that.occurredAt,_that.note);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LedgerEntryKind kind,  Money amount,  DateTime occurredAt,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _EntryRowVm() when $default != null:
return $default(_that.id,_that.kind,_that.amount,_that.occurredAt,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _EntryRowVm implements EntryRowVm {
  const _EntryRowVm({required this.id, required this.kind, required this.amount, required this.occurredAt, required this.note});
  

@override final  String id;
@override final  LedgerEntryKind kind;
@override final  Money amount;
@override final  DateTime occurredAt;
@override final  String? note;

/// Create a copy of EntryRowVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntryRowVmCopyWith<_EntryRowVm> get copyWith => __$EntryRowVmCopyWithImpl<_EntryRowVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntryRowVm&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,amount,occurredAt,note);
}

@override
String toString() {
    return 'EntryRowVm(id: $id, kind: $kind, amount: $amount, occurredAt: $occurredAt, note: $note)';
}


}

/// @nodoc
abstract mixin class _$EntryRowVmCopyWith<$Res> implements $EntryRowVmCopyWith<$Res> {
  factory _$EntryRowVmCopyWith(_EntryRowVm value, $Res Function(_EntryRowVm) _then) = __$EntryRowVmCopyWithImpl;
@override @useResult
$Res call({
 String id, LedgerEntryKind kind, Money amount, DateTime occurredAt, String? note
});




}
/// @nodoc
class __$EntryRowVmCopyWithImpl<$Res>
    implements _$EntryRowVmCopyWith<$Res> {
  __$EntryRowVmCopyWithImpl(this._self, this._then);

  final _EntryRowVm _self;
  final $Res Function(_EntryRowVm) _then;

/// Create a copy of EntryRowVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? amount = null,Object? occurredAt = null,Object? note = freezed,}) {
  return _then(_EntryRowVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LedgerEntryKind,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CoverOptionVm {

 String get fromBucketId; String get fromName; bool get nextCycle; Money? get fromBalance;
/// Create a copy of CoverOptionVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoverOptionVmCopyWith<CoverOptionVm> get copyWith => _$CoverOptionVmCopyWithImpl<CoverOptionVm>(this as CoverOptionVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CoverOptionVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoverOptionVm&&(identical(other.fromBucketId, _this.fromBucketId) || other.fromBucketId == _this.fromBucketId)&&(identical(other.fromName, _this.fromName) || other.fromName == _this.fromName)&&(identical(other.nextCycle, _this.nextCycle) || other.nextCycle == _this.nextCycle)&&(identical(other.fromBalance, _this.fromBalance) || other.fromBalance == _this.fromBalance));
}


@override
int get hashCode {
  final _this = this as CoverOptionVm;
  return Object.hash(runtimeType,_this.fromBucketId,_this.fromName,_this.nextCycle,_this.fromBalance);
}

@override
String toString() {
  final _this = this as CoverOptionVm;
  return 'CoverOptionVm(fromBucketId: ${_this.fromBucketId}, fromName: ${_this.fromName}, nextCycle: ${_this.nextCycle}, fromBalance: ${_this.fromBalance})';
}


}

/// @nodoc
abstract mixin class $CoverOptionVmCopyWith<$Res>  {
  factory $CoverOptionVmCopyWith(CoverOptionVm value, $Res Function(CoverOptionVm) _then) = _$CoverOptionVmCopyWithImpl;
@useResult
$Res call({
 String fromBucketId, String fromName, bool nextCycle, Money? fromBalance
});




}
/// @nodoc
class _$CoverOptionVmCopyWithImpl<$Res>
    implements $CoverOptionVmCopyWith<$Res> {
  _$CoverOptionVmCopyWithImpl(this._self, this._then);

  final CoverOptionVm _self;
  final $Res Function(CoverOptionVm) _then;

/// Create a copy of CoverOptionVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromBucketId = null,Object? fromName = null,Object? nextCycle = null,Object? fromBalance = freezed,}) {
  return _then(CoverOptionVm(
fromBucketId: null == fromBucketId ? _self.fromBucketId : fromBucketId // ignore: cast_nullable_to_non_nullable
as String,fromName: null == fromName ? _self.fromName : fromName // ignore: cast_nullable_to_non_nullable
as String,nextCycle: null == nextCycle ? _self.nextCycle : nextCycle // ignore: cast_nullable_to_non_nullable
as bool,fromBalance: freezed == fromBalance ? _self.fromBalance : fromBalance // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoverOptionVm].
extension CoverOptionVmPatterns on CoverOptionVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoverOptionVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoverOptionVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoverOptionVm value)  $default,){
final _that = this;
switch (_that) {
case _CoverOptionVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoverOptionVm value)?  $default,){
final _that = this;
switch (_that) {
case _CoverOptionVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fromBucketId,  String fromName,  bool nextCycle,  Money? fromBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoverOptionVm() when $default != null:
return $default(_that.fromBucketId,_that.fromName,_that.nextCycle,_that.fromBalance);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fromBucketId,  String fromName,  bool nextCycle,  Money? fromBalance)  $default,) {final _that = this;
switch (_that) {
case _CoverOptionVm():
return $default(_that.fromBucketId,_that.fromName,_that.nextCycle,_that.fromBalance);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fromBucketId,  String fromName,  bool nextCycle,  Money? fromBalance)?  $default,) {final _that = this;
switch (_that) {
case _CoverOptionVm() when $default != null:
return $default(_that.fromBucketId,_that.fromName,_that.nextCycle,_that.fromBalance);case _:
  return null;

}
}

}

/// @nodoc


class _CoverOptionVm implements CoverOptionVm {
  const _CoverOptionVm({required this.fromBucketId, required this.fromName, required this.nextCycle, this.fromBalance});
  

@override final  String fromBucketId;
@override final  String fromName;
@override final  bool nextCycle;
@override final  Money? fromBalance;

/// Create a copy of CoverOptionVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoverOptionVmCopyWith<_CoverOptionVm> get copyWith => __$CoverOptionVmCopyWithImpl<_CoverOptionVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoverOptionVm&&(identical(other.fromBucketId, fromBucketId) || other.fromBucketId == fromBucketId)&&(identical(other.fromName, fromName) || other.fromName == fromName)&&(identical(other.nextCycle, nextCycle) || other.nextCycle == nextCycle)&&(identical(other.fromBalance, fromBalance) || other.fromBalance == fromBalance));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fromBucketId,fromName,nextCycle,fromBalance);
}

@override
String toString() {
    return 'CoverOptionVm(fromBucketId: $fromBucketId, fromName: $fromName, nextCycle: $nextCycle, fromBalance: $fromBalance)';
}


}

/// @nodoc
abstract mixin class _$CoverOptionVmCopyWith<$Res> implements $CoverOptionVmCopyWith<$Res> {
  factory _$CoverOptionVmCopyWith(_CoverOptionVm value, $Res Function(_CoverOptionVm) _then) = __$CoverOptionVmCopyWithImpl;
@override @useResult
$Res call({
 String fromBucketId, String fromName, bool nextCycle, Money? fromBalance
});




}
/// @nodoc
class __$CoverOptionVmCopyWithImpl<$Res>
    implements _$CoverOptionVmCopyWith<$Res> {
  __$CoverOptionVmCopyWithImpl(this._self, this._then);

  final _CoverOptionVm _self;
  final $Res Function(_CoverOptionVm) _then;

/// Create a copy of CoverOptionVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromBucketId = null,Object? fromName = null,Object? nextCycle = null,Object? fromBalance = freezed,}) {
  return _then(_CoverOptionVm(
fromBucketId: null == fromBucketId ? _self.fromBucketId : fromBucketId // ignore: cast_nullable_to_non_nullable
as String,fromName: null == fromName ? _self.fromName : fromName // ignore: cast_nullable_to_non_nullable
as String,nextCycle: null == nextCycle ? _self.nextCycle : nextCycle // ignore: cast_nullable_to_non_nullable
as bool,fromBalance: freezed == fromBalance ? _self.fromBalance : fromBalance // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}


}

/// @nodoc
mixin _$GoalCardVm {

 String get bucketId; String get name; Money get balance; Money get target; Money get monthlyContribution; GoalEtaKind get eta; int? get etaMonths; LocalDate? get etaDate; bool get celebrate;
/// Create a copy of GoalCardVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalCardVmCopyWith<GoalCardVm> get copyWith => _$GoalCardVmCopyWithImpl<GoalCardVm>(this as GoalCardVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoalCardVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalCardVm&&(identical(other.bucketId, _this.bucketId) || other.bucketId == _this.bucketId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.balance, _this.balance) || other.balance == _this.balance)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.monthlyContribution, _this.monthlyContribution) || other.monthlyContribution == _this.monthlyContribution)&&(identical(other.eta, _this.eta) || other.eta == _this.eta)&&(identical(other.etaMonths, _this.etaMonths) || other.etaMonths == _this.etaMonths)&&(identical(other.etaDate, _this.etaDate) || other.etaDate == _this.etaDate)&&(identical(other.celebrate, _this.celebrate) || other.celebrate == _this.celebrate));
}


@override
int get hashCode {
  final _this = this as GoalCardVm;
  return Object.hash(runtimeType,_this.bucketId,_this.name,_this.balance,_this.target,_this.monthlyContribution,_this.eta,_this.etaMonths,_this.etaDate,_this.celebrate);
}

@override
String toString() {
  final _this = this as GoalCardVm;
  return 'GoalCardVm(bucketId: ${_this.bucketId}, name: ${_this.name}, balance: ${_this.balance}, target: ${_this.target}, monthlyContribution: ${_this.monthlyContribution}, eta: ${_this.eta}, etaMonths: ${_this.etaMonths}, etaDate: ${_this.etaDate}, celebrate: ${_this.celebrate})';
}


}

/// @nodoc
abstract mixin class $GoalCardVmCopyWith<$Res>  {
  factory $GoalCardVmCopyWith(GoalCardVm value, $Res Function(GoalCardVm) _then) = _$GoalCardVmCopyWithImpl;
@useResult
$Res call({
 String bucketId, String name, Money balance, Money target, Money monthlyContribution, GoalEtaKind eta, int? etaMonths, LocalDate? etaDate, bool celebrate
});




}
/// @nodoc
class _$GoalCardVmCopyWithImpl<$Res>
    implements $GoalCardVmCopyWith<$Res> {
  _$GoalCardVmCopyWithImpl(this._self, this._then);

  final GoalCardVm _self;
  final $Res Function(GoalCardVm) _then;

/// Create a copy of GoalCardVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bucketId = null,Object? name = null,Object? balance = null,Object? target = null,Object? monthlyContribution = null,Object? eta = null,Object? etaMonths = freezed,Object? etaDate = freezed,Object? celebrate = null,}) {
  return _then(GoalCardVm(
bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Money,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as Money,monthlyContribution: null == monthlyContribution ? _self.monthlyContribution : monthlyContribution // ignore: cast_nullable_to_non_nullable
as Money,eta: null == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as GoalEtaKind,etaMonths: freezed == etaMonths ? _self.etaMonths : etaMonths // ignore: cast_nullable_to_non_nullable
as int?,etaDate: freezed == etaDate ? _self.etaDate : etaDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,celebrate: null == celebrate ? _self.celebrate : celebrate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalCardVm].
extension GoalCardVmPatterns on GoalCardVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalCardVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalCardVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalCardVm value)  $default,){
final _that = this;
switch (_that) {
case _GoalCardVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalCardVm value)?  $default,){
final _that = this;
switch (_that) {
case _GoalCardVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bucketId,  String name,  Money balance,  Money target,  Money monthlyContribution,  GoalEtaKind eta,  int? etaMonths,  LocalDate? etaDate,  bool celebrate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalCardVm() when $default != null:
return $default(_that.bucketId,_that.name,_that.balance,_that.target,_that.monthlyContribution,_that.eta,_that.etaMonths,_that.etaDate,_that.celebrate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bucketId,  String name,  Money balance,  Money target,  Money monthlyContribution,  GoalEtaKind eta,  int? etaMonths,  LocalDate? etaDate,  bool celebrate)  $default,) {final _that = this;
switch (_that) {
case _GoalCardVm():
return $default(_that.bucketId,_that.name,_that.balance,_that.target,_that.monthlyContribution,_that.eta,_that.etaMonths,_that.etaDate,_that.celebrate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bucketId,  String name,  Money balance,  Money target,  Money monthlyContribution,  GoalEtaKind eta,  int? etaMonths,  LocalDate? etaDate,  bool celebrate)?  $default,) {final _that = this;
switch (_that) {
case _GoalCardVm() when $default != null:
return $default(_that.bucketId,_that.name,_that.balance,_that.target,_that.monthlyContribution,_that.eta,_that.etaMonths,_that.etaDate,_that.celebrate);case _:
  return null;

}
}

}

/// @nodoc


class _GoalCardVm implements GoalCardVm {
  const _GoalCardVm({required this.bucketId, required this.name, required this.balance, required this.target, required this.monthlyContribution, required this.eta, required this.etaMonths, required this.etaDate, required this.celebrate});
  

@override final  String bucketId;
@override final  String name;
@override final  Money balance;
@override final  Money target;
@override final  Money monthlyContribution;
@override final  GoalEtaKind eta;
@override final  int? etaMonths;
@override final  LocalDate? etaDate;
@override final  bool celebrate;

/// Create a copy of GoalCardVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalCardVmCopyWith<_GoalCardVm> get copyWith => __$GoalCardVmCopyWithImpl<_GoalCardVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalCardVm&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.name, name) || other.name == name)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.target, target) || other.target == target)&&(identical(other.monthlyContribution, monthlyContribution) || other.monthlyContribution == monthlyContribution)&&(identical(other.eta, eta) || other.eta == eta)&&(identical(other.etaMonths, etaMonths) || other.etaMonths == etaMonths)&&(identical(other.etaDate, etaDate) || other.etaDate == etaDate)&&(identical(other.celebrate, celebrate) || other.celebrate == celebrate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bucketId,name,balance,target,monthlyContribution,eta,etaMonths,etaDate,celebrate);
}

@override
String toString() {
    return 'GoalCardVm(bucketId: $bucketId, name: $name, balance: $balance, target: $target, monthlyContribution: $monthlyContribution, eta: $eta, etaMonths: $etaMonths, etaDate: $etaDate, celebrate: $celebrate)';
}


}

/// @nodoc
abstract mixin class _$GoalCardVmCopyWith<$Res> implements $GoalCardVmCopyWith<$Res> {
  factory _$GoalCardVmCopyWith(_GoalCardVm value, $Res Function(_GoalCardVm) _then) = __$GoalCardVmCopyWithImpl;
@override @useResult
$Res call({
 String bucketId, String name, Money balance, Money target, Money monthlyContribution, GoalEtaKind eta, int? etaMonths, LocalDate? etaDate, bool celebrate
});




}
/// @nodoc
class __$GoalCardVmCopyWithImpl<$Res>
    implements _$GoalCardVmCopyWith<$Res> {
  __$GoalCardVmCopyWithImpl(this._self, this._then);

  final _GoalCardVm _self;
  final $Res Function(_GoalCardVm) _then;

/// Create a copy of GoalCardVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucketId = null,Object? name = null,Object? balance = null,Object? target = null,Object? monthlyContribution = null,Object? eta = null,Object? etaMonths = freezed,Object? etaDate = freezed,Object? celebrate = null,}) {
  return _then(_GoalCardVm(
bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as Money,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as Money,monthlyContribution: null == monthlyContribution ? _self.monthlyContribution : monthlyContribution // ignore: cast_nullable_to_non_nullable
as Money,eta: null == eta ? _self.eta : eta // ignore: cast_nullable_to_non_nullable
as GoalEtaKind,etaMonths: freezed == etaMonths ? _self.etaMonths : etaMonths // ignore: cast_nullable_to_non_nullable
as int?,etaDate: freezed == etaDate ? _self.etaDate : etaDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,celebrate: null == celebrate ? _self.celebrate : celebrate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PlannedVm {

 String get id; String get name; Money get amount; String get bucketId; bool get done;
/// Create a copy of PlannedVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannedVmCopyWith<PlannedVm> get copyWith => _$PlannedVmCopyWithImpl<PlannedVm>(this as PlannedVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlannedVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannedVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.bucketId, _this.bucketId) || other.bucketId == _this.bucketId)&&(identical(other.done, _this.done) || other.done == _this.done));
}


@override
int get hashCode {
  final _this = this as PlannedVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.amount,_this.bucketId,_this.done);
}

@override
String toString() {
  final _this = this as PlannedVm;
  return 'PlannedVm(id: ${_this.id}, name: ${_this.name}, amount: ${_this.amount}, bucketId: ${_this.bucketId}, done: ${_this.done})';
}


}

/// @nodoc
abstract mixin class $PlannedVmCopyWith<$Res>  {
  factory $PlannedVmCopyWith(PlannedVm value, $Res Function(PlannedVm) _then) = _$PlannedVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, Money amount, String bucketId, bool done
});




}
/// @nodoc
class _$PlannedVmCopyWithImpl<$Res>
    implements $PlannedVmCopyWith<$Res> {
  _$PlannedVmCopyWithImpl(this._self, this._then);

  final PlannedVm _self;
  final $Res Function(PlannedVm) _then;

/// Create a copy of PlannedVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? bucketId = null,Object? done = null,}) {
  return _then(PlannedVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannedVm].
extension PlannedVmPatterns on PlannedVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannedVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannedVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannedVm value)  $default,){
final _that = this;
switch (_that) {
case _PlannedVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannedVm value)?  $default,){
final _that = this;
switch (_that) {
case _PlannedVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Money amount,  String bucketId,  bool done)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannedVm() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.bucketId,_that.done);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Money amount,  String bucketId,  bool done)  $default,) {final _that = this;
switch (_that) {
case _PlannedVm():
return $default(_that.id,_that.name,_that.amount,_that.bucketId,_that.done);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Money amount,  String bucketId,  bool done)?  $default,) {final _that = this;
switch (_that) {
case _PlannedVm() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.bucketId,_that.done);case _:
  return null;

}
}

}

/// @nodoc


class _PlannedVm implements PlannedVm {
  const _PlannedVm({required this.id, required this.name, required this.amount, required this.bucketId, required this.done});
  

@override final  String id;
@override final  String name;
@override final  Money amount;
@override final  String bucketId;
@override final  bool done;

/// Create a copy of PlannedVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannedVmCopyWith<_PlannedVm> get copyWith => __$PlannedVmCopyWithImpl<_PlannedVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannedVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.done, done) || other.done == done));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,amount,bucketId,done);
}

@override
String toString() {
    return 'PlannedVm(id: $id, name: $name, amount: $amount, bucketId: $bucketId, done: $done)';
}


}

/// @nodoc
abstract mixin class _$PlannedVmCopyWith<$Res> implements $PlannedVmCopyWith<$Res> {
  factory _$PlannedVmCopyWith(_PlannedVm value, $Res Function(_PlannedVm) _then) = __$PlannedVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Money amount, String bucketId, bool done
});




}
/// @nodoc
class __$PlannedVmCopyWithImpl<$Res>
    implements _$PlannedVmCopyWith<$Res> {
  __$PlannedVmCopyWithImpl(this._self, this._then);

  final _PlannedVm _self;
  final $Res Function(_PlannedVm) _then;

/// Create a copy of PlannedVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? bucketId = null,Object? done = null,}) {
  return _then(_PlannedVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$WishVm {

 String get id; String get name; Money get amount; String get bucketId; WishStatus get status; Duration get timeLeft; double get progress;
/// Create a copy of WishVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishVmCopyWith<WishVm> get copyWith => _$WishVmCopyWithImpl<WishVm>(this as WishVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WishVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.bucketId, _this.bucketId) || other.bucketId == _this.bucketId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.timeLeft, _this.timeLeft) || other.timeLeft == _this.timeLeft)&&(identical(other.progress, _this.progress) || other.progress == _this.progress));
}


@override
int get hashCode {
  final _this = this as WishVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.amount,_this.bucketId,_this.status,_this.timeLeft,_this.progress);
}

@override
String toString() {
  final _this = this as WishVm;
  return 'WishVm(id: ${_this.id}, name: ${_this.name}, amount: ${_this.amount}, bucketId: ${_this.bucketId}, status: ${_this.status}, timeLeft: ${_this.timeLeft}, progress: ${_this.progress})';
}


}

/// @nodoc
abstract mixin class $WishVmCopyWith<$Res>  {
  factory $WishVmCopyWith(WishVm value, $Res Function(WishVm) _then) = _$WishVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, Money amount, String bucketId, WishStatus status, Duration timeLeft, double progress
});




}
/// @nodoc
class _$WishVmCopyWithImpl<$Res>
    implements $WishVmCopyWith<$Res> {
  _$WishVmCopyWithImpl(this._self, this._then);

  final WishVm _self;
  final $Res Function(WishVm) _then;

/// Create a copy of WishVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? bucketId = null,Object? status = null,Object? timeLeft = null,Object? progress = null,}) {
  return _then(WishVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WishStatus,timeLeft: null == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WishVm].
extension WishVmPatterns on WishVm {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishVm() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishVm value)  $default,){
final _that = this;
switch (_that) {
case _WishVm():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishVm value)?  $default,){
final _that = this;
switch (_that) {
case _WishVm() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Money amount,  String bucketId,  WishStatus status,  Duration timeLeft,  double progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishVm() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.bucketId,_that.status,_that.timeLeft,_that.progress);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Money amount,  String bucketId,  WishStatus status,  Duration timeLeft,  double progress)  $default,) {final _that = this;
switch (_that) {
case _WishVm():
return $default(_that.id,_that.name,_that.amount,_that.bucketId,_that.status,_that.timeLeft,_that.progress);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Money amount,  String bucketId,  WishStatus status,  Duration timeLeft,  double progress)?  $default,) {final _that = this;
switch (_that) {
case _WishVm() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.bucketId,_that.status,_that.timeLeft,_that.progress);case _:
  return null;

}
}

}

/// @nodoc


class _WishVm implements WishVm {
  const _WishVm({required this.id, required this.name, required this.amount, required this.bucketId, required this.status, required this.timeLeft, required this.progress});
  

@override final  String id;
@override final  String name;
@override final  Money amount;
@override final  String bucketId;
@override final  WishStatus status;
@override final  Duration timeLeft;
@override final  double progress;

/// Create a copy of WishVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishVmCopyWith<_WishVm> get copyWith => __$WishVmCopyWithImpl<_WishVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.status, status) || other.status == status)&&(identical(other.timeLeft, timeLeft) || other.timeLeft == timeLeft)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,amount,bucketId,status,timeLeft,progress);
}

@override
String toString() {
    return 'WishVm(id: $id, name: $name, amount: $amount, bucketId: $bucketId, status: $status, timeLeft: $timeLeft, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$WishVmCopyWith<$Res> implements $WishVmCopyWith<$Res> {
  factory _$WishVmCopyWith(_WishVm value, $Res Function(_WishVm) _then) = __$WishVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Money amount, String bucketId, WishStatus status, Duration timeLeft, double progress
});




}
/// @nodoc
class __$WishVmCopyWithImpl<$Res>
    implements _$WishVmCopyWith<$Res> {
  __$WishVmCopyWithImpl(this._self, this._then);

  final _WishVm _self;
  final $Res Function(_WishVm) _then;

/// Create a copy of WishVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? bucketId = null,Object? status = null,Object? timeLeft = null,Object? progress = null,}) {
  return _then(_WishVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WishStatus,timeLeft: null == timeLeft ? _self.timeLeft : timeLeft // ignore: cast_nullable_to_non_nullable
as Duration,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
