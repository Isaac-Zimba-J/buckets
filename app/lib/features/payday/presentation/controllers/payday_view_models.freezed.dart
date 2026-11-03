// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payday_view_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransferRowVm {

 String get id; String get bucketId; String get bucketName; BucketColor get color; Money get amount; TransferStatus get status; Money? get owed;
/// Create a copy of TransferRowVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferRowVmCopyWith<TransferRowVm> get copyWith => _$TransferRowVmCopyWithImpl<TransferRowVm>(this as TransferRowVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TransferRowVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferRowVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.bucketId, _this.bucketId) || other.bucketId == _this.bucketId)&&(identical(other.bucketName, _this.bucketName) || other.bucketName == _this.bucketName)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.owed, _this.owed) || other.owed == _this.owed));
}


@override
int get hashCode {
  final _this = this as TransferRowVm;
  return Object.hash(runtimeType,_this.id,_this.bucketId,_this.bucketName,_this.color,_this.amount,_this.status,_this.owed);
}

@override
String toString() {
  final _this = this as TransferRowVm;
  return 'TransferRowVm(id: ${_this.id}, bucketId: ${_this.bucketId}, bucketName: ${_this.bucketName}, color: ${_this.color}, amount: ${_this.amount}, status: ${_this.status}, owed: ${_this.owed})';
}


}

/// @nodoc
abstract mixin class $TransferRowVmCopyWith<$Res>  {
  factory $TransferRowVmCopyWith(TransferRowVm value, $Res Function(TransferRowVm) _then) = _$TransferRowVmCopyWithImpl;
@useResult
$Res call({
 String id, String bucketId, String bucketName, BucketColor color, Money amount, TransferStatus status, Money? owed
});




}
/// @nodoc
class _$TransferRowVmCopyWithImpl<$Res>
    implements $TransferRowVmCopyWith<$Res> {
  _$TransferRowVmCopyWithImpl(this._self, this._then);

  final TransferRowVm _self;
  final $Res Function(TransferRowVm) _then;

/// Create a copy of TransferRowVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bucketId = null,Object? bucketName = null,Object? color = null,Object? amount = null,Object? status = null,Object? owed = freezed,}) {
  return _then(TransferRowVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,bucketName: null == bucketName ? _self.bucketName : bucketName // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferStatus,owed: freezed == owed ? _self.owed : owed // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferRowVm].
extension TransferRowVmPatterns on TransferRowVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferRowVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferRowVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferRowVm value)  $default,){
final _that = this;
switch (_that) {
case _TransferRowVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferRowVm value)?  $default,){
final _that = this;
switch (_that) {
case _TransferRowVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bucketId,  String bucketName,  BucketColor color,  Money amount,  TransferStatus status,  Money? owed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferRowVm() when $default != null:
return $default(_that.id,_that.bucketId,_that.bucketName,_that.color,_that.amount,_that.status,_that.owed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bucketId,  String bucketName,  BucketColor color,  Money amount,  TransferStatus status,  Money? owed)  $default,) {final _that = this;
switch (_that) {
case _TransferRowVm():
return $default(_that.id,_that.bucketId,_that.bucketName,_that.color,_that.amount,_that.status,_that.owed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bucketId,  String bucketName,  BucketColor color,  Money amount,  TransferStatus status,  Money? owed)?  $default,) {final _that = this;
switch (_that) {
case _TransferRowVm() when $default != null:
return $default(_that.id,_that.bucketId,_that.bucketName,_that.color,_that.amount,_that.status,_that.owed);case _:
  return null;

}
}

}

/// @nodoc


class _TransferRowVm implements TransferRowVm {
  const _TransferRowVm({required this.id, required this.bucketId, required this.bucketName, required this.color, required this.amount, required this.status, required this.owed});
  

@override final  String id;
@override final  String bucketId;
@override final  String bucketName;
@override final  BucketColor color;
@override final  Money amount;
@override final  TransferStatus status;
@override final  Money? owed;

/// Create a copy of TransferRowVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferRowVmCopyWith<_TransferRowVm> get copyWith => __$TransferRowVmCopyWithImpl<_TransferRowVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferRowVm&&(identical(other.id, id) || other.id == id)&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.bucketName, bucketName) || other.bucketName == bucketName)&&(identical(other.color, color) || other.color == color)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.owed, owed) || other.owed == owed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,bucketId,bucketName,color,amount,status,owed);
}

@override
String toString() {
    return 'TransferRowVm(id: $id, bucketId: $bucketId, bucketName: $bucketName, color: $color, amount: $amount, status: $status, owed: $owed)';
}


}

