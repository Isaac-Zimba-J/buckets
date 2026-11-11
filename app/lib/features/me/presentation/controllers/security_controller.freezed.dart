// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityState {

 bool get appLock; LockTimeout get lockTimeout; bool get hideAmounts; bool get lockAvailable; String? get errorCode;
/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityStateCopyWith<SecurityState> get copyWith => _$SecurityStateCopyWithImpl<SecurityState>(this as SecurityState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SecurityState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityState&&(identical(other.appLock, _this.appLock) || other.appLock == _this.appLock)&&(identical(other.lockTimeout, _this.lockTimeout) || other.lockTimeout == _this.lockTimeout)&&(identical(other.hideAmounts, _this.hideAmounts) || other.hideAmounts == _this.hideAmounts)&&(identical(other.lockAvailable, _this.lockAvailable) || other.lockAvailable == _this.lockAvailable)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as SecurityState;
  return Object.hash(runtimeType,_this.appLock,_this.lockTimeout,_this.hideAmounts,_this.lockAvailable,_this.errorCode);
}

@override
String toString() {
  final _this = this as SecurityState;
  return 'SecurityState(appLock: ${_this.appLock}, lockTimeout: ${_this.lockTimeout}, hideAmounts: ${_this.hideAmounts}, lockAvailable: ${_this.lockAvailable}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $SecurityStateCopyWith<$Res>  {
  factory $SecurityStateCopyWith(SecurityState value, $Res Function(SecurityState) _then) = _$SecurityStateCopyWithImpl;
@useResult
$Res call({
 bool appLock, LockTimeout lockTimeout, bool hideAmounts, bool lockAvailable, String? errorCode
});




}
/// @nodoc
class _$SecurityStateCopyWithImpl<$Res>
    implements $SecurityStateCopyWith<$Res> {
  _$SecurityStateCopyWithImpl(this._self, this._then);

  final SecurityState _self;
  final $Res Function(SecurityState) _then;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appLock = null,Object? lockTimeout = null,Object? hideAmounts = null,Object? lockAvailable = null,Object? errorCode = freezed,}) {
  return _then(SecurityState(
appLock: null == appLock ? _self.appLock : appLock // ignore: cast_nullable_to_non_nullable
as bool,lockTimeout: null == lockTimeout ? _self.lockTimeout : lockTimeout // ignore: cast_nullable_to_non_nullable
as LockTimeout,hideAmounts: null == hideAmounts ? _self.hideAmounts : hideAmounts // ignore: cast_nullable_to_non_nullable
as bool,lockAvailable: null == lockAvailable ? _self.lockAvailable : lockAvailable // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SecurityState].
extension SecurityStatePatterns on SecurityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecurityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecurityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecurityState value)  $default,){
final _that = this;
switch (_that) {
case _SecurityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecurityState value)?  $default,){
final _that = this;
switch (_that) {
case _SecurityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool appLock,  LockTimeout lockTimeout,  bool hideAmounts,  bool lockAvailable,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecurityState() when $default != null:
return $default(_that.appLock,_that.lockTimeout,_that.hideAmounts,_that.lockAvailable,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool appLock,  LockTimeout lockTimeout,  bool hideAmounts,  bool lockAvailable,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _SecurityState():
return $default(_that.appLock,_that.lockTimeout,_that.hideAmounts,_that.lockAvailable,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool appLock,  LockTimeout lockTimeout,  bool hideAmounts,  bool lockAvailable,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _SecurityState() when $default != null:
return $default(_that.appLock,_that.lockTimeout,_that.hideAmounts,_that.lockAvailable,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _SecurityState implements SecurityState {
  const _SecurityState({required this.appLock, required this.lockTimeout, required this.hideAmounts, required this.lockAvailable, this.errorCode});
  

@override final  bool appLock;
@override final  LockTimeout lockTimeout;
@override final  bool hideAmounts;
@override final  bool lockAvailable;
@override final  String? errorCode;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityStateCopyWith<_SecurityState> get copyWith => __$SecurityStateCopyWithImpl<_SecurityState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityState&&(identical(other.appLock, appLock) || other.appLock == appLock)&&(identical(other.lockTimeout, lockTimeout) || other.lockTimeout == lockTimeout)&&(identical(other.hideAmounts, hideAmounts) || other.hideAmounts == hideAmounts)&&(identical(other.lockAvailable, lockAvailable) || other.lockAvailable == lockAvailable)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,appLock,lockTimeout,hideAmounts,lockAvailable,errorCode);
}

@override
String toString() {
    return 'SecurityState(appLock: $appLock, lockTimeout: $lockTimeout, hideAmounts: $hideAmounts, lockAvailable: $lockAvailable, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$SecurityStateCopyWith<$Res> implements $SecurityStateCopyWith<$Res> {
  factory _$SecurityStateCopyWith(_SecurityState value, $Res Function(_SecurityState) _then) = __$SecurityStateCopyWithImpl;
@override @useResult
$Res call({
 bool appLock, LockTimeout lockTimeout, bool hideAmounts, bool lockAvailable, String? errorCode
});




}
/// @nodoc
class __$SecurityStateCopyWithImpl<$Res>
    implements _$SecurityStateCopyWith<$Res> {
  __$SecurityStateCopyWithImpl(this._self, this._then);

  final _SecurityState _self;
  final $Res Function(_SecurityState) _then;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appLock = null,Object? lockTimeout = null,Object? hideAmounts = null,Object? lockAvailable = null,Object? errorCode = freezed,}) {
  return _then(_SecurityState(
appLock: null == appLock ? _self.appLock : appLock // ignore: cast_nullable_to_non_nullable
as bool,lockTimeout: null == lockTimeout ? _self.lockTimeout : lockTimeout // ignore: cast_nullable_to_non_nullable
as LockTimeout,hideAmounts: null == hideAmounts ? _self.hideAmounts : hideAmounts // ignore: cast_nullable_to_non_nullable
as bool,lockAvailable: null == lockAvailable ? _self.lockAvailable : lockAvailable // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
