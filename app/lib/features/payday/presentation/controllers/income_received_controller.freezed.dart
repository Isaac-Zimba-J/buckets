// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_received_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomeReceivedState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeReceivedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'IncomeReceivedState()';
}


}

/// @nodoc
class $IncomeReceivedStateCopyWith<$Res>  {
$IncomeReceivedStateCopyWith(IncomeReceivedState _, $Res Function(IncomeReceivedState) __);
}


/// Adds pattern-matching-related methods to [IncomeReceivedState].
extension IncomeReceivedStatePatterns on IncomeReceivedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IncomeReady value)?  ready,TResult Function( IncomeHolding value)?  holding,TResult Function( IncomeSplit value)?  split,TResult Function( IncomeDismissed value)?  dismissed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IncomeReady() when ready != null:
return ready(_that);case IncomeHolding() when holding != null:
return holding(_that);case IncomeSplit() when split != null:
return split(_that);case IncomeDismissed() when dismissed != null:
return dismissed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IncomeReady value)  ready,required TResult Function( IncomeHolding value)  holding,required TResult Function( IncomeSplit value)  split,required TResult Function( IncomeDismissed value)  dismissed,}){
final _that = this;
switch (_that) {
case IncomeReady():
return ready(_that);case IncomeHolding():
return holding(_that);case IncomeSplit():
return split(_that);case IncomeDismissed():
return dismissed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IncomeReady value)?  ready,TResult? Function( IncomeHolding value)?  holding,TResult? Function( IncomeSplit value)?  split,TResult? Function( IncomeDismissed value)?  dismissed,}){
final _that = this;
switch (_that) {
case IncomeReady() when ready != null:
return ready(_that);case IncomeHolding() when holding != null:
return holding(_that);case IncomeSplit() when split != null:
return split(_that);case IncomeDismissed() when dismissed != null:
return dismissed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Money? amount,  String? from,  IncomeSuggestion suggestion,  List<IncomeVm> sideHustles,  String? errorCode)?  ready,TResult Function( DateTime releaseAt)?  holding,TResult Function( String paydayId)?  split,TResult Function()?  dismissed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IncomeReady() when ready != null:
return ready(_that.amount,_that.from,_that.suggestion,_that.sideHustles,_that.errorCode);case IncomeHolding() when holding != null:
return holding(_that.releaseAt);case IncomeSplit() when split != null:
return split(_that.paydayId);case IncomeDismissed() when dismissed != null:
return dismissed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Money? amount,  String? from,  IncomeSuggestion suggestion,  List<IncomeVm> sideHustles,  String? errorCode)  ready,required TResult Function( DateTime releaseAt)  holding,required TResult Function( String paydayId)  split,required TResult Function()  dismissed,}) {final _that = this;
switch (_that) {
case IncomeReady():
return ready(_that.amount,_that.from,_that.suggestion,_that.sideHustles,_that.errorCode);case IncomeHolding():
return holding(_that.releaseAt);case IncomeSplit():
return split(_that.paydayId);case IncomeDismissed():
return dismissed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Money? amount,  String? from,  IncomeSuggestion suggestion,  List<IncomeVm> sideHustles,  String? errorCode)?  ready,TResult? Function( DateTime releaseAt)?  holding,TResult? Function( String paydayId)?  split,TResult? Function()?  dismissed,}) {final _that = this;
switch (_that) {
case IncomeReady() when ready != null:
return ready(_that.amount,_that.from,_that.suggestion,_that.sideHustles,_that.errorCode);case IncomeHolding() when holding != null:
return holding(_that.releaseAt);case IncomeSplit() when split != null:
return split(_that.paydayId);case IncomeDismissed() when dismissed != null:
return dismissed();case _:
  return null;

}
}

}

/// @nodoc


class IncomeReady implements IncomeReceivedState {
  const IncomeReady({required this.amount, required this.from, required this.suggestion, required  List<IncomeVm> sideHustles, this.errorCode}): _sideHustles = sideHustles;
  

 final  Money? amount;
 final  String? from;
 final  IncomeSuggestion suggestion;
 final  List<IncomeVm> _sideHustles;
 List<IncomeVm> get sideHustles {
  if (_sideHustles is EqualUnmodifiableListView) return _sideHustles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sideHustles);
}

 final  String? errorCode;

