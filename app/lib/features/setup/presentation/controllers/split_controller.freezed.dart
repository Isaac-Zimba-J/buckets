// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'split_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SplitState {

 String get profileId; List<AllocationVm> get rows; int get totalBasisPoints; Money? get amountToSplit; SplitStatus get status; bool get saving; bool get saved;
/// Create a copy of SplitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitStateCopyWith<SplitState> get copyWith => _$SplitStateCopyWithImpl<SplitState>(this as SplitState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SplitState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitState&&(identical(other.profileId, _this.profileId) || other.profileId == _this.profileId)&&const DeepCollectionEquality().equals(other.rows, _this.rows)&&(identical(other.totalBasisPoints, _this.totalBasisPoints) || other.totalBasisPoints == _this.totalBasisPoints)&&(identical(other.amountToSplit, _this.amountToSplit) || other.amountToSplit == _this.amountToSplit)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.saved, _this.saved) || other.saved == _this.saved));
}


@override
int get hashCode {
  final _this = this as SplitState;
  return Object.hash(runtimeType,_this.profileId,const DeepCollectionEquality().hash(_this.rows),_this.totalBasisPoints,_this.amountToSplit,_this.status,_this.saving,_this.saved);
}

@override
String toString() {
  final _this = this as SplitState;
  return 'SplitState(profileId: ${_this.profileId}, rows: ${_this.rows}, totalBasisPoints: ${_this.totalBasisPoints}, amountToSplit: ${_this.amountToSplit}, status: ${_this.status}, saving: ${_this.saving}, saved: ${_this.saved})';
}


}

/// @nodoc
abstract mixin class $SplitStateCopyWith<$Res>  {
  factory $SplitStateCopyWith(SplitState value, $Res Function(SplitState) _then) = _$SplitStateCopyWithImpl;
@useResult
$Res call({
 String profileId, List<AllocationVm> rows, int totalBasisPoints, Money? amountToSplit, SplitStatus status, bool saving, bool saved
});




}
/// @nodoc
class _$SplitStateCopyWithImpl<$Res>
    implements $SplitStateCopyWith<$Res> {
  _$SplitStateCopyWithImpl(this._self, this._then);

  final SplitState _self;
  final $Res Function(SplitState) _then;

/// Create a copy of SplitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? rows = null,Object? totalBasisPoints = null,Object? amountToSplit = freezed,Object? status = null,Object? saving = null,Object? saved = null,}) {
  return _then(SplitState(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<AllocationVm>,totalBasisPoints: null == totalBasisPoints ? _self.totalBasisPoints : totalBasisPoints // ignore: cast_nullable_to_non_nullable
as int,amountToSplit: freezed == amountToSplit ? _self.amountToSplit : amountToSplit // ignore: cast_nullable_to_non_nullable
as Money?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitStatus,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SplitState].
extension SplitStatePatterns on SplitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplitState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplitState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplitState value)  $default,){
final _that = this;
switch (_that) {
case _SplitState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplitState value)?  $default,){
final _that = this;
switch (_that) {
case _SplitState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String profileId,  List<AllocationVm> rows,  int totalBasisPoints,  Money? amountToSplit,  SplitStatus status,  bool saving,  bool saved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplitState() when $default != null:
return $default(_that.profileId,_that.rows,_that.totalBasisPoints,_that.amountToSplit,_that.status,_that.saving,_that.saved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String profileId,  List<AllocationVm> rows,  int totalBasisPoints,  Money? amountToSplit,  SplitStatus status,  bool saving,  bool saved)  $default,) {final _that = this;
switch (_that) {
case _SplitState():
return $default(_that.profileId,_that.rows,_that.totalBasisPoints,_that.amountToSplit,_that.status,_that.saving,_that.saved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String profileId,  List<AllocationVm> rows,  int totalBasisPoints,  Money? amountToSplit,  SplitStatus status,  bool saving,  bool saved)?  $default,) {final _that = this;
switch (_that) {
case _SplitState() when $default != null:
return $default(_that.profileId,_that.rows,_that.totalBasisPoints,_that.amountToSplit,_that.status,_that.saving,_that.saved);case _:
  return null;

}
}

}

/// @nodoc


class _SplitState implements SplitState {
  const _SplitState({required this.profileId, required  List<AllocationVm> rows, required this.totalBasisPoints, required this.amountToSplit, required this.status, this.saving = false, this.saved = false}): _rows = rows;
  

@override final  String profileId;
 final  List<AllocationVm> _rows;
@override List<AllocationVm> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}

@override final  int totalBasisPoints;
@override final  Money? amountToSplit;
@override final  SplitStatus status;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  bool saved;

/// Create a copy of SplitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitStateCopyWith<_SplitState> get copyWith => __$SplitStateCopyWithImpl<_SplitState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplitState&&(identical(other.profileId, profileId) || other.profileId == profileId)&&const DeepCollectionEquality().equals(other.rows, _rows)&&(identical(other.totalBasisPoints, totalBasisPoints) || other.totalBasisPoints == totalBasisPoints)&&(identical(other.amountToSplit, amountToSplit) || other.amountToSplit == amountToSplit)&&(identical(other.status, status) || other.status == status)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.saved, saved) || other.saved == saved));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profileId,const DeepCollectionEquality().hash(_rows),totalBasisPoints,amountToSplit,status,saving,saved);
}

@override
String toString() {
    return 'SplitState(profileId: $profileId, rows: $rows, totalBasisPoints: $totalBasisPoints, amountToSplit: $amountToSplit, status: $status, saving: $saving, saved: $saved)';
}


}

/// @nodoc
abstract mixin class _$SplitStateCopyWith<$Res> implements $SplitStateCopyWith<$Res> {
  factory _$SplitStateCopyWith(_SplitState value, $Res Function(_SplitState) _then) = __$SplitStateCopyWithImpl;
@override @useResult
$Res call({
 String profileId, List<AllocationVm> rows, int totalBasisPoints, Money? amountToSplit, SplitStatus status, bool saving, bool saved
});




}
/// @nodoc
class __$SplitStateCopyWithImpl<$Res>
    implements _$SplitStateCopyWith<$Res> {
  __$SplitStateCopyWithImpl(this._self, this._then);

  final _SplitState _self;
  final $Res Function(_SplitState) _then;

/// Create a copy of SplitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? rows = null,Object? totalBasisPoints = null,Object? amountToSplit = freezed,Object? status = null,Object? saving = null,Object? saved = null,}) {
  return _then(_SplitState(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<AllocationVm>,totalBasisPoints: null == totalBasisPoints ? _self.totalBasisPoints : totalBasisPoints // ignore: cast_nullable_to_non_nullable
as int,amountToSplit: freezed == amountToSplit ? _self.amountToSplit : amountToSplit // ignore: cast_nullable_to_non_nullable
as Money?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitStatus,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
