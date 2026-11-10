// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payday_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaydayState {

 String get paydayId; List<TransferRowVm> get transfers; int get done; Money get left; bool get complete; bool get snoozed; int get snoozesLeft; Money get total; DateTime? get startedAt; DateTime? get snoozeUntil; DateTime? get snoozedUntil; String? get errorCode;
/// Create a copy of PaydayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaydayStateCopyWith<PaydayState> get copyWith => _$PaydayStateCopyWithImpl<PaydayState>(this as PaydayState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PaydayState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaydayState&&(identical(other.paydayId, _this.paydayId) || other.paydayId == _this.paydayId)&&const DeepCollectionEquality().equals(other.transfers, _this.transfers)&&(identical(other.done, _this.done) || other.done == _this.done)&&(identical(other.left, _this.left) || other.left == _this.left)&&(identical(other.complete, _this.complete) || other.complete == _this.complete)&&(identical(other.snoozed, _this.snoozed) || other.snoozed == _this.snoozed)&&(identical(other.snoozesLeft, _this.snoozesLeft) || other.snoozesLeft == _this.snoozesLeft)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.snoozeUntil, _this.snoozeUntil) || other.snoozeUntil == _this.snoozeUntil)&&(identical(other.snoozedUntil, _this.snoozedUntil) || other.snoozedUntil == _this.snoozedUntil)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as PaydayState;
  return Object.hash(runtimeType,_this.paydayId,const DeepCollectionEquality().hash(_this.transfers),_this.done,_this.left,_this.complete,_this.snoozed,_this.snoozesLeft,_this.total,_this.startedAt,_this.snoozeUntil,_this.snoozedUntil,_this.errorCode);
}

