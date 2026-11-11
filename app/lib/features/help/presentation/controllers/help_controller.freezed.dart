// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HelpState {

 List<HelpArticle> get results; String get query;
/// Create a copy of HelpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HelpStateCopyWith<HelpState> get copyWith => _$HelpStateCopyWithImpl<HelpState>(this as HelpState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HelpState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HelpState&&const DeepCollectionEquality().equals(other.results, _this.results)&&(identical(other.query, _this.query) || other.query == _this.query));
}


@override
int get hashCode {
  final _this = this as HelpState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.results),_this.query);
}

@override
String toString() {
  final _this = this as HelpState;
  return 'HelpState(results: ${_this.results}, query: ${_this.query})';
}


}

/// @nodoc
abstract mixin class $HelpStateCopyWith<$Res>  {
  factory $HelpStateCopyWith(HelpState value, $Res Function(HelpState) _then) = _$HelpStateCopyWithImpl;
@useResult
$Res call({
 List<HelpArticle> results, String query
});




}
/// @nodoc
class _$HelpStateCopyWithImpl<$Res>
    implements $HelpStateCopyWith<$Res> {
  _$HelpStateCopyWithImpl(this._self, this._then);

  final HelpState _self;
  final $Res Function(HelpState) _then;

/// Create a copy of HelpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,Object? query = null,}) {
  return _then(HelpState(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<HelpArticle>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HelpState].
extension HelpStatePatterns on HelpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HelpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HelpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HelpState value)  $default,){
final _that = this;
switch (_that) {
case _HelpState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HelpState value)?  $default,){
final _that = this;
switch (_that) {
case _HelpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HelpArticle> results,  String query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HelpState() when $default != null:
return $default(_that.results,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HelpArticle> results,  String query)  $default,) {final _that = this;
switch (_that) {
case _HelpState():
return $default(_that.results,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HelpArticle> results,  String query)?  $default,) {final _that = this;
switch (_that) {
case _HelpState() when $default != null:
return $default(_that.results,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _HelpState implements HelpState {
  const _HelpState({required  List<HelpArticle> results, this.query = ''}): _results = results;
  

 final  List<HelpArticle> _results;
@override List<HelpArticle> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override@JsonKey() final  String query;

/// Create a copy of HelpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HelpStateCopyWith<_HelpState> get copyWith => __$HelpStateCopyWithImpl<_HelpState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HelpState&&const DeepCollectionEquality().equals(other.results, _results)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),query);
}

@override
String toString() {
    return 'HelpState(results: $results, query: $query)';
}


}

/// @nodoc
abstract mixin class _$HelpStateCopyWith<$Res> implements $HelpStateCopyWith<$Res> {
  factory _$HelpStateCopyWith(_HelpState value, $Res Function(_HelpState) _then) = __$HelpStateCopyWithImpl;
@override @useResult
$Res call({
 List<HelpArticle> results, String query
});




}
/// @nodoc
class __$HelpStateCopyWithImpl<$Res>
    implements _$HelpStateCopyWith<$Res> {
  __$HelpStateCopyWithImpl(this._self, this._then);

  final _HelpState _self;
  final $Res Function(_HelpState) _then;

/// Create a copy of HelpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,Object? query = null,}) {
  return _then(_HelpState(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<HelpArticle>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
