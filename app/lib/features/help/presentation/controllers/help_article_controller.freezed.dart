// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_article_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HelpArticleState {

 HelpArticle get article; bool get feedbackGiven;
/// Create a copy of HelpArticleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HelpArticleStateCopyWith<HelpArticleState> get copyWith => _$HelpArticleStateCopyWithImpl<HelpArticleState>(this as HelpArticleState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HelpArticleState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HelpArticleState&&(identical(other.article, _this.article) || other.article == _this.article)&&(identical(other.feedbackGiven, _this.feedbackGiven) || other.feedbackGiven == _this.feedbackGiven));
}


@override
int get hashCode {
  final _this = this as HelpArticleState;
  return Object.hash(runtimeType,_this.article,_this.feedbackGiven);
}

@override
String toString() {
  final _this = this as HelpArticleState;
  return 'HelpArticleState(article: ${_this.article}, feedbackGiven: ${_this.feedbackGiven})';
}


}

/// @nodoc
abstract mixin class $HelpArticleStateCopyWith<$Res>  {
  factory $HelpArticleStateCopyWith(HelpArticleState value, $Res Function(HelpArticleState) _then) = _$HelpArticleStateCopyWithImpl;
@useResult
$Res call({
 HelpArticle article, bool feedbackGiven
});




}
/// @nodoc
class _$HelpArticleStateCopyWithImpl<$Res>
    implements $HelpArticleStateCopyWith<$Res> {
  _$HelpArticleStateCopyWithImpl(this._self, this._then);

  final HelpArticleState _self;
  final $Res Function(HelpArticleState) _then;

/// Create a copy of HelpArticleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? article = null,Object? feedbackGiven = null,}) {
  return _then(HelpArticleState(
article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as HelpArticle,feedbackGiven: null == feedbackGiven ? _self.feedbackGiven : feedbackGiven // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HelpArticleState].
extension HelpArticleStatePatterns on HelpArticleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HelpArticleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HelpArticleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HelpArticleState value)  $default,){
final _that = this;
switch (_that) {
case _HelpArticleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HelpArticleState value)?  $default,){
final _that = this;
switch (_that) {
case _HelpArticleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HelpArticle article,  bool feedbackGiven)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HelpArticleState() when $default != null:
return $default(_that.article,_that.feedbackGiven);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HelpArticle article,  bool feedbackGiven)  $default,) {final _that = this;
switch (_that) {
case _HelpArticleState():
return $default(_that.article,_that.feedbackGiven);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HelpArticle article,  bool feedbackGiven)?  $default,) {final _that = this;
switch (_that) {
case _HelpArticleState() when $default != null:
return $default(_that.article,_that.feedbackGiven);case _:
  return null;

}
}

}

/// @nodoc


class _HelpArticleState implements HelpArticleState {
  const _HelpArticleState({required this.article, this.feedbackGiven = false});
  

@override final  HelpArticle article;
@override@JsonKey() final  bool feedbackGiven;

/// Create a copy of HelpArticleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HelpArticleStateCopyWith<_HelpArticleState> get copyWith => __$HelpArticleStateCopyWithImpl<_HelpArticleState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HelpArticleState&&(identical(other.article, article) || other.article == article)&&(identical(other.feedbackGiven, feedbackGiven) || other.feedbackGiven == feedbackGiven));
}


@override
int get hashCode {
    return Object.hash(runtimeType,article,feedbackGiven);
}

@override
String toString() {
    return 'HelpArticleState(article: $article, feedbackGiven: $feedbackGiven)';
}


}

/// @nodoc
abstract mixin class _$HelpArticleStateCopyWith<$Res> implements $HelpArticleStateCopyWith<$Res> {
  factory _$HelpArticleStateCopyWith(_HelpArticleState value, $Res Function(_HelpArticleState) _then) = __$HelpArticleStateCopyWithImpl;
@override @useResult
$Res call({
 HelpArticle article, bool feedbackGiven
});




}
/// @nodoc
class __$HelpArticleStateCopyWithImpl<$Res>
    implements _$HelpArticleStateCopyWith<$Res> {
  __$HelpArticleStateCopyWithImpl(this._self, this._then);

  final _HelpArticleState _self;
  final $Res Function(_HelpArticleState) _then;

/// Create a copy of HelpArticleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? article = null,Object? feedbackGiven = null,}) {
  return _then(_HelpArticleState(
article: null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as HelpArticle,feedbackGiven: null == feedbackGiven ? _self.feedbackGiven : feedbackGiven // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
