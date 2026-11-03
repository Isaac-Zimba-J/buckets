// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_view_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomeVm {

 String get id; String get name; IncomeKind get kind; Money? get expected; int? get paydayOfMonth;
/// Create a copy of IncomeVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeVmCopyWith<IncomeVm> get copyWith => _$IncomeVmCopyWithImpl<IncomeVm>(this as IncomeVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as IncomeVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.expected, _this.expected) || other.expected == _this.expected)&&(identical(other.paydayOfMonth, _this.paydayOfMonth) || other.paydayOfMonth == _this.paydayOfMonth));
}


@override
int get hashCode {
  final _this = this as IncomeVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.expected,_this.paydayOfMonth);
}

@override
String toString() {
  final _this = this as IncomeVm;
  return 'IncomeVm(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, expected: ${_this.expected}, paydayOfMonth: ${_this.paydayOfMonth})';
}


}

/// @nodoc
abstract mixin class $IncomeVmCopyWith<$Res>  {
  factory $IncomeVmCopyWith(IncomeVm value, $Res Function(IncomeVm) _then) = _$IncomeVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, IncomeKind kind, Money? expected, int? paydayOfMonth
});




}
/// @nodoc
class _$IncomeVmCopyWithImpl<$Res>
    implements $IncomeVmCopyWith<$Res> {
  _$IncomeVmCopyWithImpl(this._self, this._then);

  final IncomeVm _self;
  final $Res Function(IncomeVm) _then;

/// Create a copy of IncomeVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? expected = freezed,Object? paydayOfMonth = freezed,}) {
  return _then(IncomeVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as IncomeKind,expected: freezed == expected ? _self.expected : expected // ignore: cast_nullable_to_non_nullable
as Money?,paydayOfMonth: freezed == paydayOfMonth ? _self.paydayOfMonth : paydayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeVm].
extension IncomeVmPatterns on IncomeVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeVm value)  $default,){
final _that = this;
switch (_that) {
case _IncomeVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeVm value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  IncomeKind kind,  Money? expected,  int? paydayOfMonth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeVm() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.expected,_that.paydayOfMonth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  IncomeKind kind,  Money? expected,  int? paydayOfMonth)  $default,) {final _that = this;
switch (_that) {
case _IncomeVm():
return $default(_that.id,_that.name,_that.kind,_that.expected,_that.paydayOfMonth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  IncomeKind kind,  Money? expected,  int? paydayOfMonth)?  $default,) {final _that = this;
switch (_that) {
case _IncomeVm() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.expected,_that.paydayOfMonth);case _:
  return null;

}
}

}

/// @nodoc


class _IncomeVm implements IncomeVm {
  const _IncomeVm({required this.id, required this.name, required this.kind, required this.expected, required this.paydayOfMonth});
  

@override final  String id;
@override final  String name;
@override final  IncomeKind kind;
@override final  Money? expected;
@override final  int? paydayOfMonth;

/// Create a copy of IncomeVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeVmCopyWith<_IncomeVm> get copyWith => __$IncomeVmCopyWithImpl<_IncomeVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.expected, expected) || other.expected == expected)&&(identical(other.paydayOfMonth, paydayOfMonth) || other.paydayOfMonth == paydayOfMonth));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,expected,paydayOfMonth);
}

@override
String toString() {
    return 'IncomeVm(id: $id, name: $name, kind: $kind, expected: $expected, paydayOfMonth: $paydayOfMonth)';
}


}

/// @nodoc
abstract mixin class _$IncomeVmCopyWith<$Res> implements $IncomeVmCopyWith<$Res> {
  factory _$IncomeVmCopyWith(_IncomeVm value, $Res Function(_IncomeVm) _then) = __$IncomeVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, IncomeKind kind, Money? expected, int? paydayOfMonth
});




}
/// @nodoc
class __$IncomeVmCopyWithImpl<$Res>
    implements _$IncomeVmCopyWith<$Res> {
  __$IncomeVmCopyWithImpl(this._self, this._then);

  final _IncomeVm _self;
  final $Res Function(_IncomeVm) _then;

/// Create a copy of IncomeVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? expected = freezed,Object? paydayOfMonth = freezed,}) {
  return _then(_IncomeVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as IncomeKind,expected: freezed == expected ? _self.expected : expected // ignore: cast_nullable_to_non_nullable
as Money?,paydayOfMonth: freezed == paydayOfMonth ? _self.paydayOfMonth : paydayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$BillVm {

 String get id; String get name; Money get amount; int get everyMonths; Money get reservation; Money get putAside;
/// Create a copy of BillVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillVmCopyWith<BillVm> get copyWith => _$BillVmCopyWithImpl<BillVm>(this as BillVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BillVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.everyMonths, _this.everyMonths) || other.everyMonths == _this.everyMonths)&&(identical(other.reservation, _this.reservation) || other.reservation == _this.reservation)&&(identical(other.putAside, _this.putAside) || other.putAside == _this.putAside));
}


@override
int get hashCode {
  final _this = this as BillVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.amount,_this.everyMonths,_this.reservation,_this.putAside);
}

@override
String toString() {
  final _this = this as BillVm;
  return 'BillVm(id: ${_this.id}, name: ${_this.name}, amount: ${_this.amount}, everyMonths: ${_this.everyMonths}, reservation: ${_this.reservation}, putAside: ${_this.putAside})';
}


}

