// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fees_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeesState {

 FeesSummary? get summary; List<Transaction> get missing;
/// Create a copy of FeesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeesStateCopyWith<FeesState> get copyWith => _$FeesStateCopyWithImpl<FeesState>(this as FeesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeesState&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.missing, _this.missing));
}


@override
int get hashCode {
  final _this = this as FeesState;
  return Object.hash(runtimeType,_this.summary,const DeepCollectionEquality().hash(_this.missing));
}

@override
String toString() {
  final _this = this as FeesState;
  return 'FeesState(summary: ${_this.summary}, missing: ${_this.missing})';
}


}

/// @nodoc
abstract mixin class $FeesStateCopyWith<$Res>  {
  factory $FeesStateCopyWith(FeesState value, $Res Function(FeesState) _then) = _$FeesStateCopyWithImpl;
@useResult
$Res call({
 FeesSummary? summary, List<Transaction> missing
});




}
/// @nodoc
class _$FeesStateCopyWithImpl<$Res>
    implements $FeesStateCopyWith<$Res> {
  _$FeesStateCopyWithImpl(this._self, this._then);

  final FeesState _self;
  final $Res Function(FeesState) _then;

/// Create a copy of FeesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = freezed,Object? missing = null,}) {
  return _then(FeesState(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as FeesSummary?,missing: null == missing ? _self.missing : missing // ignore: cast_nullable_to_non_nullable
as List<Transaction>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeesState].
extension FeesStatePatterns on FeesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeesState value)  $default,){
final _that = this;
switch (_that) {
case _FeesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeesState value)?  $default,){
final _that = this;
switch (_that) {
case _FeesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeesSummary? summary,  List<Transaction> missing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeesState() when $default != null:
return $default(_that.summary,_that.missing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeesSummary? summary,  List<Transaction> missing)  $default,) {final _that = this;
switch (_that) {
case _FeesState():
return $default(_that.summary,_that.missing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeesSummary? summary,  List<Transaction> missing)?  $default,) {final _that = this;
switch (_that) {
case _FeesState() when $default != null:
return $default(_that.summary,_that.missing);case _:
  return null;

}
}

}

/// @nodoc


class _FeesState extends FeesState {
  const _FeesState({required this.summary, required  List<Transaction> missing}): _missing = missing,super._();
  

@override final  FeesSummary? summary;
 final  List<Transaction> _missing;
@override List<Transaction> get missing {
  if (_missing is EqualUnmodifiableListView) return _missing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missing);
}


/// Create a copy of FeesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeesStateCopyWith<_FeesState> get copyWith => __$FeesStateCopyWithImpl<_FeesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeesState&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.missing, _missing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_missing));
}

@override
String toString() {
    return 'FeesState(summary: $summary, missing: $missing)';
}


}

/// @nodoc
abstract mixin class _$FeesStateCopyWith<$Res> implements $FeesStateCopyWith<$Res> {
  factory _$FeesStateCopyWith(_FeesState value, $Res Function(_FeesState) _then) = __$FeesStateCopyWithImpl;
@override @useResult
$Res call({
 FeesSummary? summary, List<Transaction> missing
});




}
/// @nodoc
class __$FeesStateCopyWithImpl<$Res>
    implements _$FeesStateCopyWith<$Res> {
  __$FeesStateCopyWithImpl(this._self, this._then);

  final _FeesState _self;
  final $Res Function(_FeesState) _then;

/// Create a copy of FeesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? missing = null,}) {
  return _then(_FeesState(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as FeesSummary?,missing: null == missing ? _self._missing : missing // ignore: cast_nullable_to_non_nullable
as List<Transaction>,
  ));
}


}

// dart format on