/// @nodoc
abstract mixin class _$TransferRowVmCopyWith<$Res> implements $TransferRowVmCopyWith<$Res> {
  factory _$TransferRowVmCopyWith(_TransferRowVm value, $Res Function(_TransferRowVm) _then) = __$TransferRowVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String bucketId, String bucketName, BucketColor color, Money amount, TransferStatus status, Money? owed
});




}
/// @nodoc
class __$TransferRowVmCopyWithImpl<$Res>
    implements _$TransferRowVmCopyWith<$Res> {
  __$TransferRowVmCopyWithImpl(this._self, this._then);

  final _TransferRowVm _self;
  final $Res Function(_TransferRowVm) _then;

/// Create a copy of TransferRowVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bucketId = null,Object? bucketName = null,Object? color = null,Object? amount = null,Object? status = null,Object? owed = freezed,}) {
  return _then(_TransferRowVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,bucketName: null == bucketName ? _self.bucketName : bucketName // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TransferStatus,owed: freezed == owed ? _self.owed : owed // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}


}

/// @nodoc
mixin _$CheckRowVm {

 ProofCheck get check; bool get passed; bool get unknown; String? get reason;
/// Create a copy of CheckRowVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckRowVmCopyWith<CheckRowVm> get copyWith => _$CheckRowVmCopyWithImpl<CheckRowVm>(this as CheckRowVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckRowVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckRowVm&&(identical(other.check, _this.check) || other.check == _this.check)&&(identical(other.passed, _this.passed) || other.passed == _this.passed)&&(identical(other.unknown, _this.unknown) || other.unknown == _this.unknown)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}


@override
int get hashCode {
  final _this = this as CheckRowVm;
  return Object.hash(runtimeType,_this.check,_this.passed,_this.unknown,_this.reason);
}

@override
String toString() {
  final _this = this as CheckRowVm;
  return 'CheckRowVm(check: ${_this.check}, passed: ${_this.passed}, unknown: ${_this.unknown}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $CheckRowVmCopyWith<$Res>  {
  factory $CheckRowVmCopyWith(CheckRowVm value, $Res Function(CheckRowVm) _then) = _$CheckRowVmCopyWithImpl;
@useResult
$Res call({
 ProofCheck check, bool passed, bool unknown, String? reason
});




}
/// @nodoc
class _$CheckRowVmCopyWithImpl<$Res>
    implements $CheckRowVmCopyWith<$Res> {
  _$CheckRowVmCopyWithImpl(this._self, this._then);

  final CheckRowVm _self;
  final $Res Function(CheckRowVm) _then;

/// Create a copy of CheckRowVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? check = null,Object? passed = null,Object? unknown = null,Object? reason = freezed,}) {
  return _then(CheckRowVm(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as ProofCheck,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckRowVm].
extension CheckRowVmPatterns on CheckRowVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckRowVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckRowVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckRowVm value)  $default,){
final _that = this;
switch (_that) {
case _CheckRowVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckRowVm value)?  $default,){
final _that = this;
switch (_that) {
case _CheckRowVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProofCheck check,  bool passed,  bool unknown,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckRowVm() when $default != null:
return $default(_that.check,_that.passed,_that.unknown,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProofCheck check,  bool passed,  bool unknown,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _CheckRowVm():
return $default(_that.check,_that.passed,_that.unknown,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProofCheck check,  bool passed,  bool unknown,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _CheckRowVm() when $default != null:
return $default(_that.check,_that.passed,_that.unknown,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _CheckRowVm implements CheckRowVm {
  const _CheckRowVm({required this.check, required this.passed, required this.unknown, required this.reason});
  

@override final  ProofCheck check;
@override final  bool passed;
@override final  bool unknown;
@override final  String? reason;

/// Create a copy of CheckRowVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckRowVmCopyWith<_CheckRowVm> get copyWith => __$CheckRowVmCopyWithImpl<_CheckRowVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckRowVm&&(identical(other.check, check) || other.check == check)&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.unknown, unknown) || other.unknown == unknown)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,check,passed,unknown,reason);
}

@override
String toString() {
    return 'CheckRowVm(check: $check, passed: $passed, unknown: $unknown, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CheckRowVmCopyWith<$Res> implements $CheckRowVmCopyWith<$Res> {
  factory _$CheckRowVmCopyWith(_CheckRowVm value, $Res Function(_CheckRowVm) _then) = __$CheckRowVmCopyWithImpl;
@override @useResult
$Res call({
 ProofCheck check, bool passed, bool unknown, String? reason
});




}
/// @nodoc
class __$CheckRowVmCopyWithImpl<$Res>
    implements _$CheckRowVmCopyWith<$Res> {
  __$CheckRowVmCopyWithImpl(this._self, this._then);

  final _CheckRowVm _self;
  final $Res Function(_CheckRowVm) _then;

/// Create a copy of CheckRowVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? check = null,Object? passed = null,Object? unknown = null,Object? reason = freezed,}) {
  return _then(_CheckRowVm(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as ProofCheck,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,unknown: null == unknown ? _self.unknown : unknown // ignore: cast_nullable_to_non_nullable
as bool,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
