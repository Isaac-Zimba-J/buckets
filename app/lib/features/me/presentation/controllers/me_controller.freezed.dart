// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'me_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeState {

 List<IncomeVm> get incomes; bool get appLock; int get snoozeLimit; int get coolingOffHours; Money get coolingOffThreshold; bool get autoFile; String? get errorCode;
/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeStateCopyWith<MeState> get copyWith => _$MeStateCopyWithImpl<MeState>(this as MeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeState&&const DeepCollectionEquality().equals(other.incomes, _this.incomes)&&(identical(other.appLock, _this.appLock) || other.appLock == _this.appLock)&&(identical(other.snoozeLimit, _this.snoozeLimit) || other.snoozeLimit == _this.snoozeLimit)&&(identical(other.coolingOffHours, _this.coolingOffHours) || other.coolingOffHours == _this.coolingOffHours)&&(identical(other.coolingOffThreshold, _this.coolingOffThreshold) || other.coolingOffThreshold == _this.coolingOffThreshold)&&(identical(other.autoFile, _this.autoFile) || other.autoFile == _this.autoFile)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as MeState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.incomes),_this.appLock,_this.snoozeLimit,_this.coolingOffHours,_this.coolingOffThreshold,_this.autoFile,_this.errorCode);
}

@override
String toString() {
  final _this = this as MeState;
  return 'MeState(incomes: ${_this.incomes}, appLock: ${_this.appLock}, snoozeLimit: ${_this.snoozeLimit}, coolingOffHours: ${_this.coolingOffHours}, coolingOffThreshold: ${_this.coolingOffThreshold}, autoFile: ${_this.autoFile}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $MeStateCopyWith<$Res>  {
  factory $MeStateCopyWith(MeState value, $Res Function(MeState) _then) = _$MeStateCopyWithImpl;
@useResult
$Res call({
 List<IncomeVm> incomes, bool appLock, int snoozeLimit, int coolingOffHours, Money coolingOffThreshold, bool autoFile, String? errorCode
});




}
/// @nodoc
class _$MeStateCopyWithImpl<$Res>
    implements $MeStateCopyWith<$Res> {
  _$MeStateCopyWithImpl(this._self, this._then);

  final MeState _self;
  final $Res Function(MeState) _then;

/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? incomes = null,Object? appLock = null,Object? snoozeLimit = null,Object? coolingOffHours = null,Object? coolingOffThreshold = null,Object? autoFile = null,Object? errorCode = freezed,}) {
  return _then(MeState(
incomes: null == incomes ? _self.incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<IncomeVm>,appLock: null == appLock ? _self.appLock : appLock // ignore: cast_nullable_to_non_nullable
as bool,snoozeLimit: null == snoozeLimit ? _self.snoozeLimit : snoozeLimit // ignore: cast_nullable_to_non_nullable
as int,coolingOffHours: null == coolingOffHours ? _self.coolingOffHours : coolingOffHours // ignore: cast_nullable_to_non_nullable
as int,coolingOffThreshold: null == coolingOffThreshold ? _self.coolingOffThreshold : coolingOffThreshold // ignore: cast_nullable_to_non_nullable
as Money,autoFile: null == autoFile ? _self.autoFile : autoFile // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeState].
extension MeStatePatterns on MeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeState value)  $default,){
final _that = this;
switch (_that) {
case _MeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeState value)?  $default,){
final _that = this;
switch (_that) {
case _MeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IncomeVm> incomes,  bool appLock,  int snoozeLimit,  int coolingOffHours,  Money coolingOffThreshold,  bool autoFile,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeState() when $default != null:
return $default(_that.incomes,_that.appLock,_that.snoozeLimit,_that.coolingOffHours,_that.coolingOffThreshold,_that.autoFile,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IncomeVm> incomes,  bool appLock,  int snoozeLimit,  int coolingOffHours,  Money coolingOffThreshold,  bool autoFile,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _MeState():
return $default(_that.incomes,_that.appLock,_that.snoozeLimit,_that.coolingOffHours,_that.coolingOffThreshold,_that.autoFile,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IncomeVm> incomes,  bool appLock,  int snoozeLimit,  int coolingOffHours,  Money coolingOffThreshold,  bool autoFile,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _MeState() when $default != null:
return $default(_that.incomes,_that.appLock,_that.snoozeLimit,_that.coolingOffHours,_that.coolingOffThreshold,_that.autoFile,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _MeState implements MeState {
  const _MeState({required  List<IncomeVm> incomes, required this.appLock, required this.snoozeLimit, required this.coolingOffHours, required this.coolingOffThreshold, required this.autoFile, this.errorCode}): _incomes = incomes;
  

 final  List<IncomeVm> _incomes;
@override List<IncomeVm> get incomes {
  if (_incomes is EqualUnmodifiableListView) return _incomes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incomes);
}

@override final  bool appLock;
@override final  int snoozeLimit;
@override final  int coolingOffHours;
@override final  Money coolingOffThreshold;
@override final  bool autoFile;
@override final  String? errorCode;

/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeStateCopyWith<_MeState> get copyWith => __$MeStateCopyWithImpl<_MeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeState&&const DeepCollectionEquality().equals(other.incomes, _incomes)&&(identical(other.appLock, appLock) || other.appLock == appLock)&&(identical(other.snoozeLimit, snoozeLimit) || other.snoozeLimit == snoozeLimit)&&(identical(other.coolingOffHours, coolingOffHours) || other.coolingOffHours == coolingOffHours)&&(identical(other.coolingOffThreshold, coolingOffThreshold) || other.coolingOffThreshold == coolingOffThreshold)&&(identical(other.autoFile, autoFile) || other.autoFile == autoFile)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_incomes),appLock,snoozeLimit,coolingOffHours,coolingOffThreshold,autoFile,errorCode);
}

@override
String toString() {
    return 'MeState(incomes: $incomes, appLock: $appLock, snoozeLimit: $snoozeLimit, coolingOffHours: $coolingOffHours, coolingOffThreshold: $coolingOffThreshold, autoFile: $autoFile, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$MeStateCopyWith<$Res> implements $MeStateCopyWith<$Res> {
  factory _$MeStateCopyWith(_MeState value, $Res Function(_MeState) _then) = __$MeStateCopyWithImpl;
@override @useResult
$Res call({
 List<IncomeVm> incomes, bool appLock, int snoozeLimit, int coolingOffHours, Money coolingOffThreshold, bool autoFile, String? errorCode
});




}
/// @nodoc
class __$MeStateCopyWithImpl<$Res>
    implements _$MeStateCopyWith<$Res> {
  __$MeStateCopyWithImpl(this._self, this._then);

  final _MeState _self;
  final $Res Function(_MeState) _then;

/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? incomes = null,Object? appLock = null,Object? snoozeLimit = null,Object? coolingOffHours = null,Object? coolingOffThreshold = null,Object? autoFile = null,Object? errorCode = freezed,}) {
  return _then(_MeState(
incomes: null == incomes ? _self._incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<IncomeVm>,appLock: null == appLock ? _self.appLock : appLock // ignore: cast_nullable_to_non_nullable
as bool,snoozeLimit: null == snoozeLimit ? _self.snoozeLimit : snoozeLimit // ignore: cast_nullable_to_non_nullable
as int,coolingOffHours: null == coolingOffHours ? _self.coolingOffHours : coolingOffHours // ignore: cast_nullable_to_non_nullable
as int,coolingOffThreshold: null == coolingOffThreshold ? _self.coolingOffThreshold : coolingOffThreshold // ignore: cast_nullable_to_non_nullable
as Money,autoFile: null == autoFile ? _self.autoFile : autoFile // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
