// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bills_cycle_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillsCycleState {

 BillsCycleView? get view; Money get feesTotal;
/// Create a copy of BillsCycleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillsCycleStateCopyWith<BillsCycleState> get copyWith => _$BillsCycleStateCopyWithImpl<BillsCycleState>(this as BillsCycleState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BillsCycleState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillsCycleState&&(identical(other.view, _this.view) || other.view == _this.view)&&(identical(other.feesTotal, _this.feesTotal) || other.feesTotal == _this.feesTotal));
}


@override
int get hashCode {
  final _this = this as BillsCycleState;
  return Object.hash(runtimeType,_this.view,_this.feesTotal);
}

@override
String toString() {
  final _this = this as BillsCycleState;
  return 'BillsCycleState(view: ${_this.view}, feesTotal: ${_this.feesTotal})';
}


}

/// @nodoc
abstract mixin class $BillsCycleStateCopyWith<$Res>  {
  factory $BillsCycleStateCopyWith(BillsCycleState value, $Res Function(BillsCycleState) _then) = _$BillsCycleStateCopyWithImpl;
@useResult
$Res call({
 BillsCycleView? view, Money feesTotal
});




}
/// @nodoc
class _$BillsCycleStateCopyWithImpl<$Res>
    implements $BillsCycleStateCopyWith<$Res> {
  _$BillsCycleStateCopyWithImpl(this._self, this._then);

  final BillsCycleState _self;
  final $Res Function(BillsCycleState) _then;

/// Create a copy of BillsCycleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? view = freezed,Object? feesTotal = null,}) {
  return _then(BillsCycleState(
view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as BillsCycleView?,feesTotal: null == feesTotal ? _self.feesTotal : feesTotal // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [BillsCycleState].
extension BillsCycleStatePatterns on BillsCycleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillsCycleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillsCycleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillsCycleState value)  $default,){
final _that = this;
switch (_that) {
case _BillsCycleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillsCycleState value)?  $default,){
final _that = this;
switch (_that) {
case _BillsCycleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BillsCycleView? view,  Money feesTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillsCycleState() when $default != null:
return $default(_that.view,_that.feesTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BillsCycleView? view,  Money feesTotal)  $default,) {final _that = this;
switch (_that) {
case _BillsCycleState():
return $default(_that.view,_that.feesTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BillsCycleView? view,  Money feesTotal)?  $default,) {final _that = this;
switch (_that) {
case _BillsCycleState() when $default != null:
return $default(_that.view,_that.feesTotal);case _:
  return null;

}
}

}

/// @nodoc


class _BillsCycleState extends BillsCycleState {
  const _BillsCycleState({required this.view, required this.feesTotal}): super._();
  

@override final  BillsCycleView? view;
@override final  Money feesTotal;

/// Create a copy of BillsCycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillsCycleStateCopyWith<_BillsCycleState> get copyWith => __$BillsCycleStateCopyWithImpl<_BillsCycleState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillsCycleState&&(identical(other.view, view) || other.view == view)&&(identical(other.feesTotal, feesTotal) || other.feesTotal == feesTotal));
}


@override
int get hashCode {
    return Object.hash(runtimeType,view,feesTotal);
}

@override
String toString() {
    return 'BillsCycleState(view: $view, feesTotal: $feesTotal)';
}


}

/// @nodoc
abstract mixin class _$BillsCycleStateCopyWith<$Res> implements $BillsCycleStateCopyWith<$Res> {
  factory _$BillsCycleStateCopyWith(_BillsCycleState value, $Res Function(_BillsCycleState) _then) = __$BillsCycleStateCopyWithImpl;
@override @useResult
$Res call({
 BillsCycleView? view, Money feesTotal
});




}
/// @nodoc
class __$BillsCycleStateCopyWithImpl<$Res>
    implements _$BillsCycleStateCopyWith<$Res> {
  __$BillsCycleStateCopyWithImpl(this._self, this._then);

  final _BillsCycleState _self;
  final $Res Function(_BillsCycleState) _then;

/// Create a copy of BillsCycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? view = freezed,Object? feesTotal = null,}) {
  return _then(_BillsCycleState(
view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as BillsCycleView?,feesTotal: null == feesTotal ? _self.feesTotal : feesTotal // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

// dart format on
