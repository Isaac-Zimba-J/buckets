// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 List<BucketTileVm> get buckets;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&const DeepCollectionEquality().equals(other.buckets, _this.buckets));
}


@override
int get hashCode {
  final _this = this as HomeState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.buckets));
}

@override
String toString() {
  final _this = this as HomeState;
  return 'HomeState(buckets: ${_this.buckets})';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 List<BucketTileVm> buckets
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buckets = null,}) {
  return _then(_self.copyWith(
buckets: null == buckets ? _self.buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<BucketTileVm>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeFirstRun value)?  firstRun,TResult Function( HomeActive value)?  active,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeFirstRun() when firstRun != null:
return firstRun(_that);case HomeActive() when active != null:
return active(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeFirstRun value)  firstRun,required TResult Function( HomeActive value)  active,}){
final _that = this;
switch (_that) {
case HomeFirstRun():
return firstRun(_that);case HomeActive():
return active(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeFirstRun value)?  firstRun,TResult? Function( HomeActive value)?  active,}){
final _that = this;
switch (_that) {
case HomeFirstRun() when firstRun != null:
return firstRun(_that);case HomeActive() when active != null:
return active(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<BucketTileVm> buckets,  LocalDate? nextPayday,  int? daysUntilPayday,  String? displayName,  Money? income,  Money? toMoveToSavings)?  firstRun,TResult Function( Money livingLeft,  Money? perDay,  Money guiltFreeLeft,  List<BucketTileVm> buckets,  int unsortedCount,  List<TransactionRowVm> recent,  PaydayBannerVm? banner,  bool unlocked)?  active,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeFirstRun() when firstRun != null:
return firstRun(_that.buckets,_that.nextPayday,_that.daysUntilPayday,_that.displayName,_that.income,_that.toMoveToSavings);case HomeActive() when active != null:
return active(_that.livingLeft,_that.perDay,_that.guiltFreeLeft,_that.buckets,_that.unsortedCount,_that.recent,_that.banner,_that.unlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<BucketTileVm> buckets,  LocalDate? nextPayday,  int? daysUntilPayday,  String? displayName,  Money? income,  Money? toMoveToSavings)  firstRun,required TResult Function( Money livingLeft,  Money? perDay,  Money guiltFreeLeft,  List<BucketTileVm> buckets,  int unsortedCount,  List<TransactionRowVm> recent,  PaydayBannerVm? banner,  bool unlocked)  active,}) {final _that = this;
switch (_that) {
case HomeFirstRun():
return firstRun(_that.buckets,_that.nextPayday,_that.daysUntilPayday,_that.displayName,_that.income,_that.toMoveToSavings);case HomeActive():
return active(_that.livingLeft,_that.perDay,_that.guiltFreeLeft,_that.buckets,_that.unsortedCount,_that.recent,_that.banner,_that.unlocked);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<BucketTileVm> buckets,  LocalDate? nextPayday,  int? daysUntilPayday,  String? displayName,  Money? income,  Money? toMoveToSavings)?  firstRun,TResult? Function( Money livingLeft,  Money? perDay,  Money guiltFreeLeft,  List<BucketTileVm> buckets,  int unsortedCount,  List<TransactionRowVm> recent,  PaydayBannerVm? banner,  bool unlocked)?  active,}) {final _that = this;
switch (_that) {
case HomeFirstRun() when firstRun != null:
return firstRun(_that.buckets,_that.nextPayday,_that.daysUntilPayday,_that.displayName,_that.income,_that.toMoveToSavings);case HomeActive() when active != null:
return active(_that.livingLeft,_that.perDay,_that.guiltFreeLeft,_that.buckets,_that.unsortedCount,_that.recent,_that.banner,_that.unlocked);case _:
  return null;

}
}

}

/// @nodoc


class HomeFirstRun implements HomeState {
  const HomeFirstRun({required  List<BucketTileVm> buckets, required this.nextPayday, required this.daysUntilPayday, this.displayName, this.income, this.toMoveToSavings}): _buckets = buckets;
  

 final  List<BucketTileVm> _buckets;
@override List<BucketTileVm> get buckets {
  if (_buckets is EqualUnmodifiableListView) return _buckets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buckets);
}

 final  LocalDate? nextPayday;
 final  int? daysUntilPayday;
 final  String? displayName;
 final  Money? income;
 final  Money? toMoveToSavings;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeFirstRunCopyWith<HomeFirstRun> get copyWith => _$HomeFirstRunCopyWithImpl<HomeFirstRun>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeFirstRun&&const DeepCollectionEquality().equals(other.buckets, _buckets)&&(identical(other.nextPayday, nextPayday) || other.nextPayday == nextPayday)&&(identical(other.daysUntilPayday, daysUntilPayday) || other.daysUntilPayday == daysUntilPayday)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.income, income) || other.income == income)&&(identical(other.toMoveToSavings, toMoveToSavings) || other.toMoveToSavings == toMoveToSavings));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_buckets),nextPayday,daysUntilPayday,displayName,income,toMoveToSavings);
}

@override
String toString() {
    return 'HomeState.firstRun(buckets: $buckets, nextPayday: $nextPayday, daysUntilPayday: $daysUntilPayday, displayName: $displayName, income: $income, toMoveToSavings: $toMoveToSavings)';
}


}

