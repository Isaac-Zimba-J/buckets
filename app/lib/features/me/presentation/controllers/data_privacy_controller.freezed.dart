// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_privacy_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DataPrivacyState {

 StorageSummary get storage; String? get errorCode;
/// Create a copy of DataPrivacyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataPrivacyStateCopyWith<DataPrivacyState> get copyWith => _$DataPrivacyStateCopyWithImpl<DataPrivacyState>(this as DataPrivacyState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DataPrivacyState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataPrivacyState&&(identical(other.storage, _this.storage) || other.storage == _this.storage)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as DataPrivacyState;
  return Object.hash(runtimeType,_this.storage,_this.errorCode);
}

@override
String toString() {
  final _this = this as DataPrivacyState;
  return 'DataPrivacyState(storage: ${_this.storage}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $DataPrivacyStateCopyWith<$Res>  {
  factory $DataPrivacyStateCopyWith(DataPrivacyState value, $Res Function(DataPrivacyState) _then) = _$DataPrivacyStateCopyWithImpl;
@useResult
$Res call({
 StorageSummary storage, String? errorCode
});




}
/// @nodoc
class _$DataPrivacyStateCopyWithImpl<$Res>
    implements $DataPrivacyStateCopyWith<$Res> {
  _$DataPrivacyStateCopyWithImpl(this._self, this._then);

  final DataPrivacyState _self;
  final $Res Function(DataPrivacyState) _then;

/// Create a copy of DataPrivacyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storage = null,Object? errorCode = freezed,}) {
  return _then(DataPrivacyState(
storage: null == storage ? _self.storage : storage // ignore: cast_nullable_to_non_nullable
as StorageSummary,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DataPrivacyState].
extension DataPrivacyStatePatterns on DataPrivacyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DataPrivacyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DataPrivacyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DataPrivacyState value)  $default,){
final _that = this;
switch (_that) {
case _DataPrivacyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DataPrivacyState value)?  $default,){
final _that = this;
switch (_that) {
case _DataPrivacyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StorageSummary storage,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DataPrivacyState() when $default != null:
return $default(_that.storage,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StorageSummary storage,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _DataPrivacyState():
return $default(_that.storage,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StorageSummary storage,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _DataPrivacyState() when $default != null:
return $default(_that.storage,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _DataPrivacyState implements DataPrivacyState {
  const _DataPrivacyState({required this.storage, this.errorCode});
  

@override final  StorageSummary storage;
@override final  String? errorCode;

/// Create a copy of DataPrivacyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataPrivacyStateCopyWith<_DataPrivacyState> get copyWith => __$DataPrivacyStateCopyWithImpl<_DataPrivacyState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DataPrivacyState&&(identical(other.storage, storage) || other.storage == storage)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,storage,errorCode);
}

@override
String toString() {
    return 'DataPrivacyState(storage: $storage, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$DataPrivacyStateCopyWith<$Res> implements $DataPrivacyStateCopyWith<$Res> {
  factory _$DataPrivacyStateCopyWith(_DataPrivacyState value, $Res Function(_DataPrivacyState) _then) = __$DataPrivacyStateCopyWithImpl;
@override @useResult
$Res call({
 StorageSummary storage, String? errorCode
});




}
/// @nodoc
class __$DataPrivacyStateCopyWithImpl<$Res>
    implements _$DataPrivacyStateCopyWith<$Res> {
  __$DataPrivacyStateCopyWithImpl(this._self, this._then);

  final _DataPrivacyState _self;
  final $Res Function(_DataPrivacyState) _then;

/// Create a copy of DataPrivacyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storage = null,Object? errorCode = freezed,}) {
  return _then(_DataPrivacyState(
storage: null == storage ? _self.storage : storage // ignore: cast_nullable_to_non_nullable
as StorageSummary,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
