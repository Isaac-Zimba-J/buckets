// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_pay_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PayAccountVm {

 String get id; String get name; bool get chargesFees;
/// Create a copy of PayAccountVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayAccountVmCopyWith<PayAccountVm> get copyWith => _$PayAccountVmCopyWithImpl<PayAccountVm>(this as PayAccountVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PayAccountVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayAccountVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.chargesFees, _this.chargesFees) || other.chargesFees == _this.chargesFees));
}


@override
int get hashCode {
  final _this = this as PayAccountVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.chargesFees);
}

@override
String toString() {
  final _this = this as PayAccountVm;
  return 'PayAccountVm(id: ${_this.id}, name: ${_this.name}, chargesFees: ${_this.chargesFees})';
}


}

/// @nodoc
abstract mixin class $PayAccountVmCopyWith<$Res>  {
  factory $PayAccountVmCopyWith(PayAccountVm value, $Res Function(PayAccountVm) _then) = _$PayAccountVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool chargesFees
});




}
/// @nodoc
class _$PayAccountVmCopyWithImpl<$Res>
    implements $PayAccountVmCopyWith<$Res> {
  _$PayAccountVmCopyWithImpl(this._self, this._then);

  final PayAccountVm _self;
  final $Res Function(PayAccountVm) _then;

/// Create a copy of PayAccountVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? chargesFees = null,}) {
  return _then(PayAccountVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,chargesFees: null == chargesFees ? _self.chargesFees : chargesFees // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PayAccountVm].
extension PayAccountVmPatterns on PayAccountVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayAccountVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayAccountVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayAccountVm value)  $default,){
final _that = this;
switch (_that) {
case _PayAccountVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayAccountVm value)?  $default,){
final _that = this;
switch (_that) {
case _PayAccountVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool chargesFees)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayAccountVm() when $default != null:
return $default(_that.id,_that.name,_that.chargesFees);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool chargesFees)  $default,) {final _that = this;
switch (_that) {
case _PayAccountVm():
return $default(_that.id,_that.name,_that.chargesFees);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool chargesFees)?  $default,) {final _that = this;
switch (_that) {
case _PayAccountVm() when $default != null:
return $default(_that.id,_that.name,_that.chargesFees);case _:
  return null;

}
}

}

/// @nodoc


class _PayAccountVm implements PayAccountVm {
  const _PayAccountVm({required this.id, required this.name, required this.chargesFees});
  

@override final  String id;
@override final  String name;
@override final  bool chargesFees;

/// Create a copy of PayAccountVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayAccountVmCopyWith<_PayAccountVm> get copyWith => __$PayAccountVmCopyWithImpl<_PayAccountVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayAccountVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.chargesFees, chargesFees) || other.chargesFees == chargesFees));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,chargesFees);
}

@override
String toString() {
    return 'PayAccountVm(id: $id, name: $name, chargesFees: $chargesFees)';
}


}