/// @nodoc
abstract mixin class $BillVmCopyWith<$Res>  {
  factory $BillVmCopyWith(BillVm value, $Res Function(BillVm) _then) = _$BillVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, Money amount, int everyMonths, Money reservation, Money putAside
});




}
/// @nodoc
class _$BillVmCopyWithImpl<$Res>
    implements $BillVmCopyWith<$Res> {
  _$BillVmCopyWithImpl(this._self, this._then);

  final BillVm _self;
  final $Res Function(BillVm) _then;

/// Create a copy of BillVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? everyMonths = null,Object? reservation = null,Object? putAside = null,}) {
  return _then(BillVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,everyMonths: null == everyMonths ? _self.everyMonths : everyMonths // ignore: cast_nullable_to_non_nullable
as int,reservation: null == reservation ? _self.reservation : reservation // ignore: cast_nullable_to_non_nullable
as Money,putAside: null == putAside ? _self.putAside : putAside // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [BillVm].
extension BillVmPatterns on BillVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillVm value)  $default,){
final _that = this;
switch (_that) {
case _BillVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillVm value)?  $default,){
final _that = this;
switch (_that) {
case _BillVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Money amount,  int everyMonths,  Money reservation,  Money putAside)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillVm() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.everyMonths,_that.reservation,_that.putAside);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Money amount,  int everyMonths,  Money reservation,  Money putAside)  $default,) {final _that = this;
switch (_that) {
case _BillVm():
return $default(_that.id,_that.name,_that.amount,_that.everyMonths,_that.reservation,_that.putAside);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Money amount,  int everyMonths,  Money reservation,  Money putAside)?  $default,) {final _that = this;
switch (_that) {
case _BillVm() when $default != null:
return $default(_that.id,_that.name,_that.amount,_that.everyMonths,_that.reservation,_that.putAside);case _:
  return null;

}
}

}

/// @nodoc


class _BillVm implements BillVm {
  const _BillVm({required this.id, required this.name, required this.amount, required this.everyMonths, required this.reservation, required this.putAside});
  

@override final  String id;
@override final  String name;
@override final  Money amount;
@override final  int everyMonths;
@override final  Money reservation;
@override final  Money putAside;

/// Create a copy of BillVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillVmCopyWith<_BillVm> get copyWith => __$BillVmCopyWithImpl<_BillVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.everyMonths, everyMonths) || other.everyMonths == everyMonths)&&(identical(other.reservation, reservation) || other.reservation == reservation)&&(identical(other.putAside, putAside) || other.putAside == putAside));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,amount,everyMonths,reservation,putAside);
}

@override
String toString() {
    return 'BillVm(id: $id, name: $name, amount: $amount, everyMonths: $everyMonths, reservation: $reservation, putAside: $putAside)';
}


}