/// Create a copy of IncomeReceivedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeReadyCopyWith<IncomeReady> get copyWith => _$IncomeReadyCopyWithImpl<IncomeReady>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeReady&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.from, from) || other.from == from)&&(identical(other.suggestion, suggestion) || other.suggestion == suggestion)&&const DeepCollectionEquality().equals(other.sideHustles, _sideHustles)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,amount,from,suggestion,const DeepCollectionEquality().hash(_sideHustles),errorCode);
}

@override
String toString() {
    return 'IncomeReceivedState.ready(amount: $amount, from: $from, suggestion: $suggestion, sideHustles: $sideHustles, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class $IncomeReadyCopyWith<$Res> implements $IncomeReceivedStateCopyWith<$Res> {
  factory $IncomeReadyCopyWith(IncomeReady value, $Res Function(IncomeReady) _then) = _$IncomeReadyCopyWithImpl;
@useResult
$Res call({
 Money? amount, String? from, IncomeSuggestion suggestion, List<IncomeVm> sideHustles, String? errorCode
});




}
/// @nodoc
class _$IncomeReadyCopyWithImpl<$Res>
    implements $IncomeReadyCopyWith<$Res> {
  _$IncomeReadyCopyWithImpl(this._self, this._then);

  final IncomeReady _self;
  final $Res Function(IncomeReady) _then;

/// Create a copy of IncomeReceivedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = freezed,Object? from = freezed,Object? suggestion = null,Object? sideHustles = null,Object? errorCode = freezed,}) {
  return _then(IncomeReady(
amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money?,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,suggestion: null == suggestion ? _self.suggestion : suggestion // ignore: cast_nullable_to_non_nullable
as IncomeSuggestion,sideHustles: null == sideHustles ? _self._sideHustles : sideHustles // ignore: cast_nullable_to_non_nullable
as List<IncomeVm>,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class IncomeHolding implements IncomeReceivedState {
  const IncomeHolding({required this.releaseAt});
  

 final  DateTime releaseAt;

/// Create a copy of IncomeReceivedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeHoldingCopyWith<IncomeHolding> get copyWith => _$IncomeHoldingCopyWithImpl<IncomeHolding>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeHolding&&(identical(other.releaseAt, releaseAt) || other.releaseAt == releaseAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,releaseAt);
}

@override
String toString() {
    return 'IncomeReceivedState.holding(releaseAt: $releaseAt)';
}


}

/// @nodoc
abstract mixin class $IncomeHoldingCopyWith<$Res> implements $IncomeReceivedStateCopyWith<$Res> {
  factory $IncomeHoldingCopyWith(IncomeHolding value, $Res Function(IncomeHolding) _then) = _$IncomeHoldingCopyWithImpl;
@useResult
$Res call({
 DateTime releaseAt
});




}
/// @nodoc
class _$IncomeHoldingCopyWithImpl<$Res>
    implements $IncomeHoldingCopyWith<$Res> {
  _$IncomeHoldingCopyWithImpl(this._self, this._then);

  final IncomeHolding _self;
  final $Res Function(IncomeHolding) _then;

/// Create a copy of IncomeReceivedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? releaseAt = null,}) {
  return _then(IncomeHolding(
releaseAt: null == releaseAt ? _self.releaseAt : releaseAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class IncomeSplit implements IncomeReceivedState {
  const IncomeSplit({required this.paydayId});
  

 final  String paydayId;

/// Create a copy of IncomeReceivedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeSplitCopyWith<IncomeSplit> get copyWith => _$IncomeSplitCopyWithImpl<IncomeSplit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeSplit&&(identical(other.paydayId, paydayId) || other.paydayId == paydayId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,paydayId);
}

@override
String toString() {
    return 'IncomeReceivedState.split(paydayId: $paydayId)';
}


}

/// @nodoc
abstract mixin class $IncomeSplitCopyWith<$Res> implements $IncomeReceivedStateCopyWith<$Res> {
  factory $IncomeSplitCopyWith(IncomeSplit value, $Res Function(IncomeSplit) _then) = _$IncomeSplitCopyWithImpl;
@useResult
$Res call({
 String paydayId
});




}
/// @nodoc
class _$IncomeSplitCopyWithImpl<$Res>
    implements $IncomeSplitCopyWith<$Res> {
  _$IncomeSplitCopyWithImpl(this._self, this._then);

  final IncomeSplit _self;
  final $Res Function(IncomeSplit) _then;

/// Create a copy of IncomeReceivedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paydayId = null,}) {
  return _then(IncomeSplit(
paydayId: null == paydayId ? _self.paydayId : paydayId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class IncomeDismissed implements IncomeReceivedState {
  const IncomeDismissed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'IncomeReceivedState.dismissed()';
}


}




// dart format on
