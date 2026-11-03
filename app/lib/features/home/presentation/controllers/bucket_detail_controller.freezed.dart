// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bucket_detail_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BucketDetailState {

 BucketTileVm get bucket; List<EntryRowVm> get entries;
/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketDetailStateCopyWith<BucketDetailState> get copyWith => _$BucketDetailStateCopyWithImpl<BucketDetailState>(this as BucketDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BucketDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketDetailState&&(identical(other.bucket, _this.bucket) || other.bucket == _this.bucket)&&const DeepCollectionEquality().equals(other.entries, _this.entries));
}


@override
int get hashCode {
  final _this = this as BucketDetailState;
  return Object.hash(runtimeType,_this.bucket,const DeepCollectionEquality().hash(_this.entries));
}

@override
String toString() {
  final _this = this as BucketDetailState;
  return 'BucketDetailState(bucket: ${_this.bucket}, entries: ${_this.entries})';
}


}

/// @nodoc
abstract mixin class $BucketDetailStateCopyWith<$Res>  {
  factory $BucketDetailStateCopyWith(BucketDetailState value, $Res Function(BucketDetailState) _then) = _$BucketDetailStateCopyWithImpl;
@useResult
$Res call({
 BucketTileVm bucket, List<EntryRowVm> entries
});


$BucketTileVmCopyWith<$Res> get bucket;

}
/// @nodoc
class _$BucketDetailStateCopyWithImpl<$Res>
    implements $BucketDetailStateCopyWith<$Res> {
  _$BucketDetailStateCopyWithImpl(this._self, this._then);

  final BucketDetailState _self;
  final $Res Function(BucketDetailState) _then;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bucket = null,Object? entries = null,}) {
  return _then(_self.copyWith(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as BucketTileVm,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryRowVm>,
  ));
}
/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BucketTileVmCopyWith<$Res> get bucket {
  
  return $BucketTileVmCopyWith<$Res>(_self.bucket, (value) {
    return _then(_self.copyWith(bucket: value));
  });
}
}


/// Adds pattern-matching-related methods to [BucketDetailState].
extension BucketDetailStatePatterns on BucketDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BucketNormal value)?  normal,TResult Function( BucketOverspent value)?  overspent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BucketNormal() when normal != null:
return normal(_that);case BucketOverspent() when overspent != null:
return overspent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BucketNormal value)  normal,required TResult Function( BucketOverspent value)  overspent,}){
final _that = this;
switch (_that) {
case BucketNormal():
return normal(_that);case BucketOverspent():
return overspent(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BucketNormal value)?  normal,TResult? Function( BucketOverspent value)?  overspent,}){
final _that = this;
switch (_that) {
case BucketNormal() when normal != null:
return normal(_that);case BucketOverspent() when overspent != null:
return overspent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( BucketTileVm bucket,  Money leftToSpend,  List<EntryRowVm> entries)?  normal,TResult Function( BucketTileVm bucket,  Money overspentBy,  List<CoverOptionVm> options,  bool splitTooTight,  List<EntryRowVm> entries,  bool covering)?  overspent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BucketNormal() when normal != null:
return normal(_that.bucket,_that.leftToSpend,_that.entries);case BucketOverspent() when overspent != null:
return overspent(_that.bucket,_that.overspentBy,_that.options,_that.splitTooTight,_that.entries,_that.covering);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( BucketTileVm bucket,  Money leftToSpend,  List<EntryRowVm> entries)  normal,required TResult Function( BucketTileVm bucket,  Money overspentBy,  List<CoverOptionVm> options,  bool splitTooTight,  List<EntryRowVm> entries,  bool covering)  overspent,}) {final _that = this;
switch (_that) {
case BucketNormal():
return normal(_that.bucket,_that.leftToSpend,_that.entries);case BucketOverspent():
return overspent(_that.bucket,_that.overspentBy,_that.options,_that.splitTooTight,_that.entries,_that.covering);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( BucketTileVm bucket,  Money leftToSpend,  List<EntryRowVm> entries)?  normal,TResult? Function( BucketTileVm bucket,  Money overspentBy,  List<CoverOptionVm> options,  bool splitTooTight,  List<EntryRowVm> entries,  bool covering)?  overspent,}) {final _that = this;
switch (_that) {
case BucketNormal() when normal != null:
return normal(_that.bucket,_that.leftToSpend,_that.entries);case BucketOverspent() when overspent != null:
return overspent(_that.bucket,_that.overspentBy,_that.options,_that.splitTooTight,_that.entries,_that.covering);case _:
  return null;

}
}

}

/// @nodoc


class BucketNormal implements BucketDetailState {
  const BucketNormal({required this.bucket, required this.leftToSpend, required  List<EntryRowVm> entries}): _entries = entries;
  

@override final  BucketTileVm bucket;
 final  Money leftToSpend;
 final  List<EntryRowVm> _entries;
@override List<EntryRowVm> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketNormalCopyWith<BucketNormal> get copyWith => _$BucketNormalCopyWithImpl<BucketNormal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketNormal&&(identical(other.bucket, bucket) || other.bucket == bucket)&&(identical(other.leftToSpend, leftToSpend) || other.leftToSpend == leftToSpend)&&const DeepCollectionEquality().equals(other.entries, _entries));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bucket,leftToSpend,const DeepCollectionEquality().hash(_entries));
}