/// @nodoc
abstract mixin class _$BillVmCopyWith<$Res> implements $BillVmCopyWith<$Res> {
  factory _$BillVmCopyWith(_BillVm value, $Res Function(_BillVm) _then) = __$BillVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Money amount, int everyMonths, Money reservation, Money putAside
});




}
/// @nodoc
class __$BillVmCopyWithImpl<$Res>
    implements _$BillVmCopyWith<$Res> {
  __$BillVmCopyWithImpl(this._self, this._then);

  final _BillVm _self;
  final $Res Function(_BillVm) _then;

/// Create a copy of BillVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? amount = null,Object? everyMonths = null,Object? reservation = null,Object? putAside = null,}) {
  return _then(_BillVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,everyMonths: null == everyMonths ? _self.everyMonths : everyMonths // ignore: cast_nullable_to_non_nullable
as int,reservation: null == reservation ? _self.reservation : reservation // ignore: cast_nullable_to_non_nullable
as Money,putAside: null == putAside ? _self.putAside : putAside // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$AllocationVm {

 String get bucketId; String get name; BucketColor get color; int get basisPoints; Money? get share;
/// Create a copy of AllocationVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllocationVmCopyWith<AllocationVm> get copyWith => _$AllocationVmCopyWithImpl<AllocationVm>(this as AllocationVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AllocationVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllocationVm&&(identical(other.bucketId, _this.bucketId) || other.bucketId == _this.bucketId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.basisPoints, _this.basisPoints) || other.basisPoints == _this.basisPoints)&&(identical(other.share, _this.share) || other.share == _this.share));
}


@override
int get hashCode {
  final _this = this as AllocationVm;
  return Object.hash(runtimeType,_this.bucketId,_this.name,_this.color,_this.basisPoints,_this.share);
}

@override
String toString() {
  final _this = this as AllocationVm;
  return 'AllocationVm(bucketId: ${_this.bucketId}, name: ${_this.name}, color: ${_this.color}, basisPoints: ${_this.basisPoints}, share: ${_this.share})';
}


}

/// @nodoc
abstract mixin class $AllocationVmCopyWith<$Res>  {
  factory $AllocationVmCopyWith(AllocationVm value, $Res Function(AllocationVm) _then) = _$AllocationVmCopyWithImpl;
@useResult
$Res call({
 String bucketId, String name, BucketColor color, int basisPoints, Money? share
});




}
/// @nodoc
class _$AllocationVmCopyWithImpl<$Res>
    implements $AllocationVmCopyWith<$Res> {
  _$AllocationVmCopyWithImpl(this._self, this._then);

  final AllocationVm _self;
  final $Res Function(AllocationVm) _then;

/// Create a copy of AllocationVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bucketId = null,Object? name = null,Object? color = null,Object? basisPoints = null,Object? share = freezed,}) {
  return _then(AllocationVm(
bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,basisPoints: null == basisPoints ? _self.basisPoints : basisPoints // ignore: cast_nullable_to_non_nullable
as int,share: freezed == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}

}


/// Adds pattern-matching-related methods to [AllocationVm].
extension AllocationVmPatterns on AllocationVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllocationVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllocationVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllocationVm value)  $default,){
final _that = this;
switch (_that) {
case _AllocationVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllocationVm value)?  $default,){
final _that = this;
switch (_that) {
case _AllocationVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bucketId,  String name,  BucketColor color,  int basisPoints,  Money? share)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllocationVm() when $default != null:
return $default(_that.bucketId,_that.name,_that.color,_that.basisPoints,_that.share);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bucketId,  String name,  BucketColor color,  int basisPoints,  Money? share)  $default,) {final _that = this;
switch (_that) {
case _AllocationVm():
return $default(_that.bucketId,_that.name,_that.color,_that.basisPoints,_that.share);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bucketId,  String name,  BucketColor color,  int basisPoints,  Money? share)?  $default,) {final _that = this;
switch (_that) {
case _AllocationVm() when $default != null:
return $default(_that.bucketId,_that.name,_that.color,_that.basisPoints,_that.share);case _:
  return null;

}
}

}

/// @nodoc


class _AllocationVm implements AllocationVm {
  const _AllocationVm({required this.bucketId, required this.name, required this.color, required this.basisPoints, required this.share});
  

@override final  String bucketId;
@override final  String name;
@override final  BucketColor color;
@override final  int basisPoints;
@override final  Money? share;

/// Create a copy of AllocationVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllocationVmCopyWith<_AllocationVm> get copyWith => __$AllocationVmCopyWithImpl<_AllocationVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllocationVm&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.basisPoints, basisPoints) || other.basisPoints == basisPoints)&&(identical(other.share, share) || other.share == share));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bucketId,name,color,basisPoints,share);
}

@override
String toString() {
    return 'AllocationVm(bucketId: $bucketId, name: $name, color: $color, basisPoints: $basisPoints, share: $share)';
}


}

