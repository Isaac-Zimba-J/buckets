// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileFormState {

 String get displayName; Greeting get greeting; String get timeZone; bool get saving; String? get errorCode;
/// Create a copy of ProfileFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileFormStateCopyWith<ProfileFormState> get copyWith => _$ProfileFormStateCopyWithImpl<ProfileFormState>(this as ProfileFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileFormState&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.greeting, _this.greeting) || other.greeting == _this.greeting)&&(identical(other.timeZone, _this.timeZone) || other.timeZone == _this.timeZone)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as ProfileFormState;
  return Object.hash(runtimeType,_this.displayName,_this.greeting,_this.timeZone,_this.saving,_this.errorCode);
}

@override
String toString() {
  final _this = this as ProfileFormState;
  return 'ProfileFormState(displayName: ${_this.displayName}, greeting: ${_this.greeting}, timeZone: ${_this.timeZone}, saving: ${_this.saving}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $ProfileFormStateCopyWith<$Res>  {
  factory $ProfileFormStateCopyWith(ProfileFormState value, $Res Function(ProfileFormState) _then) = _$ProfileFormStateCopyWithImpl;
@useResult
$Res call({
 String displayName, Greeting greeting, String timeZone, bool saving, String? errorCode
});




}
/// @nodoc
class _$ProfileFormStateCopyWithImpl<$Res>
    implements $ProfileFormStateCopyWith<$Res> {
  _$ProfileFormStateCopyWithImpl(this._self, this._then);

  final ProfileFormState _self;
  final $Res Function(ProfileFormState) _then;

/// Create a copy of ProfileFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? greeting = null,Object? timeZone = null,Object? saving = null,Object? errorCode = freezed,}) {
  return _then(ProfileFormState(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,greeting: null == greeting ? _self.greeting : greeting // ignore: cast_nullable_to_non_nullable
as Greeting,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileFormState].
extension ProfileFormStatePatterns on ProfileFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileFormState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileFormState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  Greeting greeting,  String timeZone,  bool saving,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileFormState() when $default != null:
return $default(_that.displayName,_that.greeting,_that.timeZone,_that.saving,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  Greeting greeting,  String timeZone,  bool saving,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _ProfileFormState():
return $default(_that.displayName,_that.greeting,_that.timeZone,_that.saving,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  Greeting greeting,  String timeZone,  bool saving,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _ProfileFormState() when $default != null:
return $default(_that.displayName,_that.greeting,_that.timeZone,_that.saving,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileFormState implements ProfileFormState {
  const _ProfileFormState({required this.displayName, required this.greeting, required this.timeZone, this.saving = false, this.errorCode});
  

@override final  String displayName;
@override final  Greeting greeting;
@override final  String timeZone;
@override@JsonKey() final  bool saving;
@override final  String? errorCode;

/// Create a copy of ProfileFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileFormStateCopyWith<_ProfileFormState> get copyWith => __$ProfileFormStateCopyWithImpl<_ProfileFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileFormState&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.greeting, greeting) || other.greeting == greeting)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,displayName,greeting,timeZone,saving,errorCode);
}

@override
String toString() {
    return 'ProfileFormState(displayName: $displayName, greeting: $greeting, timeZone: $timeZone, saving: $saving, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$ProfileFormStateCopyWith<$Res> implements $ProfileFormStateCopyWith<$Res> {
  factory _$ProfileFormStateCopyWith(_ProfileFormState value, $Res Function(_ProfileFormState) _then) = __$ProfileFormStateCopyWithImpl;
@override @useResult
$Res call({
 String displayName, Greeting greeting, String timeZone, bool saving, String? errorCode
});




}
/// @nodoc
class __$ProfileFormStateCopyWithImpl<$Res>
    implements _$ProfileFormStateCopyWith<$Res> {
  __$ProfileFormStateCopyWithImpl(this._self, this._then);

  final _ProfileFormState _self;
  final $Res Function(_ProfileFormState) _then;

/// Create a copy of ProfileFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? greeting = null,Object? timeZone = null,Object? saving = null,Object? errorCode = freezed,}) {
  return _then(_ProfileFormState(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,greeting: null == greeting ? _self.greeting : greeting // ignore: cast_nullable_to_non_nullable
as Greeting,timeZone: null == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
