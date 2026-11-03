// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_payment_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogPaymentState {

 LogTab get tab; Money? get parsedAmount; String? get parsedCounterparty; bool get suggestWish; bool get saving; bool get saved; String? get errorCode;
/// Create a copy of LogPaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogPaymentStateCopyWith<LogPaymentState> get copyWith => _$LogPaymentStateCopyWithImpl<LogPaymentState>(this as LogPaymentState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LogPaymentState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogPaymentState&&(identical(other.tab, _this.tab) || other.tab == _this.tab)&&(identical(other.parsedAmount, _this.parsedAmount) || other.parsedAmount == _this.parsedAmount)&&(identical(other.parsedCounterparty, _this.parsedCounterparty) || other.parsedCounterparty == _this.parsedCounterparty)&&(identical(other.suggestWish, _this.suggestWish) || other.suggestWish == _this.suggestWish)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as LogPaymentState;
  return Object.hash(runtimeType,_this.tab,_this.parsedAmount,_this.parsedCounterparty,_this.suggestWish,_this.saving,_this.saved,_this.errorCode);
}

@override
String toString() {
  final _this = this as LogPaymentState;
  return 'LogPaymentState(tab: ${_this.tab}, parsedAmount: ${_this.parsedAmount}, parsedCounterparty: ${_this.parsedCounterparty}, suggestWish: ${_this.suggestWish}, saving: ${_this.saving}, saved: ${_this.saved}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $LogPaymentStateCopyWith<$Res>  {
  factory $LogPaymentStateCopyWith(LogPaymentState value, $Res Function(LogPaymentState) _then) = _$LogPaymentStateCopyWithImpl;
@useResult
$Res call({
 LogTab tab, Money? parsedAmount, String? parsedCounterparty, bool suggestWish, bool saving, bool saved, String? errorCode
});




}
/// @nodoc
class _$LogPaymentStateCopyWithImpl<$Res>
    implements $LogPaymentStateCopyWith<$Res> {
  _$LogPaymentStateCopyWithImpl(this._self, this._then);

  final LogPaymentState _self;
  final $Res Function(LogPaymentState) _then;

/// Create a copy of LogPaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tab = null,Object? parsedAmount = freezed,Object? parsedCounterparty = freezed,Object? suggestWish = null,Object? saving = null,Object? saved = null,Object? errorCode = freezed,}) {
  return _then(LogPaymentState(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as LogTab,parsedAmount: freezed == parsedAmount ? _self.parsedAmount : parsedAmount // ignore: cast_nullable_to_non_nullable
as Money?,parsedCounterparty: freezed == parsedCounterparty ? _self.parsedCounterparty : parsedCounterparty // ignore: cast_nullable_to_non_nullable
as String?,suggestWish: null == suggestWish ? _self.suggestWish : suggestWish // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LogPaymentState].
extension LogPaymentStatePatterns on LogPaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LogPaymentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogPaymentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LogPaymentState value)  $default,){
final _that = this;
switch (_that) {
case _LogPaymentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LogPaymentState value)?  $default,){
final _that = this;
switch (_that) {
case _LogPaymentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LogTab tab,  Money? parsedAmount,  String? parsedCounterparty,  bool suggestWish,  bool saving,  bool saved,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogPaymentState() when $default != null:
return $default(_that.tab,_that.parsedAmount,_that.parsedCounterparty,_that.suggestWish,_that.saving,_that.saved,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LogTab tab,  Money? parsedAmount,  String? parsedCounterparty,  bool suggestWish,  bool saving,  bool saved,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _LogPaymentState():
return $default(_that.tab,_that.parsedAmount,_that.parsedCounterparty,_that.suggestWish,_that.saving,_that.saved,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LogTab tab,  Money? parsedAmount,  String? parsedCounterparty,  bool suggestWish,  bool saving,  bool saved,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _LogPaymentState() when $default != null:
return $default(_that.tab,_that.parsedAmount,_that.parsedCounterparty,_that.suggestWish,_that.saving,_that.saved,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _LogPaymentState implements LogPaymentState {
  const _LogPaymentState({this.tab = LogTab.cash, this.parsedAmount, this.parsedCounterparty, this.suggestWish = false, this.saving = false, this.saved = false, this.errorCode});
  

@override@JsonKey() final  LogTab tab;
@override final  Money? parsedAmount;
@override final  String? parsedCounterparty;
@override@JsonKey() final  bool suggestWish;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool saved;
@override final  String? errorCode;

/// Create a copy of LogPaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogPaymentStateCopyWith<_LogPaymentState> get copyWith => __$LogPaymentStateCopyWithImpl<_LogPaymentState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogPaymentState&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.parsedAmount, parsedAmount) || other.parsedAmount == parsedAmount)&&(identical(other.parsedCounterparty, parsedCounterparty) || other.parsedCounterparty == parsedCounterparty)&&(identical(other.suggestWish, suggestWish) || other.suggestWish == suggestWish)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,tab,parsedAmount,parsedCounterparty,suggestWish,saving,saved,errorCode);
}

@override
String toString() {
    return 'LogPaymentState(tab: $tab, parsedAmount: $parsedAmount, parsedCounterparty: $parsedCounterparty, suggestWish: $suggestWish, saving: $saving, saved: $saved, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$LogPaymentStateCopyWith<$Res> implements $LogPaymentStateCopyWith<$Res> {
  factory _$LogPaymentStateCopyWith(_LogPaymentState value, $Res Function(_LogPaymentState) _then) = __$LogPaymentStateCopyWithImpl;
@override @useResult
$Res call({
 LogTab tab, Money? parsedAmount, String? parsedCounterparty, bool suggestWish, bool saving, bool saved, String? errorCode
});




}
/// @nodoc
class __$LogPaymentStateCopyWithImpl<$Res>
    implements _$LogPaymentStateCopyWith<$Res> {
  __$LogPaymentStateCopyWithImpl(this._self, this._then);

  final _LogPaymentState _self;
  final $Res Function(_LogPaymentState) _then;

/// Create a copy of LogPaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? parsedAmount = freezed,Object? parsedCounterparty = freezed,Object? suggestWish = null,Object? saving = null,Object? saved = null,Object? errorCode = freezed,}) {
  return _then(_LogPaymentState(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as LogTab,parsedAmount: freezed == parsedAmount ? _self.parsedAmount : parsedAmount // ignore: cast_nullable_to_non_nullable
as Money?,parsedCounterparty: freezed == parsedCounterparty ? _self.parsedCounterparty : parsedCounterparty // ignore: cast_nullable_to_non_nullable
as String?,suggestWish: null == suggestWish ? _self.suggestWish : suggestWish // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
