// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proof_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProofState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProofState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProofState()';
}


}

/// @nodoc
class $ProofStateCopyWith<$Res>  {
$ProofStateCopyWith(ProofState _, $Res Function(ProofState) __);
}


/// Adds pattern-matching-related methods to [ProofState].
extension ProofStatePatterns on ProofState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProofIdle value)?  idle,TResult Function( ProofChecking value)?  checking,TResult Function( ProofPassed value)?  passed,TResult Function( ProofFailed value)?  failed,TResult Function( ProofSaved value)?  saved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProofIdle() when idle != null:
return idle(_that);case ProofChecking() when checking != null:
return checking(_that);case ProofPassed() when passed != null:
return passed(_that);case ProofFailed() when failed != null:
return failed(_that);case ProofSaved() when saved != null:
return saved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProofIdle value)  idle,required TResult Function( ProofChecking value)  checking,required TResult Function( ProofPassed value)  passed,required TResult Function( ProofFailed value)  failed,required TResult Function( ProofSaved value)  saved,}){
final _that = this;
switch (_that) {
case ProofIdle():
return idle(_that);case ProofChecking():
return checking(_that);case ProofPassed():
return passed(_that);case ProofFailed():
return failed(_that);case ProofSaved():
return saved(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProofIdle value)?  idle,TResult? Function( ProofChecking value)?  checking,TResult? Function( ProofPassed value)?  passed,TResult? Function( ProofFailed value)?  failed,TResult? Function( ProofSaved value)?  saved,}){
final _that = this;
switch (_that) {
case ProofIdle() when idle != null:
return idle(_that);case ProofChecking() when checking != null:
return checking(_that);case ProofPassed() when passed != null:
return passed(_that);case ProofFailed() when failed != null:
return failed(_that);case ProofSaved() when saved != null:
return saved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  checking,TResult Function( List<CheckRowVm> checks)?  passed,TResult Function( List<CheckRowVm> checks,  bool canSavePartial,  Money? parsed,  Money? owed)?  failed,TResult Function()?  saved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProofIdle() when idle != null:
return idle();case ProofChecking() when checking != null:
return checking();case ProofPassed() when passed != null:
return passed(_that.checks);case ProofFailed() when failed != null:
return failed(_that.checks,_that.canSavePartial,_that.parsed,_that.owed);case ProofSaved() when saved != null:
return saved();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  checking,required TResult Function( List<CheckRowVm> checks)  passed,required TResult Function( List<CheckRowVm> checks,  bool canSavePartial,  Money? parsed,  Money? owed)  failed,required TResult Function()  saved,}) {final _that = this;
switch (_that) {
case ProofIdle():
return idle();case ProofChecking():
return checking();case ProofPassed():
return passed(_that.checks);case ProofFailed():
return failed(_that.checks,_that.canSavePartial,_that.parsed,_that.owed);case ProofSaved():
return saved();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  checking,TResult? Function( List<CheckRowVm> checks)?  passed,TResult? Function( List<CheckRowVm> checks,  bool canSavePartial,  Money? parsed,  Money? owed)?  failed,TResult? Function()?  saved,}) {final _that = this;
switch (_that) {
case ProofIdle() when idle != null:
return idle();case ProofChecking() when checking != null:
return checking();case ProofPassed() when passed != null:
return passed(_that.checks);case ProofFailed() when failed != null:
return failed(_that.checks,_that.canSavePartial,_that.parsed,_that.owed);case ProofSaved() when saved != null:
return saved();case _:
  return null;

}
}

}

/// @nodoc


class ProofIdle implements ProofState {
  const ProofIdle();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProofIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProofState.idle()';
}


}




/// @nodoc


class ProofChecking implements ProofState {
  const ProofChecking();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProofChecking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProofState.checking()';
}


}




/// @nodoc


class ProofPassed implements ProofState {
  const ProofPassed({required  List<CheckRowVm> checks}): _checks = checks;
  

