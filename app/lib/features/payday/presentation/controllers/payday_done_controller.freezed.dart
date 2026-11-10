// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payday_done_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaydayDoneState {

 Money get moved; Money get livingLeft; Money get guiltFreeLeft; Money? get perDay; int get streak; String? get goalBucketId; Money? get goalBalance; Money? get goalTarget; DateTime? get startedAt; int get transfers; bool get allProven; String? get goalName; int? get goalProgress;
/// Create a copy of PaydayDoneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaydayDoneStateCopyWith<PaydayDoneState> get copyWith => _$PaydayDoneStateCopyWithImpl<PaydayDoneState>(this as PaydayDoneState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PaydayDoneState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaydayDoneState&&(identical(other.moved, _this.moved) || other.moved == _this.moved)&&(identical(other.livingLeft, _this.livingLeft) || other.livingLeft == _this.livingLeft)&&(identical(other.guiltFreeLeft, _this.guiltFreeLeft) || other.guiltFreeLeft == _this.guiltFreeLeft)&&(identical(other.perDay, _this.perDay) || other.perDay == _this.perDay)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.goalBucketId, _this.goalBucketId) || other.goalBucketId == _this.goalBucketId)&&(identical(other.goalBalance, _this.goalBalance) || other.goalBalance == _this.goalBalance)&&(identical(other.goalTarget, _this.goalTarget) || other.goalTarget == _this.goalTarget)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.transfers, _this.transfers) || other.transfers == _this.transfers)&&(identical(other.allProven, _this.allProven) || other.allProven == _this.allProven)&&(identical(other.goalName, _this.goalName) || other.goalName == _this.goalName)&&(identical(other.goalProgress, _this.goalProgress) || other.goalProgress == _this.goalProgress));
}


@override
int get hashCode {
  final _this = this as PaydayDoneState;
  return Object.hash(runtimeType,_this.moved,_this.livingLeft,_this.guiltFreeLeft,_this.perDay,_this.streak,_this.goalBucketId,_this.goalBalance,_this.goalTarget,_this.startedAt,_this.transfers,_this.allProven,_this.goalName,_this.goalProgress);
}

@override
String toString() {
  final _this = this as PaydayDoneState;
  return 'PaydayDoneState(moved: ${_this.moved}, livingLeft: ${_this.livingLeft}, guiltFreeLeft: ${_this.guiltFreeLeft}, perDay: ${_this.perDay}, streak: ${_this.streak}, goalBucketId: ${_this.goalBucketId}, goalBalance: ${_this.goalBalance}, goalTarget: ${_this.goalTarget}, startedAt: ${_this.startedAt}, transfers: ${_this.transfers}, allProven: ${_this.allProven}, goalName: ${_this.goalName}, goalProgress: ${_this.goalProgress})';
}


}

