// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckInState {

 List<CheckInStep> get steps; int get stepIndex; int get unsorted; Money get expected; Money? get gap; GapPrompt? get prompt; WeekSummary? get summary; String? get errorCode;
/// Create a copy of CheckInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInStateCopyWith<CheckInState> get copyWith => _$CheckInStateCopyWithImpl<CheckInState>(this as CheckInState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckInState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInState&&const DeepCollectionEquality().equals(other.steps, _this.steps)&&(identical(other.stepIndex, _this.stepIndex) || other.stepIndex == _this.stepIndex)&&(identical(other.unsorted, _this.unsorted) || other.unsorted == _this.unsorted)&&(identical(other.expected, _this.expected) || other.expected == _this.expected)&&(identical(other.gap, _this.gap) || other.gap == _this.gap)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as CheckInState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.steps),_this.stepIndex,_this.unsorted,_this.expected,_this.gap,_this.prompt,_this.summary,_this.errorCode);
}

@override
String toString() {
  final _this = this as CheckInState;
  return 'CheckInState(steps: ${_this.steps}, stepIndex: ${_this.stepIndex}, unsorted: ${_this.unsorted}, expected: ${_this.expected}, gap: ${_this.gap}, prompt: ${_this.prompt}, summary: ${_this.summary}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $CheckInStateCopyWith<$Res>  {
  factory $CheckInStateCopyWith(CheckInState value, $Res Function(CheckInState) _then) = _$CheckInStateCopyWithImpl;
@useResult
$Res call({
 List<CheckInStep> steps, int stepIndex, int unsorted, Money expected, Money? gap, GapPrompt? prompt, WeekSummary? summary, String? errorCode
});




}
/// @nodoc
class _$CheckInStateCopyWithImpl<$Res>
    implements $CheckInStateCopyWith<$Res> {
  _$CheckInStateCopyWithImpl(this._self, this._then);

  final CheckInState _self;
  final $Res Function(CheckInState) _then;

/// Create a copy of CheckInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? steps = null,Object? stepIndex = null,Object? unsorted = null,Object? expected = null,Object? gap = freezed,Object? prompt = freezed,Object? summary = freezed,Object? errorCode = freezed,}) {
  return _then(CheckInState(
steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<CheckInStep>,stepIndex: null == stepIndex ? _self.stepIndex : stepIndex // ignore: cast_nullable_to_non_nullable
as int,unsorted: null == unsorted ? _self.unsorted : unsorted // ignore: cast_nullable_to_non_nullable
as int,expected: null == expected ? _self.expected : expected // ignore: cast_nullable_to_non_nullable
as Money,gap: freezed == gap ? _self.gap : gap // ignore: cast_nullable_to_non_nullable
as Money?,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as GapPrompt?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as WeekSummary?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckInState].
extension CheckInStatePatterns on CheckInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInState value)  $default,){
final _that = this;
switch (_that) {
case _CheckInState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CheckInStep> steps,  int stepIndex,  int unsorted,  Money expected,  Money? gap,  GapPrompt? prompt,  WeekSummary? summary,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInState() when $default != null:
return $default(_that.steps,_that.stepIndex,_that.unsorted,_that.expected,_that.gap,_that.prompt,_that.summary,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CheckInStep> steps,  int stepIndex,  int unsorted,  Money expected,  Money? gap,  GapPrompt? prompt,  WeekSummary? summary,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _CheckInState():
return $default(_that.steps,_that.stepIndex,_that.unsorted,_that.expected,_that.gap,_that.prompt,_that.summary,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CheckInStep> steps,  int stepIndex,  int unsorted,  Money expected,  Money? gap,  GapPrompt? prompt,  WeekSummary? summary,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _CheckInState() when $default != null:
return $default(_that.steps,_that.stepIndex,_that.unsorted,_that.expected,_that.gap,_that.prompt,_that.summary,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _CheckInState extends CheckInState {
  const _CheckInState({required  List<CheckInStep> steps, required this.stepIndex, required this.unsorted, required this.expected, this.gap, this.prompt, this.summary, this.errorCode}): _steps = steps,super._();
  

 final  List<CheckInStep> _steps;
@override List<CheckInStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  int stepIndex;
@override final  int unsorted;
@override final  Money expected;
@override final  Money? gap;
@override final  GapPrompt? prompt;
@override final  WeekSummary? summary;
@override final  String? errorCode;

/// Create a copy of CheckInState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInStateCopyWith<_CheckInState> get copyWith => __$CheckInStateCopyWithImpl<_CheckInState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInState&&const DeepCollectionEquality().equals(other.steps, _steps)&&(identical(other.stepIndex, stepIndex) || other.stepIndex == stepIndex)&&(identical(other.unsorted, unsorted) || other.unsorted == unsorted)&&(identical(other.expected, expected) || other.expected == expected)&&(identical(other.gap, gap) || other.gap == gap)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_steps),stepIndex,unsorted,expected,gap,prompt,summary,errorCode);
}

@override
String toString() {
    return 'CheckInState(steps: $steps, stepIndex: $stepIndex, unsorted: $unsorted, expected: $expected, gap: $gap, prompt: $prompt, summary: $summary, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$CheckInStateCopyWith<$Res> implements $CheckInStateCopyWith<$Res> {
  factory _$CheckInStateCopyWith(_CheckInState value, $Res Function(_CheckInState) _then) = __$CheckInStateCopyWithImpl;
@override @useResult
$Res call({
 List<CheckInStep> steps, int stepIndex, int unsorted, Money expected, Money? gap, GapPrompt? prompt, WeekSummary? summary, String? errorCode
});




}
/// @nodoc
class __$CheckInStateCopyWithImpl<$Res>
    implements _$CheckInStateCopyWith<$Res> {
  __$CheckInStateCopyWithImpl(this._self, this._then);

  final _CheckInState _self;
  final $Res Function(_CheckInState) _then;

/// Create a copy of CheckInState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? steps = null,Object? stepIndex = null,Object? unsorted = null,Object? expected = null,Object? gap = freezed,Object? prompt = freezed,Object? summary = freezed,Object? errorCode = freezed,}) {
  return _then(_CheckInState(
steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<CheckInStep>,stepIndex: null == stepIndex ? _self.stepIndex : stepIndex // ignore: cast_nullable_to_non_nullable
as int,unsorted: null == unsorted ? _self.unsorted : unsorted // ignore: cast_nullable_to_non_nullable
as int,expected: null == expected ? _self.expected : expected // ignore: cast_nullable_to_non_nullable
as Money,gap: freezed == gap ? _self.gap : gap // ignore: cast_nullable_to_non_nullable
as Money?,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as GapPrompt?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as WeekSummary?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