/// @nodoc
abstract mixin class _$PayAccountVmCopyWith<$Res> implements $PayAccountVmCopyWith<$Res> {
  factory _$PayAccountVmCopyWith(_PayAccountVm value, $Res Function(_PayAccountVm) _then) = __$PayAccountVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool chargesFees
});




}
/// @nodoc
class __$PayAccountVmCopyWithImpl<$Res>
    implements _$PayAccountVmCopyWith<$Res> {
  __$PayAccountVmCopyWithImpl(this._self, this._then);

  final _PayAccountVm _self;
  final $Res Function(_PayAccountVm) _then;

/// Create a copy of PayAccountVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? chargesFees = null,}) {
  return _then(_PayAccountVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,chargesFees: null == chargesFees ? _self.chargesFees : chargesFees // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$BillPayState {

 String get occurrenceId; String get billName; Money get expected; List<PayAccountVm> get accounts; String? get defaultAccountId; bool get saving; String? get errorCode;
/// Create a copy of BillPayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillPayStateCopyWith<BillPayState> get copyWith => _$BillPayStateCopyWithImpl<BillPayState>(this as BillPayState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BillPayState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillPayState&&(identical(other.occurrenceId, _this.occurrenceId) || other.occurrenceId == _this.occurrenceId)&&(identical(other.billName, _this.billName) || other.billName == _this.billName)&&(identical(other.expected, _this.expected) || other.expected == _this.expected)&&const DeepCollectionEquality().equals(other.accounts, _this.accounts)&&(identical(other.defaultAccountId, _this.defaultAccountId) || other.defaultAccountId == _this.defaultAccountId)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as BillPayState;
  return Object.hash(runtimeType,_this.occurrenceId,_this.billName,_this.expected,const DeepCollectionEquality().hash(_this.accounts),_this.defaultAccountId,_this.saving,_this.errorCode);
}

@override
String toString() {
  final _this = this as BillPayState;
  return 'BillPayState(occurrenceId: ${_this.occurrenceId}, billName: ${_this.billName}, expected: ${_this.expected}, accounts: ${_this.accounts}, defaultAccountId: ${_this.defaultAccountId}, saving: ${_this.saving}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $BillPayStateCopyWith<$Res>  {
  factory $BillPayStateCopyWith(BillPayState value, $Res Function(BillPayState) _then) = _$BillPayStateCopyWithImpl;
@useResult
$Res call({
 String occurrenceId, String billName, Money expected, List<PayAccountVm> accounts, String? defaultAccountId, bool saving, String? errorCode
});




}
/// @nodoc
class _$BillPayStateCopyWithImpl<$Res>
    implements $BillPayStateCopyWith<$Res> {
  _$BillPayStateCopyWithImpl(this._self, this._then);

  final BillPayState _self;
  final $Res Function(BillPayState) _then;

/// Create a copy of BillPayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? occurrenceId = null,Object? billName = null,Object? expected = null,Object? accounts = null,Object? defaultAccountId = freezed,Object? saving = null,Object? errorCode = freezed,}) {
  return _then(BillPayState(
occurrenceId: null == occurrenceId ? _self.occurrenceId : occurrenceId // ignore: cast_nullable_to_non_nullable
as String,billName: null == billName ? _self.billName : billName // ignore: cast_nullable_to_non_nullable
as String,expected: null == expected ? _self.expected : expected // ignore: cast_nullable_to_non_nullable
as Money,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<PayAccountVm>,defaultAccountId: freezed == defaultAccountId ? _self.defaultAccountId : defaultAccountId // ignore: cast_nullable_to_non_nullable
as String?,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BillPayState].
extension BillPayStatePatterns on BillPayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillPayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillPayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillPayState value)  $default,){
final _that = this;
switch (_that) {
case _BillPayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillPayState value)?  $default,){
final _that = this;
switch (_that) {
case _BillPayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String occurrenceId,  String billName,  Money expected,  List<PayAccountVm> accounts,  String? defaultAccountId,  bool saving,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillPayState() when $default != null:
return $default(_that.occurrenceId,_that.billName,_that.expected,_that.accounts,_that.defaultAccountId,_that.saving,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String occurrenceId,  String billName,  Money expected,  List<PayAccountVm> accounts,  String? defaultAccountId,  bool saving,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _BillPayState():
return $default(_that.occurrenceId,_that.billName,_that.expected,_that.accounts,_that.defaultAccountId,_that.saving,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String occurrenceId,  String billName,  Money expected,  List<PayAccountVm> accounts,  String? defaultAccountId,  bool saving,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _BillPayState() when $default != null:
return $default(_that.occurrenceId,_that.billName,_that.expected,_that.accounts,_that.defaultAccountId,_that.saving,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _BillPayState implements BillPayState {
  const _BillPayState({required this.occurrenceId, required this.billName, required this.expected, required  List<PayAccountVm> accounts, this.defaultAccountId, this.saving = false, this.errorCode}): _accounts = accounts;
  

@override final  String occurrenceId;
@override final  String billName;
@override final  Money expected;
 final  List<PayAccountVm> _accounts;
@override List<PayAccountVm> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

@override final  String? defaultAccountId;
@override@JsonKey() final  bool saving;
@override final  String? errorCode;

/// Create a copy of BillPayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillPayStateCopyWith<_BillPayState> get copyWith => __$BillPayStateCopyWithImpl<_BillPayState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillPayState&&(identical(other.occurrenceId, occurrenceId) || other.occurrenceId == occurrenceId)&&(identical(other.billName, billName) || other.billName == billName)&&(identical(other.expected, expected) || other.expected == expected)&&const DeepCollectionEquality().equals(other.accounts, _accounts)&&(identical(other.defaultAccountId, defaultAccountId) || other.defaultAccountId == defaultAccountId)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,occurrenceId,billName,expected,const DeepCollectionEquality().hash(_accounts),defaultAccountId,saving,errorCode);
}

@override
String toString() {
    return 'BillPayState(occurrenceId: $occurrenceId, billName: $billName, expected: $expected, accounts: $accounts, defaultAccountId: $defaultAccountId, saving: $saving, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$BillPayStateCopyWith<$Res> implements $BillPayStateCopyWith<$Res> {
  factory _$BillPayStateCopyWith(_BillPayState value, $Res Function(_BillPayState) _then) = __$BillPayStateCopyWithImpl;
@override @useResult
$Res call({
 String occurrenceId, String billName, Money expected, List<PayAccountVm> accounts, String? defaultAccountId, bool saving, String? errorCode
});




}
/// @nodoc
class __$BillPayStateCopyWithImpl<$Res>
    implements _$BillPayStateCopyWith<$Res> {
  __$BillPayStateCopyWithImpl(this._self, this._then);

  final _BillPayState _self;
  final $Res Function(_BillPayState) _then;

/// Create a copy of BillPayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? occurrenceId = null,Object? billName = null,Object? expected = null,Object? accounts = null,Object? defaultAccountId = freezed,Object? saving = null,Object? errorCode = freezed,}) {
  return _then(_BillPayState(
occurrenceId: null == occurrenceId ? _self.occurrenceId : occurrenceId // ignore: cast_nullable_to_non_nullable
as String,billName: null == billName ? _self.billName : billName // ignore: cast_nullable_to_non_nullable
as String,expected: null == expected ? _self.expected : expected // ignore: cast_nullable_to_non_nullable
as Money,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<PayAccountVm>,defaultAccountId: freezed == defaultAccountId ? _self.defaultAccountId : defaultAccountId // ignore: cast_nullable_to_non_nullable
as String?,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
