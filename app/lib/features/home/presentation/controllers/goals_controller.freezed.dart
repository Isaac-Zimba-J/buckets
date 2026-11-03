// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goals_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoalsState {

 Money get totalSaved;
/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalsStateCopyWith<GoalsState> get copyWith => _$GoalsStateCopyWithImpl<GoalsState>(this as GoalsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoalsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalsState&&(identical(other.totalSaved, _this.totalSaved) || other.totalSaved == _this.totalSaved));
}


@override
int get hashCode {
  final _this = this as GoalsState;
  return Object.hash(runtimeType,_this.totalSaved);
}

@override
String toString() {
  final _this = this as GoalsState;
  return 'GoalsState(totalSaved: ${_this.totalSaved})';
}


}

/// @nodoc
abstract mixin class $GoalsStateCopyWith<$Res>  {
  factory $GoalsStateCopyWith(GoalsState value, $Res Function(GoalsState) _then) = _$GoalsStateCopyWithImpl;
@useResult
$Res call({
 Money totalSaved
});




}
/// @nodoc
class _$GoalsStateCopyWithImpl<$Res>
    implements $GoalsStateCopyWith<$Res> {
  _$GoalsStateCopyWithImpl(this._self, this._then);

  final GoalsState _self;
  final $Res Function(GoalsState) _then;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalSaved = null,}) {
  return _then(_self.copyWith(
totalSaved: null == totalSaved ? _self.totalSaved : totalSaved // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalsState].
extension GoalsStatePatterns on GoalsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GoalsEmpty value)?  empty,TResult Function( GoalsReady value)?  ready,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GoalsEmpty() when empty != null:
return empty(_that);case GoalsReady() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GoalsEmpty value)  empty,required TResult Function( GoalsReady value)  ready,}){
final _that = this;
switch (_that) {
case GoalsEmpty():
return empty(_that);case GoalsReady():
return ready(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GoalsEmpty value)?  empty,TResult? Function( GoalsReady value)?  ready,}){
final _that = this;
switch (_that) {
case GoalsEmpty() when empty != null:
return empty(_that);case GoalsReady() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Money totalSaved)?  empty,TResult Function( List<GoalCardVm> goals,  Money totalSaved,  Money savedThisCycle)?  ready,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GoalsEmpty() when empty != null:
return empty(_that.totalSaved);case GoalsReady() when ready != null:
return ready(_that.goals,_that.totalSaved,_that.savedThisCycle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Money totalSaved)  empty,required TResult Function( List<GoalCardVm> goals,  Money totalSaved,  Money savedThisCycle)  ready,}) {final _that = this;
switch (_that) {
case GoalsEmpty():
return empty(_that.totalSaved);case GoalsReady():
return ready(_that.goals,_that.totalSaved,_that.savedThisCycle);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Money totalSaved)?  empty,TResult? Function( List<GoalCardVm> goals,  Money totalSaved,  Money savedThisCycle)?  ready,}) {final _that = this;
switch (_that) {
case GoalsEmpty() when empty != null:
return empty(_that.totalSaved);case GoalsReady() when ready != null:
return ready(_that.goals,_that.totalSaved,_that.savedThisCycle);case _:
  return null;

}
}

}

/// @nodoc


class GoalsEmpty implements GoalsState {
  const GoalsEmpty({required this.totalSaved});
  

@override final  Money totalSaved;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalsEmptyCopyWith<GoalsEmpty> get copyWith => _$GoalsEmptyCopyWithImpl<GoalsEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalsEmpty&&(identical(other.totalSaved, totalSaved) || other.totalSaved == totalSaved));
}


@override
int get hashCode {
    return Object.hash(runtimeType,totalSaved);
}

@override
String toString() {
    return 'GoalsState.empty(totalSaved: $totalSaved)';
}


}

/// @nodoc
abstract mixin class $GoalsEmptyCopyWith<$Res> implements $GoalsStateCopyWith<$Res> {
  factory $GoalsEmptyCopyWith(GoalsEmpty value, $Res Function(GoalsEmpty) _then) = _$GoalsEmptyCopyWithImpl;
@override @useResult
$Res call({
 Money totalSaved
});




}
/// @nodoc
class _$GoalsEmptyCopyWithImpl<$Res>
    implements $GoalsEmptyCopyWith<$Res> {
  _$GoalsEmptyCopyWithImpl(this._self, this._then);

  final GoalsEmpty _self;
  final $Res Function(GoalsEmpty) _then;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalSaved = null,}) {
  return _then(GoalsEmpty(
totalSaved: null == totalSaved ? _self.totalSaved : totalSaved // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc


class GoalsReady implements GoalsState {
  const GoalsReady({required  List<GoalCardVm> goals, required this.totalSaved, required this.savedThisCycle}): _goals = goals;
  

 final  List<GoalCardVm> _goals;
 List<GoalCardVm> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  Money totalSaved;
 final  Money savedThisCycle;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalsReadyCopyWith<GoalsReady> get copyWith => _$GoalsReadyCopyWithImpl<GoalsReady>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalsReady&&const DeepCollectionEquality().equals(other.goals, _goals)&&(identical(other.totalSaved, totalSaved) || other.totalSaved == totalSaved)&&(identical(other.savedThisCycle, savedThisCycle) || other.savedThisCycle == savedThisCycle));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_goals),totalSaved,savedThisCycle);
}

@override
String toString() {
    return 'GoalsState.ready(goals: $goals, totalSaved: $totalSaved, savedThisCycle: $savedThisCycle)';
}


}

/// @nodoc
abstract mixin class $GoalsReadyCopyWith<$Res> implements $GoalsStateCopyWith<$Res> {
  factory $GoalsReadyCopyWith(GoalsReady value, $Res Function(GoalsReady) _then) = _$GoalsReadyCopyWithImpl;
@override @useResult
$Res call({
 List<GoalCardVm> goals, Money totalSaved, Money savedThisCycle
});




}
/// @nodoc
class _$GoalsReadyCopyWithImpl<$Res>
    implements $GoalsReadyCopyWith<$Res> {
  _$GoalsReadyCopyWithImpl(this._self, this._then);

  final GoalsReady _self;
  final $Res Function(GoalsReady) _then;

/// Create a copy of GoalsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goals = null,Object? totalSaved = null,Object? savedThisCycle = null,}) {
  return _then(GoalsReady(
goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalCardVm>,totalSaved: null == totalSaved ? _self.totalSaved : totalSaved // ignore: cast_nullable_to_non_nullable
as Money,savedThisCycle: null == savedThisCycle ? _self.savedThisCycle : savedThisCycle // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

// dart format on
