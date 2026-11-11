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
mixin _$DestinationVm {

 String get id; String get name; BucketColor get color;
/// Create a copy of DestinationVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DestinationVmCopyWith<DestinationVm> get copyWith => _$DestinationVmCopyWithImpl<DestinationVm>(this as DestinationVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DestinationVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DestinationVm&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.color, _this.color) || other.color == _this.color));
}


@override
int get hashCode {
  final _this = this as DestinationVm;
  return Object.hash(runtimeType,_this.id,_this.name,_this.color);
}

@override
String toString() {
  final _this = this as DestinationVm;
  return 'DestinationVm(id: ${_this.id}, name: ${_this.name}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $DestinationVmCopyWith<$Res>  {
  factory $DestinationVmCopyWith(DestinationVm value, $Res Function(DestinationVm) _then) = _$DestinationVmCopyWithImpl;
@useResult
$Res call({
 String id, String name, BucketColor color
});




}
/// @nodoc
class _$DestinationVmCopyWithImpl<$Res>
    implements $DestinationVmCopyWith<$Res> {
  _$DestinationVmCopyWithImpl(this._self, this._then);

  final DestinationVm _self;
  final $Res Function(DestinationVm) _then;

/// Create a copy of DestinationVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? color = null,}) {
  return _then(DestinationVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,
  ));
}

}


/// Adds pattern-matching-related methods to [DestinationVm].
extension DestinationVmPatterns on DestinationVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DestinationVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DestinationVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DestinationVm value)  $default,){
final _that = this;
switch (_that) {
case _DestinationVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DestinationVm value)?  $default,){
final _that = this;
switch (_that) {
case _DestinationVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  BucketColor color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DestinationVm() when $default != null:
return $default(_that.id,_that.name,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  BucketColor color)  $default,) {final _that = this;
switch (_that) {
case _DestinationVm():
return $default(_that.id,_that.name,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  BucketColor color)?  $default,) {final _that = this;
switch (_that) {
case _DestinationVm() when $default != null:
return $default(_that.id,_that.name,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _DestinationVm implements DestinationVm {
  const _DestinationVm({required this.id, required this.name, required this.color});
  

@override final  String id;
@override final  String name;
@override final  BucketColor color;

/// Create a copy of DestinationVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DestinationVmCopyWith<_DestinationVm> get copyWith => __$DestinationVmCopyWithImpl<_DestinationVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DestinationVm&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,color);
}

@override
String toString() {
    return 'DestinationVm(id: $id, name: $name, color: $color)';
}


}

/// @nodoc
abstract mixin class _$DestinationVmCopyWith<$Res> implements $DestinationVmCopyWith<$Res> {
  factory _$DestinationVmCopyWith(_DestinationVm value, $Res Function(_DestinationVm) _then) = __$DestinationVmCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, BucketColor color
});




}
/// @nodoc
class __$DestinationVmCopyWithImpl<$Res>
    implements _$DestinationVmCopyWith<$Res> {
  __$DestinationVmCopyWithImpl(this._self, this._then);

  final _DestinationVm _self;
  final $Res Function(_DestinationVm) _then;

/// Create a copy of DestinationVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? color = null,}) {
  return _then(_DestinationVm(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BucketColor,
  ));
}


}

/// @nodoc
mixin _$BucketActionsVm {

 bool get isRemovable; Money get available; List<DestinationVm> get destinations;
/// Create a copy of BucketActionsVm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketActionsVmCopyWith<BucketActionsVm> get copyWith => _$BucketActionsVmCopyWithImpl<BucketActionsVm>(this as BucketActionsVm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BucketActionsVm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketActionsVm&&(identical(other.isRemovable, _this.isRemovable) || other.isRemovable == _this.isRemovable)&&(identical(other.available, _this.available) || other.available == _this.available)&&const DeepCollectionEquality().equals(other.destinations, _this.destinations));
}


@override
int get hashCode {
  final _this = this as BucketActionsVm;
  return Object.hash(runtimeType,_this.isRemovable,_this.available,const DeepCollectionEquality().hash(_this.destinations));
}

@override
String toString() {
  final _this = this as BucketActionsVm;
  return 'BucketActionsVm(isRemovable: ${_this.isRemovable}, available: ${_this.available}, destinations: ${_this.destinations})';
}


}

