// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bucket_accounts_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BucketAccountsState {

 List<BucketAccountVm> get buckets; List<AccountVm> get accounts; bool get someUnassigned; String? get errorCode;
/// Create a copy of BucketAccountsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketAccountsStateCopyWith<BucketAccountsState> get copyWith => _$BucketAccountsStateCopyWithImpl<BucketAccountsState>(this as BucketAccountsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BucketAccountsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketAccountsState&&const DeepCollectionEquality().equals(other.buckets, _this.buckets)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&(identical(other.someUnassigned, _this.someUnassigned) || other.someUnassigned == _this.someUnassigned)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as BucketAccountsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.buckets),const DeepCollectionEquality().hash(_this.accounts),_this.someUnassigned,_this.errorCode);
}

@override
String toString() {
  final _this = this as BucketAccountsState;
  return 'BucketAccountsState(buckets: ${_this.buckets}, accounts: ${_this.accounts}, someUnassigned: ${_this.someUnassigned}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $BucketAccountsStateCopyWith<$Res>  {
  factory $BucketAccountsStateCopyWith(BucketAccountsState value, $Res Function(BucketAccountsState) _then) = _$BucketAccountsStateCopyWithImpl;
@useResult
$Res call({
 List<BucketAccountVm> buckets, List<AccountVm> accounts, bool someUnassigned, String? errorCode
});




}
/// @nodoc
class _$BucketAccountsStateCopyWithImpl<$Res>
    implements $BucketAccountsStateCopyWith<$Res> {
  _$BucketAccountsStateCopyWithImpl(this._self, this._then);

  final BucketAccountsState _self;
  final $Res Function(BucketAccountsState) _then;

/// Create a copy of BucketAccountsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buckets = null,Object? accounts = null,Object? someUnassigned = null,Object? errorCode = freezed,}) {
  return _then(BucketAccountsState(
buckets: null == buckets ? _self.buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<BucketAccountVm>,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountVm>,someUnassigned: null == someUnassigned ? _self.someUnassigned : someUnassigned // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BucketAccountsState].
extension BucketAccountsStatePatterns on BucketAccountsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BucketAccountsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BucketAccountsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BucketAccountsState value)  $default,){
final _that = this;
switch (_that) {
case _BucketAccountsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BucketAccountsState value)?  $default,){
final _that = this;
switch (_that) {
case _BucketAccountsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BucketAccountVm> buckets,  List<AccountVm> accounts,  bool someUnassigned,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BucketAccountsState() when $default != null:
return $default(_that.buckets,_that.accounts,_that.someUnassigned,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BucketAccountVm> buckets,  List<AccountVm> accounts,  bool someUnassigned,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _BucketAccountsState():
return $default(_that.buckets,_that.accounts,_that.someUnassigned,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BucketAccountVm> buckets,  List<AccountVm> accounts,  bool someUnassigned,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _BucketAccountsState() when $default != null:
return $default(_that.buckets,_that.accounts,_that.someUnassigned,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _BucketAccountsState implements BucketAccountsState {
  const _BucketAccountsState({required  List<BucketAccountVm> buckets, required  List<AccountVm> accounts, required this.someUnassigned, this.errorCode}): _buckets = buckets,_accounts = accounts;
  

 final  List<BucketAccountVm> _buckets;
@override List<BucketAccountVm> get buckets {
  if (_buckets is EqualUnmodifiableListView) return _buckets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buckets);
}

 final  List<AccountVm> _accounts;
@override List<AccountVm> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

@override final  bool someUnassigned;
@override final  String? errorCode;

/// Create a copy of BucketAccountsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BucketAccountsStateCopyWith<_BucketAccountsState> get copyWith => __$BucketAccountsStateCopyWithImpl<_BucketAccountsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BucketAccountsState&&const DeepCollectionEquality().equals(other.buckets, _buckets)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&(identical(other.someUnassigned, someUnassigned) || other.someUnassigned == someUnassigned)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_buckets),const DeepCollectionEquality().hash(_accounts),someUnassigned,errorCode);
}

@override
String toString() {
    return 'BucketAccountsState(buckets: $buckets, accounts: $accounts, someUnassigned: $someUnassigned, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$BucketAccountsStateCopyWith<$Res> implements $BucketAccountsStateCopyWith<$Res> {
  factory _$BucketAccountsStateCopyWith(_BucketAccountsState value, $Res Function(_BucketAccountsState) _then) = __$BucketAccountsStateCopyWithImpl;
@override @useResult
$Res call({
 List<BucketAccountVm> buckets, List<AccountVm> accounts, bool someUnassigned, String? errorCode
});




}
/// @nodoc
class __$BucketAccountsStateCopyWithImpl<$Res>
    implements _$BucketAccountsStateCopyWith<$Res> {
  __$BucketAccountsStateCopyWithImpl(this._self, this._then);

  final _BucketAccountsState _self;
  final $Res Function(_BucketAccountsState) _then;

/// Create a copy of BucketAccountsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buckets = null,Object? accounts = null,Object? someUnassigned = null,Object? errorCode = freezed,}) {
  return _then(_BucketAccountsState(
buckets: null == buckets ? _self._buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<BucketAccountVm>,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountVm>,someUnassigned: null == someUnassigned ? _self.someUnassigned : someUnassigned // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
