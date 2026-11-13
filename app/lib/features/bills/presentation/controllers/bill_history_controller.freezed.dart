// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_history_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BillHistoryState {

 String get billName; List<BillOccurrence> get occurrences; BillStats get stats; Money get feesThisYear;
/// Create a copy of BillHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillHistoryStateCopyWith<BillHistoryState> get copyWith => _$BillHistoryStateCopyWithImpl<BillHistoryState>(this as BillHistoryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BillHistoryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillHistoryState&&(identical(other.billName, _this.billName) || other.billName == _this.billName)&&const DeepCollectionEquality().equals(other.occurrences, _this.occurrences)&&(identical(other.stats, _this.stats) || other.stats == _this.stats)&&(identical(other.feesThisYear, _this.feesThisYear) || other.feesThisYear == _this.feesThisYear));
}


@override
int get hashCode {
  final _this = this as BillHistoryState;
  return Object.hash(runtimeType,_this.billName,const DeepCollectionEquality().hash(_this.occurrences),_this.stats,_this.feesThisYear);
}

@override
String toString() {
  final _this = this as BillHistoryState;
  return 'BillHistoryState(billName: ${_this.billName}, occurrences: ${_this.occurrences}, stats: ${_this.stats}, feesThisYear: ${_this.feesThisYear})';
}


}

/// @nodoc
abstract mixin class $BillHistoryStateCopyWith<$Res>  {
  factory $BillHistoryStateCopyWith(BillHistoryState value, $Res Function(BillHistoryState) _then) = _$BillHistoryStateCopyWithImpl;
@useResult
$Res call({
 String billName, List<BillOccurrence> occurrences, BillStats stats, Money feesThisYear
});




}
/// @nodoc
class _$BillHistoryStateCopyWithImpl<$Res>
    implements $BillHistoryStateCopyWith<$Res> {
  _$BillHistoryStateCopyWithImpl(this._self, this._then);

  final BillHistoryState _self;
  final $Res Function(BillHistoryState) _then;

/// Create a copy of BillHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billName = null,Object? occurrences = null,Object? stats = null,Object? feesThisYear = null,}) {
  return _then(BillHistoryState(
billName: null == billName ? _self.billName : billName // ignore: cast_nullable_to_non_nullable
as String,occurrences: null == occurrences ? _self.occurrences : occurrences // ignore: cast_nullable_to_non_nullable
as List<BillOccurrence>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as BillStats,feesThisYear: null == feesThisYear ? _self.feesThisYear : feesThisYear // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [BillHistoryState].
extension BillHistoryStatePatterns on BillHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillHistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _BillHistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _BillHistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String billName,  List<BillOccurrence> occurrences,  BillStats stats,  Money feesThisYear)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillHistoryState() when $default != null:
return $default(_that.billName,_that.occurrences,_that.stats,_that.feesThisYear);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String billName,  List<BillOccurrence> occurrences,  BillStats stats,  Money feesThisYear)  $default,) {final _that = this;
switch (_that) {
case _BillHistoryState():
return $default(_that.billName,_that.occurrences,_that.stats,_that.feesThisYear);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String billName,  List<BillOccurrence> occurrences,  BillStats stats,  Money feesThisYear)?  $default,) {final _that = this;
switch (_that) {
case _BillHistoryState() when $default != null:
return $default(_that.billName,_that.occurrences,_that.stats,_that.feesThisYear);case _:
  return null;

}
}

}

/// @nodoc


class _BillHistoryState extends BillHistoryState {
  const _BillHistoryState({required this.billName, required  List<BillOccurrence> occurrences, required this.stats, required this.feesThisYear}): _occurrences = occurrences,super._();
  

@override final  String billName;
 final  List<BillOccurrence> _occurrences;
@override List<BillOccurrence> get occurrences {
  if (_occurrences is EqualUnmodifiableListView) return _occurrences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_occurrences);
}

@override final  BillStats stats;
@override final  Money feesThisYear;

/// Create a copy of BillHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillHistoryStateCopyWith<_BillHistoryState> get copyWith => __$BillHistoryStateCopyWithImpl<_BillHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillHistoryState&&(identical(other.billName, billName) || other.billName == billName)&&const DeepCollectionEquality().equals(other.occurrences, _occurrences)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.feesThisYear, feesThisYear) || other.feesThisYear == feesThisYear));
}


@override
int get hashCode {
    return Object.hash(runtimeType,billName,const DeepCollectionEquality().hash(_occurrences),stats,feesThisYear);
}

@override
String toString() {
    return 'BillHistoryState(billName: $billName, occurrences: $occurrences, stats: $stats, feesThisYear: $feesThisYear)';
}


}

/// @nodoc
abstract mixin class _$BillHistoryStateCopyWith<$Res> implements $BillHistoryStateCopyWith<$Res> {
  factory _$BillHistoryStateCopyWith(_BillHistoryState value, $Res Function(_BillHistoryState) _then) = __$BillHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 String billName, List<BillOccurrence> occurrences, BillStats stats, Money feesThisYear
});




}
/// @nodoc
class __$BillHistoryStateCopyWithImpl<$Res>
    implements _$BillHistoryStateCopyWith<$Res> {
  __$BillHistoryStateCopyWithImpl(this._self, this._then);

  final _BillHistoryState _self;
  final $Res Function(_BillHistoryState) _then;

/// Create a copy of BillHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billName = null,Object? occurrences = null,Object? stats = null,Object? feesThisYear = null,}) {
  return _then(_BillHistoryState(
billName: null == billName ? _self.billName : billName // ignore: cast_nullable_to_non_nullable
as String,occurrences: null == occurrences ? _self._occurrences : occurrences // ignore: cast_nullable_to_non_nullable
as List<BillOccurrence>,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as BillStats,feesThisYear: null == feesThisYear ? _self.feesThisYear : feesThisYear // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

// dart format on