/// @nodoc
abstract mixin class $BucketActionsVmCopyWith<$Res>  {
  factory $BucketActionsVmCopyWith(BucketActionsVm value, $Res Function(BucketActionsVm) _then) = _$BucketActionsVmCopyWithImpl;
@useResult
$Res call({
 bool isRemovable, Money available, List<DestinationVm> destinations
});




}
/// @nodoc
class _$BucketActionsVmCopyWithImpl<$Res>
    implements $BucketActionsVmCopyWith<$Res> {
  _$BucketActionsVmCopyWithImpl(this._self, this._then);

  final BucketActionsVm _self;
  final $Res Function(BucketActionsVm) _then;

/// Create a copy of BucketActionsVm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRemovable = null,Object? available = null,Object? destinations = null,}) {
  return _then(BucketActionsVm(
isRemovable: null == isRemovable ? _self.isRemovable : isRemovable // ignore: cast_nullable_to_non_nullable
as bool,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as Money,destinations: null == destinations ? _self.destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<DestinationVm>,
  ));
}

}


/// Adds pattern-matching-related methods to [BucketActionsVm].
extension BucketActionsVmPatterns on BucketActionsVm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BucketActionsVm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BucketActionsVm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BucketActionsVm value)  $default,){
final _that = this;
switch (_that) {
case _BucketActionsVm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BucketActionsVm value)?  $default,){
final _that = this;
switch (_that) {
case _BucketActionsVm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isRemovable,  Money available,  List<DestinationVm> destinations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BucketActionsVm() when $default != null:
return $default(_that.isRemovable,_that.available,_that.destinations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isRemovable,  Money available,  List<DestinationVm> destinations)  $default,) {final _that = this;
switch (_that) {
case _BucketActionsVm():
return $default(_that.isRemovable,_that.available,_that.destinations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isRemovable,  Money available,  List<DestinationVm> destinations)?  $default,) {final _that = this;
switch (_that) {
case _BucketActionsVm() when $default != null:
return $default(_that.isRemovable,_that.available,_that.destinations);case _:
  return null;

}
}

}

/// @nodoc


class _BucketActionsVm implements BucketActionsVm {
  const _BucketActionsVm({required this.isRemovable, required this.available, required  List<DestinationVm> destinations}): _destinations = destinations;
  

@override final  bool isRemovable;
@override final  Money available;
 final  List<DestinationVm> _destinations;
@override List<DestinationVm> get destinations {
  if (_destinations is EqualUnmodifiableListView) return _destinations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_destinations);
}


/// Create a copy of BucketActionsVm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BucketActionsVmCopyWith<_BucketActionsVm> get copyWith => __$BucketActionsVmCopyWithImpl<_BucketActionsVm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BucketActionsVm&&(identical(other.isRemovable, isRemovable) || other.isRemovable == isRemovable)&&(identical(other.available, available) || other.available == available)&&const DeepCollectionEquality().equals(other.destinations, _destinations));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isRemovable,available,const DeepCollectionEquality().hash(_destinations));
}

@override
String toString() {
    return 'BucketActionsVm(isRemovable: $isRemovable, available: $available, destinations: $destinations)';
}


}

/// @nodoc
abstract mixin class _$BucketActionsVmCopyWith<$Res> implements $BucketActionsVmCopyWith<$Res> {
  factory _$BucketActionsVmCopyWith(_BucketActionsVm value, $Res Function(_BucketActionsVm) _then) = __$BucketActionsVmCopyWithImpl;
@override @useResult
$Res call({
 bool isRemovable, Money available, List<DestinationVm> destinations
});




}
/// @nodoc
class __$BucketActionsVmCopyWithImpl<$Res>
    implements _$BucketActionsVmCopyWith<$Res> {
  __$BucketActionsVmCopyWithImpl(this._self, this._then);

  final _BucketActionsVm _self;
  final $Res Function(_BucketActionsVm) _then;

/// Create a copy of BucketActionsVm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRemovable = null,Object? available = null,Object? destinations = null,}) {
  return _then(_BucketActionsVm(
isRemovable: null == isRemovable ? _self.isRemovable : isRemovable // ignore: cast_nullable_to_non_nullable
as bool,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as Money,destinations: null == destinations ? _self._destinations : destinations // ignore: cast_nullable_to_non_nullable
as List<DestinationVm>,
  ));
}


}

/// @nodoc
mixin _$BucketDetailState {

 BucketTileVm get bucket; List<EntryRowVm> get entries; BucketActionsVm get actions;
/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketDetailStateCopyWith<BucketDetailState> get copyWith => _$BucketDetailStateCopyWithImpl<BucketDetailState>(this as BucketDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BucketDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketDetailState&&(identical(other.bucket, _this.bucket) || other.bucket == _this.bucket)&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&(identical(other.actions, _this.actions) || other.actions == _this.actions));
}


@override
int get hashCode {
  final _this = this as BucketDetailState;
  return Object.hash(runtimeType,_this.bucket,const DeepCollectionEquality().hash(_this.entries),_this.actions);
}