 final  List<CheckRowVm> _checks;
 List<CheckRowVm> get checks {
  if (_checks is EqualUnmodifiableListView) return _checks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checks);
}


/// Create a copy of ProofState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProofPassedCopyWith<ProofPassed> get copyWith => _$ProofPassedCopyWithImpl<ProofPassed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProofPassed&&const DeepCollectionEquality().equals(other.checks, _checks));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_checks));
}

@override
String toString() {
    return 'ProofState.passed(checks: $checks)';
}


}

/// @nodoc
abstract mixin class $ProofPassedCopyWith<$Res> implements $ProofStateCopyWith<$Res> {
  factory $ProofPassedCopyWith(ProofPassed value, $Res Function(ProofPassed) _then) = _$ProofPassedCopyWithImpl;
@useResult
$Res call({
 List<CheckRowVm> checks
});




}
/// @nodoc
class _$ProofPassedCopyWithImpl<$Res>
    implements $ProofPassedCopyWith<$Res> {
  _$ProofPassedCopyWithImpl(this._self, this._then);

  final ProofPassed _self;
  final $Res Function(ProofPassed) _then;

/// Create a copy of ProofState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? checks = null,}) {
  return _then(ProofPassed(
checks: null == checks ? _self._checks : checks // ignore: cast_nullable_to_non_nullable
as List<CheckRowVm>,
  ));
}


}

/// @nodoc


class ProofFailed implements ProofState {
  const ProofFailed({required  List<CheckRowVm> checks, required this.canSavePartial, required this.parsed, required this.owed}): _checks = checks;
  

 final  List<CheckRowVm> _checks;
 List<CheckRowVm> get checks {
  if (_checks is EqualUnmodifiableListView) return _checks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checks);
}

 final  bool canSavePartial;
 final  Money? parsed;
 final  Money? owed;

/// Create a copy of ProofState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProofFailedCopyWith<ProofFailed> get copyWith => _$ProofFailedCopyWithImpl<ProofFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProofFailed&&const DeepCollectionEquality().equals(other.checks, _checks)&&(identical(other.canSavePartial, canSavePartial) || other.canSavePartial == canSavePartial)&&(identical(other.parsed, parsed) || other.parsed == parsed)&&(identical(other.owed, owed) || other.owed == owed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_checks),canSavePartial,parsed,owed);
}

@override
String toString() {
    return 'ProofState.failed(checks: $checks, canSavePartial: $canSavePartial, parsed: $parsed, owed: $owed)';
}


}

/// @nodoc
abstract mixin class $ProofFailedCopyWith<$Res> implements $ProofStateCopyWith<$Res> {
  factory $ProofFailedCopyWith(ProofFailed value, $Res Function(ProofFailed) _then) = _$ProofFailedCopyWithImpl;
@useResult
$Res call({
 List<CheckRowVm> checks, bool canSavePartial, Money? parsed, Money? owed
});




}
/// @nodoc
class _$ProofFailedCopyWithImpl<$Res>
    implements $ProofFailedCopyWith<$Res> {
  _$ProofFailedCopyWithImpl(this._self, this._then);

  final ProofFailed _self;
  final $Res Function(ProofFailed) _then;

/// Create a copy of ProofState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? checks = null,Object? canSavePartial = null,Object? parsed = freezed,Object? owed = freezed,}) {
  return _then(ProofFailed(
checks: null == checks ? _self._checks : checks // ignore: cast_nullable_to_non_nullable
as List<CheckRowVm>,canSavePartial: null == canSavePartial ? _self.canSavePartial : canSavePartial // ignore: cast_nullable_to_non_nullable
as bool,parsed: freezed == parsed ? _self.parsed : parsed // ignore: cast_nullable_to_non_nullable
as Money?,owed: freezed == owed ? _self.owed : owed // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}


}

/// @nodoc


class ProofSaved implements ProofState {
  const ProofSaved();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProofSaved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProofState.saved()';
}


}




// dart format on
