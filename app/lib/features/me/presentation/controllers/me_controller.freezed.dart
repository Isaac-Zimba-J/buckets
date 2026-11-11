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

 ProfileSummary get summary; List<IncomeVm> get incomes;
/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeStateCopyWith<MeState> get copyWith => _$MeStateCopyWithImpl<MeState>(this as MeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeState&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.incomes, _this.incomes));
}


@override
int get hashCode {
  final _this = this as MeState;
  return Object.hash(runtimeType,_this.summary,const DeepCollectionEquality().hash(_this.incomes));
}

@override
String toString() {
  final _this = this as MeState;
  return 'MeState(summary: ${_this.summary}, incomes: ${_this.incomes})';
}


}

/// @nodoc
abstract mixin class $MeStateCopyWith<$Res>  {
  factory $MeStateCopyWith(MeState value, $Res Function(MeState) _then) = _$MeStateCopyWithImpl;
@useResult
$Res call({
 ProfileSummary summary, List<IncomeVm> incomes
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
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? incomes = null,}) {
  return _then(MeState(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProfileSummary,incomes: null == incomes ? _self.incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<IncomeVm>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileSummary summary,  List<IncomeVm> incomes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeState() when $default != null:
return $default(_that.summary,_that.incomes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileSummary summary,  List<IncomeVm> incomes)  $default,) {final _that = this;
switch (_that) {
case _MeState():
return $default(_that.summary,_that.incomes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileSummary summary,  List<IncomeVm> incomes)?  $default,) {final _that = this;
switch (_that) {
case _MeState() when $default != null:
return $default(_that.summary,_that.incomes);case _:
  return null;

}
}

}

/// @nodoc


class _MeState implements MeState {
  const _MeState({required this.summary, required  List<IncomeVm> incomes}): _incomes = incomes;
  

@override final  ProfileSummary summary;
 final  List<IncomeVm> _incomes;
@override List<IncomeVm> get incomes {
  if (_incomes is EqualUnmodifiableListView) return _incomes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incomes);
}


/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeStateCopyWith<_MeState> get copyWith => __$MeStateCopyWithImpl<_MeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeState&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.incomes, _incomes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_incomes));
}

@override
String toString() {
    return 'MeState(summary: $summary, incomes: $incomes)';
}


}

/// @nodoc
abstract mixin class _$MeStateCopyWith<$Res> implements $MeStateCopyWith<$Res> {
  factory _$MeStateCopyWith(_MeState value, $Res Function(_MeState) _then) = __$MeStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileSummary summary, List<IncomeVm> incomes
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
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? incomes = null,}) {
  return _then(_MeState(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProfileSummary,incomes: null == incomes ? _self._incomes : incomes // ignore: cast_nullable_to_non_nullable
as List<IncomeVm>,
  ));
}


}

// dart format on
