// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ScanState()';
}


}

/// @nodoc
class $ScanStateCopyWith<$Res>  {
$ScanStateCopyWith(ScanState _, $Res Function(ScanState) __);
}


/// Adds pattern-matching-related methods to [ScanState].
extension ScanStatePatterns on ScanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScanCamera value)?  camera,TResult Function( ScanProcessing value)?  processing,TResult Function( ScanNoText value)?  noText,TResult Function( ScanPermissionDenied value)?  permissionDenied,TResult Function( ScanRecognized value)?  recognized,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScanCamera() when camera != null:
return camera(_that);case ScanProcessing() when processing != null:
return processing(_that);case ScanNoText() when noText != null:
return noText(_that);case ScanPermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case ScanRecognized() when recognized != null:
return recognized(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScanCamera value)  camera,required TResult Function( ScanProcessing value)  processing,required TResult Function( ScanNoText value)  noText,required TResult Function( ScanPermissionDenied value)  permissionDenied,required TResult Function( ScanRecognized value)  recognized,}){
final _that = this;
switch (_that) {
case ScanCamera():
return camera(_that);case ScanProcessing():
return processing(_that);case ScanNoText():
return noText(_that);case ScanPermissionDenied():
return permissionDenied(_that);case ScanRecognized():
return recognized(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScanCamera value)?  camera,TResult? Function( ScanProcessing value)?  processing,TResult? Function( ScanNoText value)?  noText,TResult? Function( ScanPermissionDenied value)?  permissionDenied,TResult? Function( ScanRecognized value)?  recognized,}){
final _that = this;
switch (_that) {
case ScanCamera() when camera != null:
return camera(_that);case ScanProcessing() when processing != null:
return processing(_that);case ScanNoText() when noText != null:
return noText(_that);case ScanPermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case ScanRecognized() when recognized != null:
return recognized(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  camera,TResult Function()?  processing,TResult Function()?  noText,TResult Function()?  permissionDenied,TResult Function( String receiptId)?  recognized,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScanCamera() when camera != null:
return camera();case ScanProcessing() when processing != null:
return processing();case ScanNoText() when noText != null:
return noText();case ScanPermissionDenied() when permissionDenied != null:
return permissionDenied();case ScanRecognized() when recognized != null:
return recognized(_that.receiptId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  camera,required TResult Function()  processing,required TResult Function()  noText,required TResult Function()  permissionDenied,required TResult Function( String receiptId)  recognized,}) {final _that = this;
switch (_that) {
case ScanCamera():
return camera();case ScanProcessing():
return processing();case ScanNoText():
return noText();case ScanPermissionDenied():
return permissionDenied();case ScanRecognized():
return recognized(_that.receiptId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  camera,TResult? Function()?  processing,TResult? Function()?  noText,TResult? Function()?  permissionDenied,TResult? Function( String receiptId)?  recognized,}) {final _that = this;
switch (_that) {
case ScanCamera() when camera != null:
return camera();case ScanProcessing() when processing != null:
return processing();case ScanNoText() when noText != null:
return noText();case ScanPermissionDenied() when permissionDenied != null:
return permissionDenied();case ScanRecognized() when recognized != null:
return recognized(_that.receiptId);case _:
  return null;

}
}

}

/// @nodoc


class ScanCamera implements ScanState {
  const ScanCamera();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanCamera);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ScanState.camera()';
}


}




/// @nodoc


class ScanProcessing implements ScanState {
  const ScanProcessing();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanProcessing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ScanState.processing()';
}


}




/// @nodoc


class ScanNoText implements ScanState {
  const ScanNoText();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanNoText);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ScanState.noText()';
}


}




/// @nodoc


class ScanPermissionDenied implements ScanState {
  const ScanPermissionDenied();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanPermissionDenied);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ScanState.permissionDenied()';
}


}




/// @nodoc


class ScanRecognized implements ScanState {
  const ScanRecognized({required this.receiptId});
  

 final  String receiptId;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanRecognizedCopyWith<ScanRecognized> get copyWith => _$ScanRecognizedCopyWithImpl<ScanRecognized>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanRecognized&&(identical(other.receiptId, receiptId) || other.receiptId == receiptId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,receiptId);
}

@override
String toString() {
    return 'ScanState.recognized(receiptId: $receiptId)';
}


}

/// @nodoc
abstract mixin class $ScanRecognizedCopyWith<$Res> implements $ScanStateCopyWith<$Res> {
  factory $ScanRecognizedCopyWith(ScanRecognized value, $Res Function(ScanRecognized) _then) = _$ScanRecognizedCopyWithImpl;
@useResult
$Res call({
 String receiptId
});




}
/// @nodoc
class _$ScanRecognizedCopyWithImpl<$Res>
    implements $ScanRecognizedCopyWith<$Res> {
  _$ScanRecognizedCopyWithImpl(this._self, this._then);

  final ScanRecognized _self;
  final $Res Function(ScanRecognized) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? receiptId = null,}) {
  return _then(ScanRecognized(
receiptId: null == receiptId ? _self.receiptId : receiptId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