@override
String toString() {
  final _this = this as BucketDetailState;
  return 'BucketDetailState(bucket: ${_this.bucket}, entries: ${_this.entries}, actions: ${_this.actions})';
}


}

/// @nodoc
abstract mixin class $BucketDetailStateCopyWith<$Res>  {
  factory $BucketDetailStateCopyWith(BucketDetailState value, $Res Function(BucketDetailState) _then) = _$BucketDetailStateCopyWithImpl;
@useResult
$Res call({
 BucketTileVm bucket, List<EntryRowVm> entries, BucketActionsVm actions
});


$BucketTileVmCopyWith<$Res> get bucket;$BucketActionsVmCopyWith<$Res> get actions;

}
/// @nodoc
class _$BucketDetailStateCopyWithImpl<$Res>
    implements $BucketDetailStateCopyWith<$Res> {
  _$BucketDetailStateCopyWithImpl(this._self, this._then);

  final BucketDetailState _self;
  final $Res Function(BucketDetailState) _then;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bucket = null,Object? entries = null,Object? actions = null,}) {
  return _then(_self.copyWith(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as BucketTileVm,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryRowVm>,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as BucketActionsVm,
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
}/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BucketActionsVmCopyWith<$Res> get actions {
  
  return $BucketActionsVmCopyWith<$Res>(_self.actions, (value) {
    return _then(_self.copyWith(actions: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( BucketTileVm bucket,  Money leftToSpend,  List<EntryRowVm> entries,  BucketActionsVm actions)?  normal,TResult Function( BucketTileVm bucket,  Money overspentBy,  List<CoverOptionVm> options,  bool splitTooTight,  List<EntryRowVm> entries,  BucketActionsVm actions,  bool covering)?  overspent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BucketNormal() when normal != null:
return normal(_that.bucket,_that.leftToSpend,_that.entries,_that.actions);case BucketOverspent() when overspent != null:
return overspent(_that.bucket,_that.overspentBy,_that.options,_that.splitTooTight,_that.entries,_that.actions,_that.covering);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( BucketTileVm bucket,  Money leftToSpend,  List<EntryRowVm> entries,  BucketActionsVm actions)  normal,required TResult Function( BucketTileVm bucket,  Money overspentBy,  List<CoverOptionVm> options,  bool splitTooTight,  List<EntryRowVm> entries,  BucketActionsVm actions,  bool covering)  overspent,}) {final _that = this;
switch (_that) {
case BucketNormal():
return normal(_that.bucket,_that.leftToSpend,_that.entries,_that.actions);case BucketOverspent():
return overspent(_that.bucket,_that.overspentBy,_that.options,_that.splitTooTight,_that.entries,_that.actions,_that.covering);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( BucketTileVm bucket,  Money leftToSpend,  List<EntryRowVm> entries,  BucketActionsVm actions)?  normal,TResult? Function( BucketTileVm bucket,  Money overspentBy,  List<CoverOptionVm> options,  bool splitTooTight,  List<EntryRowVm> entries,  BucketActionsVm actions,  bool covering)?  overspent,}) {final _that = this;
switch (_that) {
case BucketNormal() when normal != null:
return normal(_that.bucket,_that.leftToSpend,_that.entries,_that.actions);case BucketOverspent() when overspent != null:
return overspent(_that.bucket,_that.overspentBy,_that.options,_that.splitTooTight,_that.entries,_that.actions,_that.covering);case _:
  return null;

}
}

}

/// @nodoc


class BucketNormal implements BucketDetailState {
  const BucketNormal({required this.bucket, required this.leftToSpend, required  List<EntryRowVm> entries, required this.actions}): _entries = entries;
  

@override final  BucketTileVm bucket;
 final  Money leftToSpend;
 final  List<EntryRowVm> _entries;
@override List<EntryRowVm> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override final  BucketActionsVm actions;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketNormalCopyWith<BucketNormal> get copyWith => _$BucketNormalCopyWithImpl<BucketNormal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketNormal&&(identical(other.bucket, bucket) || other.bucket == bucket)&&(identical(other.leftToSpend, leftToSpend) || other.leftToSpend == leftToSpend)&&const DeepCollectionEquality().equals(other.entries, _entries)&&(identical(other.actions, actions) || other.actions == actions));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bucket,leftToSpend,const DeepCollectionEquality().hash(_entries),actions);
}

@override
String toString() {
    return 'BucketDetailState.normal(bucket: $bucket, leftToSpend: $leftToSpend, entries: $entries, actions: $actions)';
}


}

/// @nodoc
abstract mixin class $BucketNormalCopyWith<$Res> implements $BucketDetailStateCopyWith<$Res> {
  factory $BucketNormalCopyWith(BucketNormal value, $Res Function(BucketNormal) _then) = _$BucketNormalCopyWithImpl;
@override @useResult
$Res call({
 BucketTileVm bucket, Money leftToSpend, List<EntryRowVm> entries, BucketActionsVm actions
});


@override $BucketTileVmCopyWith<$Res> get bucket;@override $BucketActionsVmCopyWith<$Res> get actions;

}
/// @nodoc
class _$BucketNormalCopyWithImpl<$Res>
    implements $BucketNormalCopyWith<$Res> {
  _$BucketNormalCopyWithImpl(this._self, this._then);

  final BucketNormal _self;
  final $Res Function(BucketNormal) _then;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucket = null,Object? leftToSpend = null,Object? entries = null,Object? actions = null,}) {
  return _then(BucketNormal(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as BucketTileVm,leftToSpend: null == leftToSpend ? _self.leftToSpend : leftToSpend // ignore: cast_nullable_to_non_nullable
as Money,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryRowVm>,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as BucketActionsVm,
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
}/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BucketActionsVmCopyWith<$Res> get actions {
  
  return $BucketActionsVmCopyWith<$Res>(_self.actions, (value) {
    return _then(_self.copyWith(actions: value));
  });
}
}

/// @nodoc


class BucketOverspent implements BucketDetailState {
  const BucketOverspent({required this.bucket, required this.overspentBy, required  List<CoverOptionVm> options, required this.splitTooTight, required  List<EntryRowVm> entries, required this.actions, this.covering = false}): _options = options,_entries = entries;
  

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

@override final  BucketActionsVm actions;
@JsonKey() final  bool covering;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BucketOverspentCopyWith<BucketOverspent> get copyWith => _$BucketOverspentCopyWithImpl<BucketOverspent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BucketOverspent&&(identical(other.bucket, bucket) || other.bucket == bucket)&&(identical(other.overspentBy, overspentBy) || other.overspentBy == overspentBy)&&const DeepCollectionEquality().equals(other.options, _options)&&(identical(other.splitTooTight, splitTooTight) || other.splitTooTight == splitTooTight)&&const DeepCollectionEquality().equals(other.entries, _entries)&&(identical(other.actions, actions) || other.actions == actions)&&(identical(other.covering, covering) || other.covering == covering));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bucket,overspentBy,const DeepCollectionEquality().hash(_options),splitTooTight,const DeepCollectionEquality().hash(_entries),actions,covering);
}