/// @nodoc
abstract mixin class $PaydayDoneStateCopyWith<$Res>  {
  factory $PaydayDoneStateCopyWith(PaydayDoneState value, $Res Function(PaydayDoneState) _then) = _$PaydayDoneStateCopyWithImpl;
@useResult
$Res call({
 Money moved, Money livingLeft, Money guiltFreeLeft, Money? perDay, int streak, String? goalBucketId, Money? goalBalance, Money? goalTarget, DateTime? startedAt, int transfers, bool allProven, String? goalName, int? goalProgress
});




}
/// @nodoc
class _$PaydayDoneStateCopyWithImpl<$Res>
    implements $PaydayDoneStateCopyWith<$Res> {
  _$PaydayDoneStateCopyWithImpl(this._self, this._then);

  final PaydayDoneState _self;
  final $Res Function(PaydayDoneState) _then;

/// Create a copy of PaydayDoneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? moved = null,Object? livingLeft = null,Object? guiltFreeLeft = null,Object? perDay = freezed,Object? streak = null,Object? goalBucketId = freezed,Object? goalBalance = freezed,Object? goalTarget = freezed,Object? startedAt = freezed,Object? transfers = null,Object? allProven = null,Object? goalName = freezed,Object? goalProgress = freezed,}) {
  return _then(PaydayDoneState(
moved: null == moved ? _self.moved : moved // ignore: cast_nullable_to_non_nullable
as Money,livingLeft: null == livingLeft ? _self.livingLeft : livingLeft // ignore: cast_nullable_to_non_nullable
as Money,guiltFreeLeft: null == guiltFreeLeft ? _self.guiltFreeLeft : guiltFreeLeft // ignore: cast_nullable_to_non_nullable
as Money,perDay: freezed == perDay ? _self.perDay : perDay // ignore: cast_nullable_to_non_nullable
as Money?,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,goalBucketId: freezed == goalBucketId ? _self.goalBucketId : goalBucketId // ignore: cast_nullable_to_non_nullable
as String?,goalBalance: freezed == goalBalance ? _self.goalBalance : goalBalance // ignore: cast_nullable_to_non_nullable
as Money?,goalTarget: freezed == goalTarget ? _self.goalTarget : goalTarget // ignore: cast_nullable_to_non_nullable
as Money?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as int,allProven: null == allProven ? _self.allProven : allProven // ignore: cast_nullable_to_non_nullable
as bool,goalName: freezed == goalName ? _self.goalName : goalName // ignore: cast_nullable_to_non_nullable
as String?,goalProgress: freezed == goalProgress ? _self.goalProgress : goalProgress // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaydayDoneState].
extension PaydayDoneStatePatterns on PaydayDoneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaydayDoneState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaydayDoneState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaydayDoneState value)  $default,){
final _that = this;
switch (_that) {
case _PaydayDoneState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaydayDoneState value)?  $default,){
final _that = this;
switch (_that) {
case _PaydayDoneState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Money moved,  Money livingLeft,  Money guiltFreeLeft,  Money? perDay,  int streak,  String? goalBucketId,  Money? goalBalance,  Money? goalTarget,  DateTime? startedAt,  int transfers,  bool allProven,  String? goalName,  int? goalProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaydayDoneState() when $default != null:
return $default(_that.moved,_that.livingLeft,_that.guiltFreeLeft,_that.perDay,_that.streak,_that.goalBucketId,_that.goalBalance,_that.goalTarget,_that.startedAt,_that.transfers,_that.allProven,_that.goalName,_that.goalProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Money moved,  Money livingLeft,  Money guiltFreeLeft,  Money? perDay,  int streak,  String? goalBucketId,  Money? goalBalance,  Money? goalTarget,  DateTime? startedAt,  int transfers,  bool allProven,  String? goalName,  int? goalProgress)  $default,) {final _that = this;
switch (_that) {
case _PaydayDoneState():
return $default(_that.moved,_that.livingLeft,_that.guiltFreeLeft,_that.perDay,_that.streak,_that.goalBucketId,_that.goalBalance,_that.goalTarget,_that.startedAt,_that.transfers,_that.allProven,_that.goalName,_that.goalProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Money moved,  Money livingLeft,  Money guiltFreeLeft,  Money? perDay,  int streak,  String? goalBucketId,  Money? goalBalance,  Money? goalTarget,  DateTime? startedAt,  int transfers,  bool allProven,  String? goalName,  int? goalProgress)?  $default,) {final _that = this;
switch (_that) {
case _PaydayDoneState() when $default != null:
return $default(_that.moved,_that.livingLeft,_that.guiltFreeLeft,_that.perDay,_that.streak,_that.goalBucketId,_that.goalBalance,_that.goalTarget,_that.startedAt,_that.transfers,_that.allProven,_that.goalName,_that.goalProgress);case _:
  return null;

}
}

}

/// @nodoc


class _PaydayDoneState implements PaydayDoneState {
  const _PaydayDoneState({required this.moved, required this.livingLeft, required this.guiltFreeLeft, required this.perDay, required this.streak, required this.goalBucketId, required this.goalBalance, required this.goalTarget, this.startedAt, this.transfers = 0, this.allProven = true, this.goalName, this.goalProgress});
  

@override final  Money moved;
@override final  Money livingLeft;
@override final  Money guiltFreeLeft;
@override final  Money? perDay;
@override final  int streak;
@override final  String? goalBucketId;
@override final  Money? goalBalance;
@override final  Money? goalTarget;
@override final  DateTime? startedAt;
@override@JsonKey() final  int transfers;
@override@JsonKey() final  bool allProven;
@override final  String? goalName;
@override final  int? goalProgress;

/// Create a copy of PaydayDoneState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaydayDoneStateCopyWith<_PaydayDoneState> get copyWith => __$PaydayDoneStateCopyWithImpl<_PaydayDoneState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaydayDoneState&&(identical(other.moved, moved) || other.moved == moved)&&(identical(other.livingLeft, livingLeft) || other.livingLeft == livingLeft)&&(identical(other.guiltFreeLeft, guiltFreeLeft) || other.guiltFreeLeft == guiltFreeLeft)&&(identical(other.perDay, perDay) || other.perDay == perDay)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.goalBucketId, goalBucketId) || other.goalBucketId == goalBucketId)&&(identical(other.goalBalance, goalBalance) || other.goalBalance == goalBalance)&&(identical(other.goalTarget, goalTarget) || other.goalTarget == goalTarget)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.transfers, transfers) || other.transfers == transfers)&&(identical(other.allProven, allProven) || other.allProven == allProven)&&(identical(other.goalName, goalName) || other.goalName == goalName)&&(identical(other.goalProgress, goalProgress) || other.goalProgress == goalProgress));
}


@override
int get hashCode {
    return Object.hash(runtimeType,moved,livingLeft,guiltFreeLeft,perDay,streak,goalBucketId,goalBalance,goalTarget,startedAt,transfers,allProven,goalName,goalProgress);
}

@override
String toString() {
    return 'PaydayDoneState(moved: $moved, livingLeft: $livingLeft, guiltFreeLeft: $guiltFreeLeft, perDay: $perDay, streak: $streak, goalBucketId: $goalBucketId, goalBalance: $goalBalance, goalTarget: $goalTarget, startedAt: $startedAt, transfers: $transfers, allProven: $allProven, goalName: $goalName, goalProgress: $goalProgress)';
}


}

/// @nodoc
abstract mixin class _$PaydayDoneStateCopyWith<$Res> implements $PaydayDoneStateCopyWith<$Res> {
  factory _$PaydayDoneStateCopyWith(_PaydayDoneState value, $Res Function(_PaydayDoneState) _then) = __$PaydayDoneStateCopyWithImpl;
@override @useResult
$Res call({
 Money moved, Money livingLeft, Money guiltFreeLeft, Money? perDay, int streak, String? goalBucketId, Money? goalBalance, Money? goalTarget, DateTime? startedAt, int transfers, bool allProven, String? goalName, int? goalProgress
});




}
/// @nodoc
class __$PaydayDoneStateCopyWithImpl<$Res>
    implements _$PaydayDoneStateCopyWith<$Res> {
  __$PaydayDoneStateCopyWithImpl(this._self, this._then);

  final _PaydayDoneState _self;
  final $Res Function(_PaydayDoneState) _then;

/// Create a copy of PaydayDoneState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? moved = null,Object? livingLeft = null,Object? guiltFreeLeft = null,Object? perDay = freezed,Object? streak = null,Object? goalBucketId = freezed,Object? goalBalance = freezed,Object? goalTarget = freezed,Object? startedAt = freezed,Object? transfers = null,Object? allProven = null,Object? goalName = freezed,Object? goalProgress = freezed,}) {
  return _then(_PaydayDoneState(
moved: null == moved ? _self.moved : moved // ignore: cast_nullable_to_non_nullable
as Money,livingLeft: null == livingLeft ? _self.livingLeft : livingLeft // ignore: cast_nullable_to_non_nullable
as Money,guiltFreeLeft: null == guiltFreeLeft ? _self.guiltFreeLeft : guiltFreeLeft // ignore: cast_nullable_to_non_nullable
as Money,perDay: freezed == perDay ? _self.perDay : perDay // ignore: cast_nullable_to_non_nullable
as Money?,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,goalBucketId: freezed == goalBucketId ? _self.goalBucketId : goalBucketId // ignore: cast_nullable_to_non_nullable
as String?,goalBalance: freezed == goalBalance ? _self.goalBalance : goalBalance // ignore: cast_nullable_to_non_nullable
as Money?,goalTarget: freezed == goalTarget ? _self.goalTarget : goalTarget // ignore: cast_nullable_to_non_nullable
as Money?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as int,allProven: null == allProven ? _self.allProven : allProven // ignore: cast_nullable_to_non_nullable
as bool,goalName: freezed == goalName ? _self.goalName : goalName // ignore: cast_nullable_to_non_nullable
as String?,goalProgress: freezed == goalProgress ? _self.goalProgress : goalProgress // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