/// @nodoc
abstract mixin class _$AllocationVmCopyWith<$Res> implements $AllocationVmCopyWith<$Res> {
  factory _$AllocationVmCopyWith(_AllocationVm value, $Res Function(_AllocationVm) _then) = __$AllocationVmCopyWithImpl;
@override @useResult
$Res call({
 String bucketId, String name, BucketColor color, int basisPoints, Money? share
});




}
/// @nodoc
class __$AllocationVmCopyWithImpl<$Res>
    implements _$AllocationVmCopyWith<$Res> {
  __$AllocationVmCopyWithImpl(this._self, this._then);

  final _AllocationVm _self;
  final $Res Function(_AllocationVm) _then;

/// Create a copy of AllocationVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucketId = null,Object? name = null,Object? color = null,Object? basisPoints = null,Object? share = freezed,}) {
  return _then(_AllocationVm(
bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,basisPoints: null == basisPoints ? _self.basisPoints : basisPoints // ignore: cast_nullable_to_non_nullable
as int,share: freezed == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}


}

/// @nodoc
mixin _$BucketAccountVm {

 String get bucketId; String get name; BucketColor get color; String? get accountId; String? get accountName; bool get warning;
/// Create a copy of BucketAccountVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketAccountVmCopyWith<BucketAccountVm> get copyWith => _$BucketAccountVmCopyWithImpl<BucketAccountVm>(this as BucketAccountVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BucketAccountVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketAccountVm&&(identical(other.bucketId, _this.bucketId) || other.bucketId == _this.bucketId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.accountName, _this.accountName) || other.accountName == _this.accountName)&&(identical(other.warning, _this.warning) || other.warning == _this.warning));
}


@override
int get hashCode {
  final _this = this as BucketAccountVm;
  return Object.hash(runtimeType,_this.bucketId,_this.name,_this.color,_this.accountId,_this.accountName,_this.warning);
}

@override
String toString() {
  final _this = this as BucketAccountVm;
  return 'BucketAccountVm(bucketId: ${_this.bucketId}, name: ${_this.name}, color: ${_this.color}, accountId: ${_this.accountId}, accountName: ${_this.accountName}, warning: ${_this.warning})';
}


}