@override
String toString() {
    return 'BucketDetailState.overspent(bucket: $bucket, overspentBy: $overspentBy, options: $options, splitTooTight: $splitTooTight, entries: $entries, actions: $actions, covering: $covering)';
}


}

/// @nodoc
abstract mixin class $BucketOverspentCopyWith<$Res> implements $BucketDetailStateCopyWith<$Res> {
  factory $BucketOverspentCopyWith(BucketOverspent value, $Res Function(BucketOverspent) _then) = _$BucketOverspentCopyWithImpl;
@override @useResult
$Res call({
 BucketTileVm bucket, Money overspentBy, List<CoverOptionVm> options, bool splitTooTight, List<EntryRowVm> entries, BucketActionsVm actions, bool covering
});


@override $BucketTileVmCopyWith<$Res> get bucket;@override $BucketActionsVmCopyWith<$Res> get actions;

}
/// @nodoc
class _$BucketOverspentCopyWithImpl<$Res>
    implements $BucketOverspentCopyWith<$Res> {
  _$BucketOverspentCopyWithImpl(this._self, this._then);

  final BucketOverspent _self;
  final $Res Function(BucketOverspent) _then;

/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bucket = null,Object? overspentBy = null,Object? options = null,Object? splitTooTight = null,Object? entries = null,Object? actions = null,Object? covering = null,}) {
  return _then(BucketOverspent(
bucket: null == bucket ? _self.bucket : bucket // ignore: cast_nullable_to_non_nullable
as BucketTileVm,overspentBy: null == overspentBy ? _self.overspentBy : overspentBy // ignore: cast_nullable_to_non_nullable
as Money,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<CoverOptionVm>,splitTooTight: null == splitTooTight ? _self.splitTooTight : splitTooTight // ignore: cast_nullable_to_non_nullable
as bool,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryRowVm>,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as BucketActionsVm,covering: null == covering ? _self.covering : covering // ignore: cast_nullable_to_non_nullable
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
}/// Create a copy of BucketDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BucketActionsVmCopyWith<$Res> get actions {
  
  return $BucketActionsVmCopyWith<$Res>(_self.actions, (value) {
    return _then(_self.copyWith(actions: value));
  });
}
}

// dart format on
