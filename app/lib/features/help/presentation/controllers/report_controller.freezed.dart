// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportState {

 ProblemCategory get category; String get text; bool get includeAppInfo; bool get sending; bool get sent; String? get errorCode;
/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportStateCopyWith<ReportState> get copyWith => _$ReportStateCopyWithImpl<ReportState>(this as ReportState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReportState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportState&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.includeAppInfo, _this.includeAppInfo) || other.includeAppInfo == _this.includeAppInfo)&&(identical(other.sending, _this.sending) || other.sending == _this.sending)&&(identical(other.sent, _this.sent) || other.sent == _this.sent)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as ReportState;
  return Object.hash(runtimeType,_this.category,_this.text,_this.includeAppInfo,_this.sending,_this.sent,_this.errorCode);
}

@override
String toString() {
  final _this = this as ReportState;
  return 'ReportState(category: ${_this.category}, text: ${_this.text}, includeAppInfo: ${_this.includeAppInfo}, sending: ${_this.sending}, sent: ${_this.sent}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $ReportStateCopyWith<$Res>  {
  factory $ReportStateCopyWith(ReportState value, $Res Function(ReportState) _then) = _$ReportStateCopyWithImpl;
@useResult
$Res call({
 ProblemCategory category, String text, bool includeAppInfo, bool sending, bool sent, String? errorCode
});




}
/// @nodoc
class _$ReportStateCopyWithImpl<$Res>
    implements $ReportStateCopyWith<$Res> {
  _$ReportStateCopyWithImpl(this._self, this._then);

  final ReportState _self;
  final $Res Function(ReportState) _then;

/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? text = null,Object? includeAppInfo = null,Object? sending = null,Object? sent = null,Object? errorCode = freezed,}) {
  return _then(ReportState(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProblemCategory,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,includeAppInfo: null == includeAppInfo ? _self.includeAppInfo : includeAppInfo // ignore: cast_nullable_to_non_nullable
as bool,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportState].
extension ReportStatePatterns on ReportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportState value)  $default,){
final _that = this;
switch (_that) {
case _ReportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProblemCategory category,  String text,  bool includeAppInfo,  bool sending,  bool sent,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportState() when $default != null:
return $default(_that.category,_that.text,_that.includeAppInfo,_that.sending,_that.sent,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProblemCategory category,  String text,  bool includeAppInfo,  bool sending,  bool sent,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _ReportState():
return $default(_that.category,_that.text,_that.includeAppInfo,_that.sending,_that.sent,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProblemCategory category,  String text,  bool includeAppInfo,  bool sending,  bool sent,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _ReportState() when $default != null:
return $default(_that.category,_that.text,_that.includeAppInfo,_that.sending,_that.sent,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _ReportState implements ReportState {
  const _ReportState({this.category = ProblemCategory.somethingWrong, this.text = '', this.includeAppInfo = false, this.sending = false, this.sent = false, this.errorCode});
  

@override@JsonKey() final  ProblemCategory category;
@override@JsonKey() final  String text;
@override@JsonKey() final  bool includeAppInfo;
@override@JsonKey() final  bool sending;
@override@JsonKey() final  bool sent;
@override final  String? errorCode;

/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportStateCopyWith<_ReportState> get copyWith => __$ReportStateCopyWithImpl<_ReportState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportState&&(identical(other.category, category) || other.category == category)&&(identical(other.text, text) || other.text == text)&&(identical(other.includeAppInfo, includeAppInfo) || other.includeAppInfo == includeAppInfo)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.sent, sent) || other.sent == sent)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,category,text,includeAppInfo,sending,sent,errorCode);
}

@override
String toString() {
    return 'ReportState(category: $category, text: $text, includeAppInfo: $includeAppInfo, sending: $sending, sent: $sent, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$ReportStateCopyWith<$Res> implements $ReportStateCopyWith<$Res> {
  factory _$ReportStateCopyWith(_ReportState value, $Res Function(_ReportState) _then) = __$ReportStateCopyWithImpl;
@override @useResult
$Res call({
 ProblemCategory category, String text, bool includeAppInfo, bool sending, bool sent, String? errorCode
});




}
/// @nodoc
class __$ReportStateCopyWithImpl<$Res>
    implements _$ReportStateCopyWith<$Res> {
  __$ReportStateCopyWithImpl(this._self, this._then);

  final _ReportState _self;
  final $Res Function(_ReportState) _then;

/// Create a copy of ReportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? text = null,Object? includeAppInfo = null,Object? sending = null,Object? sent = null,Object? errorCode = freezed,}) {
  return _then(_ReportState(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProblemCategory,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,includeAppInfo: null == includeAppInfo ? _self.includeAppInfo : includeAppInfo // ignore: cast_nullable_to_non_nullable
as bool,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,sent: null == sent ? _self.sent : sent // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
