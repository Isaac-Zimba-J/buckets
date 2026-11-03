// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanState {

 List<PlannedVm> get planned; List<WishVm> get wishes; String? get errorCode;
/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanStateCopyWith<PlanState> get copyWith => _$PlanStateCopyWithImpl<PlanState>(this as PlanState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlanState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanState&&const DeepCollectionEquality().equals(other.planned, _this.planned)&&const DeepCollectionEquality().equals(other.wishes, _this.wishes)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as PlanState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.planned),const DeepCollectionEquality().hash(_this.wishes),_this.errorCode);
}

@override
String toString() {
  final _this = this as PlanState;
  return 'PlanState(planned: ${_this.planned}, wishes: ${_this.wishes}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $PlanStateCopyWith<$Res>  {
  factory $PlanStateCopyWith(PlanState value, $Res Function(PlanState) _then) = _$PlanStateCopyWithImpl;
@useResult
$Res call({
 List<PlannedVm> planned, List<WishVm> wishes, String? errorCode
});




}
/// @nodoc
class _$PlanStateCopyWithImpl<$Res>
    implements $PlanStateCopyWith<$Res> {
  _$PlanStateCopyWithImpl(this._self, this._then);

  final PlanState _self;
  final $Res Function(PlanState) _then;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planned = null,Object? wishes = null,Object? errorCode = freezed,}) {
  return _then(PlanState(
planned: null == planned ? _self.planned : planned // ignore: cast_nullable_to_non_nullable
as List<PlannedVm>,wishes: null == wishes ? _self.wishes : wishes // ignore: cast_nullable_to_non_nullable
as List<WishVm>,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanState].
extension PlanStatePatterns on PlanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanState value)  $default,){
final _that = this;
switch (_that) {
case _PlanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanState value)?  $default,){
final _that = this;
switch (_that) {
case _PlanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlannedVm> planned,  List<WishVm> wishes,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanState() when $default != null:
return $default(_that.planned,_that.wishes,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlannedVm> planned,  List<WishVm> wishes,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _PlanState():
return $default(_that.planned,_that.wishes,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlannedVm> planned,  List<WishVm> wishes,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _PlanState() when $default != null:
return $default(_that.planned,_that.wishes,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _PlanState implements PlanState {
  const _PlanState({required  List<PlannedVm> planned, required  List<WishVm> wishes, this.errorCode}): _planned = planned,_wishes = wishes;
  

 final  List<PlannedVm> _planned;
@override List<PlannedVm> get planned {
  if (_planned is EqualUnmodifiableListView) return _planned;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_planned);
}

 final  List<WishVm> _wishes;
@override List<WishVm> get wishes {
  if (_wishes is EqualUnmodifiableListView) return _wishes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wishes);
}

@override final  String? errorCode;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanStateCopyWith<_PlanState> get copyWith => __$PlanStateCopyWithImpl<_PlanState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanState&&const DeepCollectionEquality().equals(other.planned, _planned)&&const DeepCollectionEquality().equals(other.wishes, _wishes)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_planned),const DeepCollectionEquality().hash(_wishes),errorCode);
}

@override
String toString() {
    return 'PlanState(planned: $planned, wishes: $wishes, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$PlanStateCopyWith<$Res> implements $PlanStateCopyWith<$Res> {
  factory _$PlanStateCopyWith(_PlanState value, $Res Function(_PlanState) _then) = __$PlanStateCopyWithImpl;
@override @useResult
$Res call({
 List<PlannedVm> planned, List<WishVm> wishes, String? errorCode
});




}
/// @nodoc
class __$PlanStateCopyWithImpl<$Res>
    implements _$PlanStateCopyWith<$Res> {
  __$PlanStateCopyWithImpl(this._self, this._then);

  final _PlanState _self;
  final $Res Function(_PlanState) _then;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planned = null,Object? wishes = null,Object? errorCode = freezed,}) {
  return _then(_PlanState(
planned: null == planned ? _self._planned : planned // ignore: cast_nullable_to_non_nullable
as List<PlannedVm>,wishes: null == wishes ? _self._wishes : wishes // ignore: cast_nullable_to_non_nullable
as List<WishVm>,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
