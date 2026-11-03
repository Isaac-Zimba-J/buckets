// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_alerts_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlertVm {

 String get id; Money? get amount; Money? get fee; String? get counterparty; DateTime get receivedAt;
/// Create a copy of AlertVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertVmCopyWith<AlertVm> get copyWith => _$AlertVmCopyWithImpl<AlertVm>(this as AlertVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AlertVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.fee, _this.fee) || other.fee == _this.fee)&&(identical(other.counterparty, _this.counterparty) || other.counterparty == _this.counterparty)&&(identical(other.receivedAt, _this.receivedAt) || other.receivedAt == _this.receivedAt));
}


@override
int get hashCode {
  final _this = this as AlertVm;
  return Object.hash(runtimeType,_this.id,_this.amount,_this.fee,_this.counterparty,_this.receivedAt);
}

@override
String toString() {
  final _this = this as AlertVm;
  return 'AlertVm(id: ${_this.id}, amount: ${_this.amount}, fee: ${_this.fee}, counterparty: ${_this.counterparty}, receivedAt: ${_this.receivedAt})';
}


}

/// @nodoc
abstract mixin class $AlertVmCopyWith<$Res>  {
  factory $AlertVmCopyWith(AlertVm value, $Res Function(AlertVm) _then) = _$AlertVmCopyWithImpl;
@useResult
$Res call({
 String id, Money? amount, Money? fee, String? counterparty, DateTime receivedAt
});




}
/// @nodoc
class _$AlertVmCopyWithImpl<$Res>
    implements $AlertVmCopyWith<$Res> {
  _$AlertVmCopyWithImpl(this._self, this._then);

  final AlertVm _self;
  final $Res Function(AlertVm) _then;

/// Create a copy of AlertVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = freezed,Object? fee = freezed,Object? counterparty = freezed,Object? receivedAt = null,}) {
  return _then(AlertVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money?,counterparty: freezed == counterparty ? _self.counterparty : counterparty // ignore: cast_nullable_to_non_nullable
as String?,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AlertVm].
extension AlertVmPatterns on AlertVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlertVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlertVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlertVm value)  $default,){
final _that = this;
switch (_that) {
case _AlertVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlertVm value)?  $default,){
final _that = this;
switch (_that) {
case _AlertVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Money? amount,  Money? fee,  String? counterparty,  DateTime receivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlertVm() when $default != null:
return $default(_that.id,_that.amount,_that.fee,_that.counterparty,_that.receivedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Money? amount,  Money? fee,  String? counterparty,  DateTime receivedAt)  $default,) {final _that = this;
switch (_that) {
case _AlertVm():
return $default(_that.id,_that.amount,_that.fee,_that.counterparty,_that.receivedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Money? amount,  Money? fee,  String? counterparty,  DateTime receivedAt)?  $default,) {final _that = this;
switch (_that) {
case _AlertVm() when $default != null:
return $default(_that.id,_that.amount,_that.fee,_that.counterparty,_that.receivedAt);case _:
  return null;

}
}

}

/// @nodoc


class _AlertVm implements AlertVm {
  const _AlertVm({required this.id, required this.amount, required this.fee, required this.counterparty, required this.receivedAt});
  

@override final  String id;
@override final  Money? amount;
@override final  Money? fee;
@override final  String? counterparty;
@override final  DateTime receivedAt;

/// Create a copy of AlertVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertVmCopyWith<_AlertVm> get copyWith => __$AlertVmCopyWithImpl<_AlertVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertVm&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.counterparty, counterparty) || other.counterparty == counterparty)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,amount,fee,counterparty,receivedAt);
}

@override
String toString() {
    return 'AlertVm(id: $id, amount: $amount, fee: $fee, counterparty: $counterparty, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class _$AlertVmCopyWith<$Res> implements $AlertVmCopyWith<$Res> {
  factory _$AlertVmCopyWith(_AlertVm value, $Res Function(_AlertVm) _then) = __$AlertVmCopyWithImpl;
@override @useResult
$Res call({
 String id, Money? amount, Money? fee, String? counterparty, DateTime receivedAt
});




}
/// @nodoc
class __$AlertVmCopyWithImpl<$Res>
    implements _$AlertVmCopyWith<$Res> {
  __$AlertVmCopyWithImpl(this._self, this._then);

  final _AlertVm _self;
  final $Res Function(_AlertVm) _then;

/// Create a copy of AlertVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = freezed,Object? fee = freezed,Object? counterparty = freezed,Object? receivedAt = null,}) {
  return _then(_AlertVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as Money?,counterparty: freezed == counterparty ? _self.counterparty : counterparty // ignore: cast_nullable_to_non_nullable
as String?,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$SortAlertsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SortAlertsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SortAlertsState()';
}


}

/// @nodoc
class $SortAlertsStateCopyWith<$Res>  {
$SortAlertsStateCopyWith(SortAlertsState _, $Res Function(SortAlertsState) __);
}


/// Adds pattern-matching-related methods to [SortAlertsState].
extension SortAlertsStatePatterns on SortAlertsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SortNext value)?  next,TResult Function( SortNone value)?  none,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SortNext() when next != null:
return next(_that);case SortNone() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SortNext value)  next,required TResult Function( SortNone value)  none,}){
final _that = this;
switch (_that) {
case SortNext():
return next(_that);case SortNone():
return none(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SortNext value)?  next,TResult? Function( SortNone value)?  none,}){
final _that = this;
switch (_that) {
case SortNext() when next != null:
return next(_that);case SortNone() when none != null:
return none(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AlertVm alert,  Category? category,  String? bucketId,  int remaining,  bool isLast,  String? errorCode)?  next,TResult Function()?  none,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SortNext() when next != null:
return next(_that.alert,_that.category,_that.bucketId,_that.remaining,_that.isLast,_that.errorCode);case SortNone() when none != null:
return none();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AlertVm alert,  Category? category,  String? bucketId,  int remaining,  bool isLast,  String? errorCode)  next,required TResult Function()  none,}) {final _that = this;
switch (_that) {
case SortNext():
return next(_that.alert,_that.category,_that.bucketId,_that.remaining,_that.isLast,_that.errorCode);case SortNone():
return none();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AlertVm alert,  Category? category,  String? bucketId,  int remaining,  bool isLast,  String? errorCode)?  next,TResult? Function()?  none,}) {final _that = this;
switch (_that) {
case SortNext() when next != null:
return next(_that.alert,_that.category,_that.bucketId,_that.remaining,_that.isLast,_that.errorCode);case SortNone() when none != null:
return none();case _:
  return null;

}
}

}

