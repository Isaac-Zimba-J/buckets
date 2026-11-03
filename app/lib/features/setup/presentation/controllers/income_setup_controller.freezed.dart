// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_setup_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomeSetupState {

 List<IncomeVm> get incomes; bool get saving; String? get errorCode;
/// Create a copy of IncomeSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeSetupStateCopyWith<IncomeSetupState> get copyWith => _$IncomeSetupStateCopyWithImpl<IncomeSetupState>(this as IncomeSetupState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as IncomeSetupState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeSetupState&&const DeepCollectionEquality().equals(other.incomes, _this.incomes)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as IncomeSetupState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.incomes),_this.saving,_this.errorCode);
}

@override
String toString() {
  final _this = this as IncomeSetupState;
  return 'IncomeSetupState(incomes: ${_this.incomes}, saving: ${_this.saving}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $IncomeSetupStateCopyWith<$Res>  {
  factory $IncomeSetupStateCopyWith(IncomeSetupState value, $Res Function(IncomeSetupState) _then) = _$IncomeSetupStateCopyWithImpl;
@useResult
$Res call({
 List<IncomeVm> incomes, bool saving, String? errorCode
});




}
/// @nodoc
class _$IncomeSetupStateCopyWithImpl<$Res>
    implements $IncomeSetupStateCopyWith<$Res> {
  _$IncomeSetupStateCopyWithImpl(this._self, this._then);

  final IncomeSetupState _self;
  final $Res Function(IncomeSetupState) _then;

/// Create a copy of IncomeSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? incomes = null,Object? saving = null,Object? errorCode = freezed,}) {
  return _then(IncomeSetupState(
incomes: null == incomes ? _self.incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<IncomeVm>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeSetupState].
extension IncomeSetupStatePatterns on IncomeSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeSetupState value)  $default,){
final _that = this;
switch (_that) {
case _IncomeSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IncomeVm> incomes,  bool saving,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeSetupState() when $default != null:
return $default(_that.incomes,_that.saving,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IncomeVm> incomes,  bool saving,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _IncomeSetupState():
return $default(_that.incomes,_that.saving,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IncomeVm> incomes,  bool saving,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _IncomeSetupState() when $default != null:
return $default(_that.incomes,_that.saving,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _IncomeSetupState implements IncomeSetupState {
  const _IncomeSetupState({required  List<IncomeVm> incomes, this.saving = false, this.errorCode}): _incomes = incomes;
  

 final  List<IncomeVm> _incomes;
@override List<IncomeVm> get incomes {
  if (_incomes is EqualUnmodifiableListView) return _incomes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incomes);
}

@override@JsonKey() final  bool saving;
@override final  String? errorCode;

/// Create a copy of IncomeSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeSetupStateCopyWith<_IncomeSetupState> get copyWith => __$IncomeSetupStateCopyWithImpl<_IncomeSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeSetupState&&const DeepCollectionEquality().equals(other.incomes, _incomes)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_incomes),saving,errorCode);
}

@override
String toString() {
    return 'IncomeSetupState(incomes: $incomes, saving: $saving, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$IncomeSetupStateCopyWith<$Res> implements $IncomeSetupStateCopyWith<$Res> {
  factory _$IncomeSetupStateCopyWith(_IncomeSetupState value, $Res Function(_IncomeSetupState) _then) = __$IncomeSetupStateCopyWithImpl;
@override @useResult
$Res call({
 List<IncomeVm> incomes, bool saving, String? errorCode
});




}
/// @nodoc
class __$IncomeSetupStateCopyWithImpl<$Res>
    implements _$IncomeSetupStateCopyWith<$Res> {
  __$IncomeSetupStateCopyWithImpl(this._self, this._then);

  final _IncomeSetupState _self;
  final $Res Function(_IncomeSetupState) _then;

/// Create a copy of IncomeSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? incomes = null,Object? saving = null,Object? errorCode = freezed,}) {
  return _then(_IncomeSetupState(
incomes: null == incomes ? _self._incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<IncomeVm>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
