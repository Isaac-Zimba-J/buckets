// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rules_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RulesState {

 List<Category> get categories; String? get errorCode;
/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesStateCopyWith<RulesState> get copyWith => _$RulesStateCopyWithImpl<RulesState>(this as RulesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RulesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesState&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as RulesState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.categories),_this.errorCode);
}

@override
String toString() {
  final _this = this as RulesState;
  return 'RulesState(categories: ${_this.categories}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $RulesStateCopyWith<$Res>  {
  factory $RulesStateCopyWith(RulesState value, $Res Function(RulesState) _then) = _$RulesStateCopyWithImpl;
@useResult
$Res call({
 List<Category> categories, String? errorCode
});




}
/// @nodoc
class _$RulesStateCopyWithImpl<$Res>
    implements $RulesStateCopyWith<$Res> {
  _$RulesStateCopyWithImpl(this._self, this._then);

  final RulesState _self;
  final $Res Function(RulesState) _then;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? errorCode = freezed,}) {
  return _then(RulesState(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RulesState].
extension RulesStatePatterns on RulesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RulesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RulesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RulesState value)  $default,){
final _that = this;
switch (_that) {
case _RulesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RulesState value)?  $default,){
final _that = this;
switch (_that) {
case _RulesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Category> categories,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RulesState() when $default != null:
return $default(_that.categories,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Category> categories,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _RulesState():
return $default(_that.categories,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Category> categories,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _RulesState() when $default != null:
return $default(_that.categories,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _RulesState implements RulesState {
  const _RulesState({required  List<Category> categories, this.errorCode}): _categories = categories;
  

 final  List<Category> _categories;
@override List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  String? errorCode;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RulesStateCopyWith<_RulesState> get copyWith => __$RulesStateCopyWithImpl<_RulesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RulesState&&const DeepCollectionEquality().equals(other.categories, _categories)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),errorCode);
}

@override
String toString() {
    return 'RulesState(categories: $categories, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$RulesStateCopyWith<$Res> implements $RulesStateCopyWith<$Res> {
  factory _$RulesStateCopyWith(_RulesState value, $Res Function(_RulesState) _then) = __$RulesStateCopyWithImpl;
@override @useResult
$Res call({
 List<Category> categories, String? errorCode
});




}
/// @nodoc
class __$RulesStateCopyWithImpl<$Res>
    implements _$RulesStateCopyWith<$Res> {
  __$RulesStateCopyWithImpl(this._self, this._then);

  final _RulesState _self;
  final $Res Function(_RulesState) _then;

/// Create a copy of RulesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? errorCode = freezed,}) {
  return _then(_RulesState(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