/// @nodoc
abstract mixin class $HomeFirstRunCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeFirstRunCopyWith(HomeFirstRun value, $Res Function(HomeFirstRun) _then) = _$HomeFirstRunCopyWithImpl;
@override @useResult
$Res call({
 List<BucketTileVm> buckets, LocalDate? nextPayday, int? daysUntilPayday, String? displayName, Money? income, Money? toMoveToSavings
});




}
/// @nodoc
class _$HomeFirstRunCopyWithImpl<$Res>
    implements $HomeFirstRunCopyWith<$Res> {
  _$HomeFirstRunCopyWithImpl(this._self, this._then);

  final HomeFirstRun _self;
  final $Res Function(HomeFirstRun) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buckets = null,Object? nextPayday = freezed,Object? daysUntilPayday = freezed,Object? displayName = freezed,Object? income = freezed,Object? toMoveToSavings = freezed,}) {
  return _then(HomeFirstRun(
buckets: null == buckets ? _self._buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<BucketTileVm>,nextPayday: freezed == nextPayday ? _self.nextPayday : nextPayday // ignore: cast_nullable_to_non_nullable
as LocalDate?,daysUntilPayday: freezed == daysUntilPayday ? _self.daysUntilPayday : daysUntilPayday // ignore: cast_nullable_to_non_nullable
as int?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,income: freezed == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money?,toMoveToSavings: freezed == toMoveToSavings ? _self.toMoveToSavings : toMoveToSavings // ignore: cast_nullable_to_non_nullable
as Money?,
  ));
}


}

/// @nodoc


class HomeActive implements HomeState {
  const HomeActive({required this.livingLeft, required this.perDay, required this.guiltFreeLeft, required  List<BucketTileVm> buckets, required this.unsortedCount, required  List<TransactionRowVm> recent, required this.banner, required this.unlocked}): _buckets = buckets,_recent = recent;
  

 final  Money livingLeft;
 final  Money? perDay;
 final  Money guiltFreeLeft;
 final  List<BucketTileVm> _buckets;
@override List<BucketTileVm> get buckets {
  if (_buckets is EqualUnmodifiableListView) return _buckets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buckets);
}

 final  int unsortedCount;
 final  List<TransactionRowVm> _recent;
 List<TransactionRowVm> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

 final  PaydayBannerVm? banner;
 final  bool unlocked;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeActiveCopyWith<HomeActive> get copyWith => _$HomeActiveCopyWithImpl<HomeActive>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeActive&&(identical(other.livingLeft, livingLeft) || other.livingLeft == livingLeft)&&(identical(other.perDay, perDay) || other.perDay == perDay)&&(identical(other.guiltFreeLeft, guiltFreeLeft) || other.guiltFreeLeft == guiltFreeLeft)&&const DeepCollectionEquality().equals(other.buckets, _buckets)&&(identical(other.unsortedCount, unsortedCount) || other.unsortedCount == unsortedCount)&&const DeepCollectionEquality().equals(other.recent, _recent)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.unlocked, unlocked) || other.unlocked == unlocked));
}


@override
int get hashCode {
    return Object.hash(runtimeType,livingLeft,perDay,guiltFreeLeft,const DeepCollectionEquality().hash(_buckets),unsortedCount,const DeepCollectionEquality().hash(_recent),banner,unlocked);
}

@override
String toString() {
    return 'HomeState.active(livingLeft: $livingLeft, perDay: $perDay, guiltFreeLeft: $guiltFreeLeft, buckets: $buckets, unsortedCount: $unsortedCount, recent: $recent, banner: $banner, unlocked: $unlocked)';
}


}

/// @nodoc
abstract mixin class $HomeActiveCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeActiveCopyWith(HomeActive value, $Res Function(HomeActive) _then) = _$HomeActiveCopyWithImpl;
@override @useResult
$Res call({
 Money livingLeft, Money? perDay, Money guiltFreeLeft, List<BucketTileVm> buckets, int unsortedCount, List<TransactionRowVm> recent, PaydayBannerVm? banner, bool unlocked
});


$PaydayBannerVmCopyWith<$Res>? get banner;

}
/// @nodoc
class _$HomeActiveCopyWithImpl<$Res>
    implements $HomeActiveCopyWith<$Res> {
  _$HomeActiveCopyWithImpl(this._self, this._then);

  final HomeActive _self;
  final $Res Function(HomeActive) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? livingLeft = null,Object? perDay = freezed,Object? guiltFreeLeft = null,Object? buckets = null,Object? unsortedCount = null,Object? recent = null,Object? banner = freezed,Object? unlocked = null,}) {
  return _then(HomeActive(
livingLeft: null == livingLeft ? _self.livingLeft : livingLeft // ignore: cast_nullable_to_non_nullable
as Money,perDay: freezed == perDay ? _self.perDay : perDay // ignore: cast_nullable_to_non_nullable
as Money?,guiltFreeLeft: null == guiltFreeLeft ? _self.guiltFreeLeft : guiltFreeLeft // ignore: cast_nullable_to_non_nullable
as Money,buckets: null == buckets ? _self._buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<BucketTileVm>,unsortedCount: null == unsortedCount ? _self.unsortedCount : unsortedCount // ignore: cast_nullable_to_non_nullable
as int,recent: null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<TransactionRowVm>,banner: freezed == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as PaydayBannerVm?,unlocked: null == unlocked ? _self.unlocked : unlocked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaydayBannerVmCopyWith<$Res>? get banner {
    if (_self.banner == null) {
    return null;
  }

  return $PaydayBannerVmCopyWith<$Res>(_self.banner!, (value) {
    return _then(_self.copyWith(banner: value));
  });
}
}

// dart format on