@override
String toString() {
  final _this = this as PaydayState;
  return 'PaydayState(paydayId: ${_this.paydayId}, transfers: ${_this.transfers}, done: ${_this.done}, left: ${_this.left}, complete: ${_this.complete}, snoozed: ${_this.snoozed}, snoozesLeft: ${_this.snoozesLeft}, total: ${_this.total}, startedAt: ${_this.startedAt}, snoozeUntil: ${_this.snoozeUntil}, snoozedUntil: ${_this.snoozedUntil}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $PaydayStateCopyWith<$Res>  {
  factory $PaydayStateCopyWith(PaydayState value, $Res Function(PaydayState) _then) = _$PaydayStateCopyWithImpl;
@useResult
$Res call({
 String paydayId, List<TransferRowVm> transfers, int done, Money left, bool complete, bool snoozed, int snoozesLeft, Money total, DateTime? startedAt, DateTime? snoozeUntil, DateTime? snoozedUntil, String? errorCode
});




}
/// @nodoc
class _$PaydayStateCopyWithImpl<$Res>
    implements $PaydayStateCopyWith<$Res> {
  _$PaydayStateCopyWithImpl(this._self, this._then);

  final PaydayState _self;
  final $Res Function(PaydayState) _then;

/// Create a copy of PaydayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paydayId = null,Object? transfers = null,Object? done = null,Object? left = null,Object? complete = null,Object? snoozed = null,Object? snoozesLeft = null,Object? total = null,Object? startedAt = freezed,Object? snoozeUntil = freezed,Object? snoozedUntil = freezed,Object? errorCode = freezed,}) {
  return _then(PaydayState(
paydayId: null == paydayId ? _self.paydayId : paydayId // ignore: cast_nullable_to_non_nullable
as String,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as List<TransferRowVm>,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as Money,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,snoozed: null == snoozed ? _self.snoozed : snoozed // ignore: cast_nullable_to_non_nullable
as bool,snoozesLeft: null == snoozesLeft ? _self.snoozesLeft : snoozesLeft // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,snoozeUntil: freezed == snoozeUntil ? _self.snoozeUntil : snoozeUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,snoozedUntil: freezed == snoozedUntil ? _self.snoozedUntil : snoozedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaydayState].
extension PaydayStatePatterns on PaydayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaydayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaydayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaydayState value)  $default,){
final _that = this;
switch (_that) {
case _PaydayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaydayState value)?  $default,){
final _that = this;
switch (_that) {
case _PaydayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paydayId,  List<TransferRowVm> transfers,  int done,  Money left,  bool complete,  bool snoozed,  int snoozesLeft,  Money total,  DateTime? startedAt,  DateTime? snoozeUntil,  DateTime? snoozedUntil,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaydayState() when $default != null:
return $default(_that.paydayId,_that.transfers,_that.done,_that.left,_that.complete,_that.snoozed,_that.snoozesLeft,_that.total,_that.startedAt,_that.snoozeUntil,_that.snoozedUntil,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paydayId,  List<TransferRowVm> transfers,  int done,  Money left,  bool complete,  bool snoozed,  int snoozesLeft,  Money total,  DateTime? startedAt,  DateTime? snoozeUntil,  DateTime? snoozedUntil,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _PaydayState():
return $default(_that.paydayId,_that.transfers,_that.done,_that.left,_that.complete,_that.snoozed,_that.snoozesLeft,_that.total,_that.startedAt,_that.snoozeUntil,_that.snoozedUntil,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paydayId,  List<TransferRowVm> transfers,  int done,  Money left,  bool complete,  bool snoozed,  int snoozesLeft,  Money total,  DateTime? startedAt,  DateTime? snoozeUntil,  DateTime? snoozedUntil,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _PaydayState() when $default != null:
return $default(_that.paydayId,_that.transfers,_that.done,_that.left,_that.complete,_that.snoozed,_that.snoozesLeft,_that.total,_that.startedAt,_that.snoozeUntil,_that.snoozedUntil,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _PaydayState implements PaydayState {
  const _PaydayState({required this.paydayId, required  List<TransferRowVm> transfers, required this.done, required this.left, required this.complete, required this.snoozed, required this.snoozesLeft, this.total = Money.zero, this.startedAt, this.snoozeUntil, this.snoozedUntil, this.errorCode}): _transfers = transfers;
  

@override final  String paydayId;
 final  List<TransferRowVm> _transfers;
@override List<TransferRowVm> get transfers {
  if (_transfers is EqualUnmodifiableListView) return _transfers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transfers);
}

@override final  int done;
@override final  Money left;
@override final  bool complete;
@override final  bool snoozed;
@override final  int snoozesLeft;
@override@JsonKey() final  Money total;
@override final  DateTime? startedAt;
@override final  DateTime? snoozeUntil;
@override final  DateTime? snoozedUntil;
@override final  String? errorCode;

/// Create a copy of PaydayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaydayStateCopyWith<_PaydayState> get copyWith => __$PaydayStateCopyWithImpl<_PaydayState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaydayState&&(identical(other.paydayId, paydayId) || other.paydayId == paydayId)&&const DeepCollectionEquality().equals(other.transfers, _transfers)&&(identical(other.done, done) || other.done == done)&&(identical(other.left, left) || other.left == left)&&(identical(other.complete, complete) || other.complete == complete)&&(identical(other.snoozed, snoozed) || other.snoozed == snoozed)&&(identical(other.snoozesLeft, snoozesLeft) || other.snoozesLeft == snoozesLeft)&&(identical(other.total, total) || other.total == total)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.snoozeUntil, snoozeUntil) || other.snoozeUntil == snoozeUntil)&&(identical(other.snoozedUntil, snoozedUntil) || other.snoozedUntil == snoozedUntil)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,paydayId,const DeepCollectionEquality().hash(_transfers),done,left,complete,snoozed,snoozesLeft,total,startedAt,snoozeUntil,snoozedUntil,errorCode);
}

@override
String toString() {
    return 'PaydayState(paydayId: $paydayId, transfers: $transfers, done: $done, left: $left, complete: $complete, snoozed: $snoozed, snoozesLeft: $snoozesLeft, total: $total, startedAt: $startedAt, snoozeUntil: $snoozeUntil, snoozedUntil: $snoozedUntil, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$PaydayStateCopyWith<$Res> implements $PaydayStateCopyWith<$Res> {
  factory _$PaydayStateCopyWith(_PaydayState value, $Res Function(_PaydayState) _then) = __$PaydayStateCopyWithImpl;
@override @useResult
$Res call({
 String paydayId, List<TransferRowVm> transfers, int done, Money left, bool complete, bool snoozed, int snoozesLeft, Money total, DateTime? startedAt, DateTime? snoozeUntil, DateTime? snoozedUntil, String? errorCode
});




}
/// @nodoc
class __$PaydayStateCopyWithImpl<$Res>
    implements _$PaydayStateCopyWith<$Res> {
  __$PaydayStateCopyWithImpl(this._self, this._then);

  final _PaydayState _self;
  final $Res Function(_PaydayState) _then;

/// Create a copy of PaydayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paydayId = null,Object? transfers = null,Object? done = null,Object? left = null,Object? complete = null,Object? snoozed = null,Object? snoozesLeft = null,Object? total = null,Object? startedAt = freezed,Object? snoozeUntil = freezed,Object? snoozedUntil = freezed,Object? errorCode = freezed,}) {
  return _then(_PaydayState(
paydayId: null == paydayId ? _self.paydayId : paydayId // ignore: cast_nullable_to_non_nullable
as String,transfers: null == transfers ? _self._transfers : transfers // ignore: cast_nullable_to_non_nullable
as List<TransferRowVm>,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as Money,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,snoozed: null == snoozed ? _self.snoozed : snoozed // ignore: cast_nullable_to_non_nullable
as bool,snoozesLeft: null == snoozesLeft ? _self.snoozesLeft : snoozesLeft // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,snoozeUntil: freezed == snoozeUntil ? _self.snoozeUntil : snoozeUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,snoozedUntil: freezed == snoozedUntil ? _self.snoozedUntil : snoozedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