/// @nodoc
abstract mixin class $BucketAccountVmCopyWith<$Res>  {
  factory $BucketAccountVmCopyWith(BucketAccountVm value, $Res Function(BucketAccountVm) _then) = _$BucketAccountVmCopyWithImpl;
@useResult
$Res call({
 String bucketId, String name, BucketColor color, String? accountId, String? accountName, bool warning
});




}
/// @nodoc
class _$BucketAccountVmCopyWithImpl<$Res>
    implements $BucketAccountVmCopyWith<$Res> {
  _$BucketAccountVmCopyWithImpl(this._self, this._then);

  final BucketAccountVm _self;
  final $Res Function(BucketAccountVm) _then;

/// Create a copy of BucketAccountVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bucketId = null,Object? name = null,Object? color = null,Object? accountId = freezed,Object? accountName = freezed,Object? warning = null,}) {
  return _then(BucketAccountVm(
bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BucketAccountVm].
extension BucketAccountVmPatterns on BucketAccountVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BucketAccountVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BucketAccountVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BucketAccountVm value)  $default,){
final _that = this;
switch (_that) {
case _BucketAccountVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BucketAccountVm value)?  $default,){
final _that = this;
switch (_that) {
case _BucketAccountVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bucketId,  String name,  BucketColor color,  String? accountId,  String? accountName,  bool warning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BucketAccountVm() when $default != null:
return $default(_that.bucketId,_that.name,_that.color,_that.accountId,_that.accountName,_that.warning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bucketId,  String name,  BucketColor color,  String? accountId,  String? accountName,  bool warning)  $default,) {final _that = this;
switch (_that) {
case _BucketAccountVm():
return $default(_that.bucketId,_that.name,_that.color,_that.accountId,_that.accountName,_that.warning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bucketId,  String name,  BucketColor color,  String? accountId,  String? accountName,  bool warning)?  $default,) {final _that = this;
switch (_that) {
case _BucketAccountVm() when $default != null:
return $default(_that.bucketId,_that.name,_that.color,_that.accountId,_that.accountName,_that.warning);case _:
  return null;

}
}

}

/// @nodoc


class _BucketAccountVm implements BucketAccountVm {
  const _BucketAccountVm({required this.bucketId, required this.name, required this.color, required this.accountId, required this.accountName, required this.warning});
  

@override final  String bucketId;
@override final  String name;
@override final  BucketColor color;
@override final  String? accountId;
@override final  String? accountName;
@override final  bool warning;

/// Create a copy of BucketAccountVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BucketAccountVmCopyWith<_BucketAccountVm> get copyWith => __$BucketAccountVmCopyWithImpl<_BucketAccountVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BucketAccountVm&&(identical(other.bucketId, bucketId) || other.bucketId == bucketId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.warning, warning) || other.warning == warning));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bucketId,name,color,accountId,accountName,warning);
}

@override
String toString() {
    return 'BucketAccountVm(bucketId: $bucketId, name: $name, color: $color, accountId: $accountId, accountName: $accountName, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$BucketAccountVmCopyWith<$Res> implements $BucketAccountVmCopyWith<$Res> {
  factory _$BucketAccountVmCopyWith(_BucketAccountVm value, $Res Function(_BucketAccountVm) _then) = __$BucketAccountVmCopyWithImpl;
@override @useResult
$Res call({
 String bucketId, String name, BucketColor color, String? accountId, String? accountName, bool warning
});




}
/// @nodoc
class __$BucketAccountVmCopyWithImpl<$Res>
    implements _$BucketAccountVmCopyWith<$Res> {
  __$BucketAccountVmCopyWithImpl(this._self, this._then);

  final _BucketAccountVm _self;
  final $Res Function(_BucketAccountVm) _then;

/// Create a copy of BucketAccountVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucketId = null,Object? name = null,Object? color = null,Object? accountId = freezed,Object? accountName = freezed,Object? warning = null,}) {
  return _then(_BucketAccountVm(
bucketId: null == bucketId ? _self.bucketId : bucketId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,warning: null == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$AccountVm {

 String get id; String get name; AccountKind get kind; bool get isSpending;
/// Create a copy of AccountVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountVmCopyWith<AccountVm> get copyWith => _$AccountVmCopyWithImpl<AccountVm>(this as AccountVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AccountVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.isSpending, _this.isSpending) || other.isSpending == _this.isSpending));
}


@override
int get hashCode {
  final _this = this as AccountVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.kind,_this.isSpending);
}

@override
String toString() {
  final _this = this as AccountVm;
  return 'AccountVm(id: ${_this.id}, name: ${_this.name}, kind: ${_this.kind}, isSpending: ${_this.isSpending})';
}


}

/// @nodoc
abstract mixin class $AccountVmCopyWith<$Res>  {
  factory $AccountVmCopyWith(AccountVm value, $Res Function(AccountVm) _then) = _$AccountVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, AccountKind kind, bool isSpending
});




}
/// @nodoc
class _$AccountVmCopyWithImpl<$Res>
    implements $AccountVmCopyWith<$Res> {
  _$AccountVmCopyWithImpl(this._self, this._then);

  final AccountVm _self;
  final $Res Function(AccountVm) _then;

/// Create a copy of AccountVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? isSpending = null,}) {
  return _then(AccountVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AccountKind,isSpending: null == isSpending ? _self.isSpending : isSpending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountVm].
extension AccountVmPatterns on AccountVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountVm value)  $default,){
final _that = this;
switch (_that) {
case _AccountVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountVm value)?  $default,){
final _that = this;
switch (_that) {
case _AccountVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  AccountKind kind,  bool isSpending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountVm() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.isSpending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  AccountKind kind,  bool isSpending)  $default,) {final _that = this;
switch (_that) {
case _AccountVm():
return $default(_that.id,_that.name,_that.kind,_that.isSpending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  AccountKind kind,  bool isSpending)?  $default,) {final _that = this;
switch (_that) {
case _AccountVm() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.isSpending);case _:
  return null;

}
}

}

/// @nodoc


class _AccountVm implements AccountVm {
  const _AccountVm({required this.id, required this.name, required this.kind, required this.isSpending});
  

@override final  String id;
@override final  String name;
@override final  AccountKind kind;
@override final  bool isSpending;

/// Create a copy of AccountVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountVmCopyWith<_AccountVm> get copyWith => __$AccountVmCopyWithImpl<_AccountVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isSpending, isSpending) || other.isSpending == isSpending));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,kind,isSpending);
}

@override
String toString() {
    return 'AccountVm(id: $id, name: $name, kind: $kind, isSpending: $isSpending)';
}


}

/// @nodoc
abstract mixin class _$AccountVmCopyWith<$Res> implements $AccountVmCopyWith<$Res> {
  factory _$AccountVmCopyWith(_AccountVm value, $Res Function(_AccountVm) _then) = __$AccountVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, AccountKind kind, bool isSpending
});




}
/// @nodoc
class __$AccountVmCopyWithImpl<$Res>
    implements _$AccountVmCopyWith<$Res> {
  __$AccountVmCopyWithImpl(this._self, this._then);

  final _AccountVm _self;
  final $Res Function(_AccountVm) _then;

/// Create a copy of AccountVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? isSpending = null,}) {
  return _then(_AccountVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AccountKind,isSpending: null == isSpending ? _self.isSpending : isSpending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
