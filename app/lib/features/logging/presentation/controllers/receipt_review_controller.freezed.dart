// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_review_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReceiptItemVm {

 String get name; Money get amount;
/// Create a copy of ReceiptItemVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptItemVmCopyWith<ReceiptItemVm> get copyWith => _$ReceiptItemVmCopyWithImpl<ReceiptItemVm>(this as ReceiptItemVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReceiptItemVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptItemVm&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.amount, _this.amount) || other.amount == _this.amount));
}


@override
int get hashCode {
  final _this = this as ReceiptItemVm;
  return Object.hash(runtimeType,_this.name,_this.amount);
}

@override
String toString() {
  final _this = this as ReceiptItemVm;
  return 'ReceiptItemVm(name: ${_this.name}, amount: ${_this.amount})';
}


}

/// @nodoc
abstract mixin class $ReceiptItemVmCopyWith<$Res>  {
  factory $ReceiptItemVmCopyWith(ReceiptItemVm value, $Res Function(ReceiptItemVm) _then) = _$ReceiptItemVmCopyWithImpl;
@useResult
$Res call({
 String name, Money amount
});




}
/// @nodoc
class _$ReceiptItemVmCopyWithImpl<$Res>
    implements $ReceiptItemVmCopyWith<$Res> {
  _$ReceiptItemVmCopyWithImpl(this._self, this._then);

  final ReceiptItemVm _self;
  final $Res Function(ReceiptItemVm) _then;

/// Create a copy of ReceiptItemVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? amount = null,}) {
  return _then(ReceiptItemVm(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiptItemVm].
extension ReceiptItemVmPatterns on ReceiptItemVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiptItemVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiptItemVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiptItemVm value)  $default,){
final _that = this;
switch (_that) {
case _ReceiptItemVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiptItemVm value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiptItemVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  Money amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiptItemVm() when $default != null:
return $default(_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  Money amount)  $default,) {final _that = this;
switch (_that) {
case _ReceiptItemVm():
return $default(_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  Money amount)?  $default,) {final _that = this;
switch (_that) {
case _ReceiptItemVm() when $default != null:
return $default(_that.name,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _ReceiptItemVm implements ReceiptItemVm {
  const _ReceiptItemVm({required this.name, required this.amount});
  

@override final  String name;
@override final  Money amount;

/// Create a copy of ReceiptItemVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptItemVmCopyWith<_ReceiptItemVm> get copyWith => __$ReceiptItemVmCopyWithImpl<_ReceiptItemVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptItemVm&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,amount);
}

@override
String toString() {
    return 'ReceiptItemVm(name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$ReceiptItemVmCopyWith<$Res> implements $ReceiptItemVmCopyWith<$Res> {
  factory _$ReceiptItemVmCopyWith(_ReceiptItemVm value, $Res Function(_ReceiptItemVm) _then) = __$ReceiptItemVmCopyWithImpl;
@override @useResult
$Res call({
 String name, Money amount
});




}
/// @nodoc
class __$ReceiptItemVmCopyWithImpl<$Res>
    implements _$ReceiptItemVmCopyWith<$Res> {
  __$ReceiptItemVmCopyWithImpl(this._self, this._then);

  final _ReceiptItemVm _self;
  final $Res Function(_ReceiptItemVm) _then;

/// Create a copy of ReceiptItemVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? amount = null,}) {
  return _then(_ReceiptItemVm(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

/// @nodoc
mixin _$ReceiptReviewState {

 String get receiptId; String get imagePath; String? get merchant; Money? get total; List<ReceiptItemVm> get items; bool get totalNeedsCheck; bool get itemsMatch; Money? get itemsOff; bool get saving; bool get saved; String? get errorCode;
/// Create a copy of ReceiptReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiptReviewStateCopyWith<ReceiptReviewState> get copyWith => _$ReceiptReviewStateCopyWithImpl<ReceiptReviewState>(this as ReceiptReviewState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReceiptReviewState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiptReviewState&&(identical(other.receiptId, _this.receiptId) || other.receiptId == _this.receiptId)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&(identical(other.merchant, _this.merchant) || other.merchant == _this.merchant)&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.totalNeedsCheck, _this.totalNeedsCheck) || other.totalNeedsCheck == _this.totalNeedsCheck)&&(identical(other.itemsMatch, _this.itemsMatch) || other.itemsMatch == _this.itemsMatch)&&(identical(other.itemsOff, _this.itemsOff) || other.itemsOff == _this.itemsOff)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as ReceiptReviewState;
  return Object.hash(runtimeType,_this.receiptId,_this.imagePath,_this.merchant,_this.total,const DeepCollectionEquality().hash(_this.items),_this.totalNeedsCheck,_this.itemsMatch,_this.itemsOff,_this.saving,_this.saved,_this.errorCode);
}

@override
String toString() {
  final _this = this as ReceiptReviewState;
  return 'ReceiptReviewState(receiptId: ${_this.receiptId}, imagePath: ${_this.imagePath}, merchant: ${_this.merchant}, total: ${_this.total}, items: ${_this.items}, totalNeedsCheck: ${_this.totalNeedsCheck}, itemsMatch: ${_this.itemsMatch}, itemsOff: ${_this.itemsOff}, saving: ${_this.saving}, saved: ${_this.saved}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $ReceiptReviewStateCopyWith<$Res>  {
  factory $ReceiptReviewStateCopyWith(ReceiptReviewState value, $Res Function(ReceiptReviewState) _then) = _$ReceiptReviewStateCopyWithImpl;
@useResult
$Res call({
 String receiptId, String imagePath, String? merchant, Money? total, List<ReceiptItemVm> items, bool totalNeedsCheck, bool itemsMatch, Money? itemsOff, bool saving, bool saved, String? errorCode
});




}
/// @nodoc
class _$ReceiptReviewStateCopyWithImpl<$Res>
    implements $ReceiptReviewStateCopyWith<$Res> {
  _$ReceiptReviewStateCopyWithImpl(this._self, this._then);

  final ReceiptReviewState _self;
  final $Res Function(ReceiptReviewState) _then;

/// Create a copy of ReceiptReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? receiptId = null,Object? imagePath = null,Object? merchant = freezed,Object? total = freezed,Object? items = null,Object? totalNeedsCheck = null,Object? itemsMatch = null,Object? itemsOff = freezed,Object? saving = null,Object? saved = null,Object? errorCode = freezed,}) {
  return _then(ReceiptReviewState(
receiptId: null == receiptId ? _self.receiptId : receiptId // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,merchant: freezed == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReceiptItemVm>,totalNeedsCheck: null == totalNeedsCheck ? _self.totalNeedsCheck : totalNeedsCheck // ignore: cast_nullable_to_non_nullable
as bool,itemsMatch: null == itemsMatch ? _self.itemsMatch : itemsMatch // ignore: cast_nullable_to_non_nullable
as bool,itemsOff: freezed == itemsOff ? _self.itemsOff : itemsOff // ignore: cast_nullable_to_non_nullable
as Money?,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiptReviewState].
extension ReceiptReviewStatePatterns on ReceiptReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiptReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiptReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiptReviewState value)  $default,){
final _that = this;
switch (_that) {
case _ReceiptReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiptReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiptReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String receiptId,  String imagePath,  String? merchant,  Money? total,  List<ReceiptItemVm> items,  bool totalNeedsCheck,  bool itemsMatch,  Money? itemsOff,  bool saving,  bool saved,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiptReviewState() when $default != null:
return $default(_that.receiptId,_that.imagePath,_that.merchant,_that.total,_that.items,_that.totalNeedsCheck,_that.itemsMatch,_that.itemsOff,_that.saving,_that.saved,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String receiptId,  String imagePath,  String? merchant,  Money? total,  List<ReceiptItemVm> items,  bool totalNeedsCheck,  bool itemsMatch,  Money? itemsOff,  bool saving,  bool saved,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _ReceiptReviewState():
return $default(_that.receiptId,_that.imagePath,_that.merchant,_that.total,_that.items,_that.totalNeedsCheck,_that.itemsMatch,_that.itemsOff,_that.saving,_that.saved,_that.errorCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String receiptId,  String imagePath,  String? merchant,  Money? total,  List<ReceiptItemVm> items,  bool totalNeedsCheck,  bool itemsMatch,  Money? itemsOff,  bool saving,  bool saved,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _ReceiptReviewState() when $default != null:
return $default(_that.receiptId,_that.imagePath,_that.merchant,_that.total,_that.items,_that.totalNeedsCheck,_that.itemsMatch,_that.itemsOff,_that.saving,_that.saved,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _ReceiptReviewState implements ReceiptReviewState {
  const _ReceiptReviewState({required this.receiptId, required this.imagePath, required this.merchant, required this.total, required  List<ReceiptItemVm> items, required this.totalNeedsCheck, required this.itemsMatch, required this.itemsOff, this.saving = false, this.saved = false, this.errorCode}): _items = items;
  

@override final  String receiptId;
@override final  String imagePath;
@override final  String? merchant;
@override final  Money? total;
 final  List<ReceiptItemVm> _items;
@override List<ReceiptItemVm> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool totalNeedsCheck;
@override final  bool itemsMatch;
@override final  Money? itemsOff;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool saved;
@override final  String? errorCode;

/// Create a copy of ReceiptReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiptReviewStateCopyWith<_ReceiptReviewState> get copyWith => __$ReceiptReviewStateCopyWithImpl<_ReceiptReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiptReviewState&&(identical(other.receiptId, receiptId) || other.receiptId == receiptId)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.totalNeedsCheck, totalNeedsCheck) || other.totalNeedsCheck == totalNeedsCheck)&&(identical(other.itemsMatch, itemsMatch) || other.itemsMatch == itemsMatch)&&(identical(other.itemsOff, itemsOff) || other.itemsOff == itemsOff)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,receiptId,imagePath,merchant,total,const DeepCollectionEquality().hash(_items),totalNeedsCheck,itemsMatch,itemsOff,saving,saved,errorCode);
}

@override
String toString() {
    return 'ReceiptReviewState(receiptId: $receiptId, imagePath: $imagePath, merchant: $merchant, total: $total, items: $items, totalNeedsCheck: $totalNeedsCheck, itemsMatch: $itemsMatch, itemsOff: $itemsOff, saving: $saving, saved: $saved, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$ReceiptReviewStateCopyWith<$Res> implements $ReceiptReviewStateCopyWith<$Res> {
  factory _$ReceiptReviewStateCopyWith(_ReceiptReviewState value, $Res Function(_ReceiptReviewState) _then) = __$ReceiptReviewStateCopyWithImpl;
@override @useResult
$Res call({
 String receiptId, String imagePath, String? merchant, Money? total, List<ReceiptItemVm> items, bool totalNeedsCheck, bool itemsMatch, Money? itemsOff, bool saving, bool saved, String? errorCode
});




}
/// @nodoc
class __$ReceiptReviewStateCopyWithImpl<$Res>
    implements _$ReceiptReviewStateCopyWith<$Res> {
  __$ReceiptReviewStateCopyWithImpl(this._self, this._then);

  final _ReceiptReviewState _self;
  final $Res Function(_ReceiptReviewState) _then;

/// Create a copy of ReceiptReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? receiptId = null,Object? imagePath = null,Object? merchant = freezed,Object? total = freezed,Object? items = null,Object? totalNeedsCheck = null,Object? itemsMatch = null,Object? itemsOff = freezed,Object? saving = null,Object? saved = null,Object? errorCode = freezed,}) {
  return _then(_ReceiptReviewState(
receiptId: null == receiptId ? _self.receiptId : receiptId // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,merchant: freezed == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as String?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReceiptItemVm>,totalNeedsCheck: null == totalNeedsCheck ? _self.totalNeedsCheck : totalNeedsCheck // ignore: cast_nullable_to_non_nullable
as bool,itemsMatch: null == itemsMatch ? _self.itemsMatch : itemsMatch // ignore: cast_nullable_to_non_nullable
as bool,itemsOff: freezed == itemsOff ? _self.itemsOff : itemsOff // ignore: cast_nullable_to_non_nullable
as Money?,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