@override
String toString() {
    return 'BucketDetailState.normal(bucket: $bucket, leftToSpend: $leftToSpend, entries: $entries)';
}


}

/// @nodoc
abstract mixin class $BucketNormalCopyWith<$Res> implements $BucketDetailStateCopyWith<$Res> {
  factory $BucketNormalCopyWith(BucketNormal value, $Res Function(BucketNormal) _then) = _$BucketNormalCopyWithImpl;
@override @useResult
$Res call({
 BucketTileVm bucket, Money leftToSpend, List<EntryRowVm> entries
});


@override $BucketTileVmCopyWith<$Res> get bucket;

}
/// @nodoc
class _$BucketNormalCopyWithImpl<$Res>
    implements $BucketNormalCopyWith<$Res> {
  _$BucketNormalCopyWithImpl(this._self, this._then);

  final BucketNormal _self;
  final $Res Function(BucketNormal) _then;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucket = null,Object? leftToSpend = null,Object? entries = null,}) {
  return _then(BucketNormal(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as BucketTileVm,leftToSpend: null == leftToSpend ? _self.leftToSpend : leftToSpend // ignore: cast_nullable_to_non_nullable
as Money,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryRowVm>,
  ));
}

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BucketTileVmCopyWith<$Res> get bucket {
  
  return $BucketTileVmCopyWith<$Res>(_self.bucket, (value) {
    return _then(_self.copyWith(bucket: value));
  });
}
}

/// @nodoc


class BucketOverspent implements BucketDetailState {
  const BucketOverspent({required this.bucket, required this.overspentBy, required  List<CoverOptionVm> options, required this.splitTooTight, required  List<EntryRowVm> entries, this.covering = false}): _options = options,_entries = entries;
  

@override final  BucketTileVm bucket;
 final  Money overspentBy;
 final  List<CoverOptionVm> _options;
 List<CoverOptionVm> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

 final  bool splitTooTight;
 final  List<EntryRowVm> _entries;
@override List<EntryRowVm> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@JsonKey() final  bool covering;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketOverspentCopyWith<BucketOverspent> get copyWith => _$BucketOverspentCopyWithImpl<BucketOverspent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketOverspent&&(identical(other.bucket, bucket) || other.bucket == bucket)&&(identical(other.overspentBy, overspentBy) || other.overspentBy == overspentBy)&&const DeepCollectionEquality().equals(other.options, _options)&&(identical(other.splitTooTight, splitTooTight) || other.splitTooTight == splitTooTight)&&const DeepCollectionEquality().equals(other.entries, _entries)&&(identical(other.covering, covering) || other.covering == covering));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bucket,overspentBy,const DeepCollectionEquality().hash(_options),splitTooTight,const DeepCollectionEquality().hash(_entries),covering);
}

@override
String toString() {
    return 'BucketDetailState.overspent(bucket: $bucket, overspentBy: $overspentBy, options: $options, splitTooTight: $splitTooTight, entries: $entries, covering: $covering)';
}


}

/// @nodoc
abstract mixin class $BucketOverspentCopyWith<$Res> implements $BucketDetailStateCopyWith<$Res> {
  factory $BucketOverspentCopyWith(BucketOverspent value, $Res Function(BucketOverspent) _then) = _$BucketOverspentCopyWithImpl;
@override @useResult
$Res call({
 BucketTileVm bucket, Money overspentBy, List<CoverOptionVm> options, bool splitTooTight, List<EntryRowVm> entries, bool covering
});


@override $BucketTileVmCopyWith<$Res> get bucket;

}
/// @nodoc
class _$BucketOverspentCopyWithImpl<$Res>
    implements $BucketOverspentCopyWith<$Res> {
  _$BucketOverspentCopyWithImpl(this._self, this._then);

  final BucketOverspent _self;
  final $Res Function(BucketOverspent) _then;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucket = null,Object? overspentBy = null,Object? options = null,Object? splitTooTight = null,Object? entries = null,Object? covering = null,}) {
  return _then(BucketOverspent(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as BucketTileVm,overspentBy: null == overspentBy ? _self.overspentBy : overspentBy // ignore: cast_nullable_to_non_nullable
as Money,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<CoverOptionVm>,splitTooTight: null == splitTooTight ? _self.splitTooTight : splitTooTight // ignore: cast_nullable_to_non_nullable
as bool,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryRowVm>,covering: null == covering ? _self.covering : covering // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BucketTileVmCopyWith<$Res> get bucket {
  
  return $BucketTileVmCopyWith<$Res>(_self.bucket, (value) {
    return _then(_self.copyWith(bucket: value));
  });
}
}

// dart format on
