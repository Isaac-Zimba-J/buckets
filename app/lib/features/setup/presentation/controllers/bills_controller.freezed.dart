// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bills_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillsState {

 String? get errorCode;
/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillsStateCopyWith<BillsState> get copyWith => _$BillsStateCopyWithImpl<BillsState>(this as BillsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BillsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillsState&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as BillsState;
  return Object.hash(runtimeType,_this.errorCode);
}

@override
String toString() {
  final _this = this as BillsState;
  return 'BillsState(errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $BillsStateCopyWith<$Res>  {
  factory $BillsStateCopyWith(BillsState value, $Res Function(BillsState) _then) = _$BillsStateCopyWithImpl;
@useResult
$Res call({
 String? errorCode
});




}
/// @nodoc
class _$BillsStateCopyWithImpl<$Res>
    implements $BillsStateCopyWith<$Res> {
  _$BillsStateCopyWithImpl(this._self, this._then);

  final BillsState _self;
  final $Res Function(BillsState) _then;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errorCode = freezed,}) {
  return _then(_self.copyWith(
errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BillsState].
extension BillsStatePatterns on BillsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BillsEmpty value)?  empty,TResult Function( BillsReady value)?  ready,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BillsEmpty() when empty != null:
return empty(_that);case BillsReady() when ready != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BillsEmpty value)  empty,required TResult Function( BillsReady value)  ready,}){
final _that = this;
switch (_that) {
case BillsEmpty():
return empty(_that);case BillsReady():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BillsEmpty value)?  empty,TResult? Function( BillsReady value)?  ready,}){
final _that = this;
switch (_that) {
case BillsEmpty() when empty != null:
return empty(_that);case BillsReady() when ready != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? errorCode)?  empty,TResult Function( List<BillVm> bills,  Money total,  String? errorCode)?  ready,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BillsEmpty() when empty != null:
return empty(_that.errorCode);case BillsReady() when ready != null:
return ready(_that.bills,_that.total,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? errorCode)  empty,required TResult Function( List<BillVm> bills,  Money total,  String? errorCode)  ready,}) {final _that = this;
switch (_that) {
case BillsEmpty():
return empty(_that.errorCode);case BillsReady():
return ready(_that.bills,_that.total,_that.errorCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? errorCode)?  empty,TResult? Function( List<BillVm> bills,  Money total,  String? errorCode)?  ready,}) {final _that = this;
switch (_that) {
case BillsEmpty() when empty != null:
return empty(_that.errorCode);case BillsReady() when ready != null:
return ready(_that.bills,_that.total,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class BillsEmpty implements BillsState {
  const BillsEmpty({this.errorCode});
  

@override final  String? errorCode;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillsEmptyCopyWith<BillsEmpty> get copyWith => _$BillsEmptyCopyWithImpl<BillsEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BillsEmpty&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,errorCode);
}

@override
String toString() {
    return 'BillsState.empty(errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $BillsEmptyCopyWith<$Res> implements $BillsStateCopyWith<$Res> {
  factory $BillsEmptyCopyWith(BillsEmpty value, $Res Function(BillsEmpty) _then) = _$BillsEmptyCopyWithImpl;
@override @useResult
$Res call({
 String? errorCode
});




}
/// @nodoc
class _$BillsEmptyCopyWithImpl<$Res>
    implements $BillsEmptyCopyWith<$Res> {
  _$BillsEmptyCopyWithImpl(this._self, this._then);

  final BillsEmpty _self;
  final $Res Function(BillsEmpty) _then;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorCode = freezed,}) {
  return _then(BillsEmpty(
errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BillsReady implements BillsState {
  const BillsReady({required  List<BillVm> bills, required this.total, this.errorCode}): _bills = bills;
  

 final  List<BillVm> _bills;
 List<BillVm> get bills {
  if (_bills is EqualUnmodifiableListView) return _bills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bills);
}

 final  Money total;
@override final  String? errorCode;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillsReadyCopyWith<BillsReady> get copyWith => _$BillsReadyCopyWithImpl<BillsReady>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BillsReady&&const DeepCollectionEquality().equals(other.bills, _bills)&&(identical(other.total, total) || other.total == total)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_bills),total,errorCode);
}

@override
String toString() {
    return 'BillsState.ready(bills: $bills, total: $total, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $BillsReadyCopyWith<$Res> implements $BillsStateCopyWith<$Res> {
  factory $BillsReadyCopyWith(BillsReady value, $Res Function(BillsReady) _then) = _$BillsReadyCopyWithImpl;
@override @useResult
$Res call({
 List<BillVm> bills, Money total, String? errorCode
});




}
/// @nodoc
class _$BillsReadyCopyWithImpl<$Res>
    implements $BillsReadyCopyWith<$Res> {
  _$BillsReadyCopyWithImpl(this._self, this._then);

  final BillsReady _self;
  final $Res Function(BillsReady) _then;

/// Create a copy of BillsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bills = null,Object? total = null,Object? errorCode = freezed,}) {
  return _then(BillsReady(
bills: null == bills ? _self._bills : bills // ignore: cast_nullable_to_non_nullable
as List<BillVm>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