/// @nodoc


class SortNext implements SortAlertsState {
  const SortNext({required this.alert, required this.category, required this.bucketId, required this.remaining, required this.isLast, this.errorCode});
  

 final  AlertVm alert;
 final  Category? category;
 final  String? bucketId;
 final  int remaining;
 final  bool isLast;
 final  String? errorCode;

/// Create a copy of SortAlertsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SortNextCopyWith<SortNext> get copyWith => _$SortNextCopyWithImpl<SortNext>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SortNext&&(identical(other.alert, alert) || other.alert == alert)&&(identical(other.category, category) || other.category == category)&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.remaining, remaining) || other.remaining == remaining)&&(identical(other.isLast, isLast) || other.isLast == isLast)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,alert,category,bucketId,remaining,isLast,errorCode);
}

@override
String toString() {
    return 'SortAlertsState.next(alert: $alert, category: $category, bucketId: $bucketId, remaining: $remaining, isLast: $isLast, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $SortNextCopyWith<$Res> implements $SortAlertsStateCopyWith<$Res> {
  factory $SortNextCopyWith(SortNext value, $Res Function(SortNext) _then) = _$SortNextCopyWithImpl;
@useResult
$Res call({
 AlertVm alert, Category? category, String? bucketId, int remaining, bool isLast, String? errorCode
});


$AlertVmCopyWith<$Res> get alert;

}
/// @nodoc
class _$SortNextCopyWithImpl<$Res>
    implements $SortNextCopyWith<$Res> {
  _$SortNextCopyWithImpl(this._self, this._then);

  final SortNext _self;
  final $Res Function(SortNext) _then;

/// Create a copy of SortAlertsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? alert = null,Object? category = freezed,Object? bucketId = freezed,Object? remaining = null,Object? isLast = null,Object? errorCode = freezed,}) {
  return _then(SortNext(
alert: null == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as AlertVm,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category?,bucketId: freezed == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String?,remaining: null == remaining ? _self.remaining : remaining // ignore: cast_nullable_to_non_nullable
as int,isLast: null == isLast ? _self.isLast : isLast // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SortAlertsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertVmCopyWith<$Res> get alert {
  
  return $AlertVmCopyWith<$Res>(_self.alert, (value) {
    return _then(_self.copyWith(alert: value));
  });
}
}

/// @nodoc


class SortNone implements SortAlertsState {
  const SortNone();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SortNone);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SortAlertsState.none()';
}


}




// dart format on
