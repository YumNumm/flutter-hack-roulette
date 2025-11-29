// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roulette_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouletteState {

 RouletteStatus get status; double get rotation; double get rotationVelocity; int? get selectedTeamIndex;
/// Create a copy of RouletteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouletteStateCopyWith<RouletteState> get copyWith => _$RouletteStateCopyWithImpl<RouletteState>(this as RouletteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouletteState&&(identical(other.status, status) || other.status == status)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.rotationVelocity, rotationVelocity) || other.rotationVelocity == rotationVelocity)&&(identical(other.selectedTeamIndex, selectedTeamIndex) || other.selectedTeamIndex == selectedTeamIndex));
}


@override
int get hashCode => Object.hash(runtimeType,status,rotation,rotationVelocity,selectedTeamIndex);

@override
String toString() {
  return 'RouletteState(status: $status, rotation: $rotation, rotationVelocity: $rotationVelocity, selectedTeamIndex: $selectedTeamIndex)';
}


}

/// @nodoc
abstract mixin class $RouletteStateCopyWith<$Res>  {
  factory $RouletteStateCopyWith(RouletteState value, $Res Function(RouletteState) _then) = _$RouletteStateCopyWithImpl;
@useResult
$Res call({
 RouletteStatus status, double rotation, double rotationVelocity, int? selectedTeamIndex
});




}
/// @nodoc
class _$RouletteStateCopyWithImpl<$Res>
    implements $RouletteStateCopyWith<$Res> {
  _$RouletteStateCopyWithImpl(this._self, this._then);

  final RouletteState _self;
  final $Res Function(RouletteState) _then;

/// Create a copy of RouletteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? rotation = null,Object? rotationVelocity = null,Object? selectedTeamIndex = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RouletteStatus,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,rotationVelocity: null == rotationVelocity ? _self.rotationVelocity : rotationVelocity // ignore: cast_nullable_to_non_nullable
as double,selectedTeamIndex: freezed == selectedTeamIndex ? _self.selectedTeamIndex : selectedTeamIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RouletteState].
extension RouletteStatePatterns on RouletteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouletteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouletteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouletteState value)  $default,){
final _that = this;
switch (_that) {
case _RouletteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouletteState value)?  $default,){
final _that = this;
switch (_that) {
case _RouletteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RouletteStatus status,  double rotation,  double rotationVelocity,  int? selectedTeamIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouletteState() when $default != null:
return $default(_that.status,_that.rotation,_that.rotationVelocity,_that.selectedTeamIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RouletteStatus status,  double rotation,  double rotationVelocity,  int? selectedTeamIndex)  $default,) {final _that = this;
switch (_that) {
case _RouletteState():
return $default(_that.status,_that.rotation,_that.rotationVelocity,_that.selectedTeamIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RouletteStatus status,  double rotation,  double rotationVelocity,  int? selectedTeamIndex)?  $default,) {final _that = this;
switch (_that) {
case _RouletteState() when $default != null:
return $default(_that.status,_that.rotation,_that.rotationVelocity,_that.selectedTeamIndex);case _:
  return null;

}
}

}

/// @nodoc


class _RouletteState implements RouletteState {
  const _RouletteState({this.status = RouletteStatus.idle, this.rotation = 0.0, this.rotationVelocity = 0.0, this.selectedTeamIndex});
  

@override@JsonKey() final  RouletteStatus status;
@override@JsonKey() final  double rotation;
@override@JsonKey() final  double rotationVelocity;
@override final  int? selectedTeamIndex;

/// Create a copy of RouletteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouletteStateCopyWith<_RouletteState> get copyWith => __$RouletteStateCopyWithImpl<_RouletteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouletteState&&(identical(other.status, status) || other.status == status)&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.rotationVelocity, rotationVelocity) || other.rotationVelocity == rotationVelocity)&&(identical(other.selectedTeamIndex, selectedTeamIndex) || other.selectedTeamIndex == selectedTeamIndex));
}


@override
int get hashCode => Object.hash(runtimeType,status,rotation,rotationVelocity,selectedTeamIndex);

@override
String toString() {
  return 'RouletteState(status: $status, rotation: $rotation, rotationVelocity: $rotationVelocity, selectedTeamIndex: $selectedTeamIndex)';
}


}

/// @nodoc
abstract mixin class _$RouletteStateCopyWith<$Res> implements $RouletteStateCopyWith<$Res> {
  factory _$RouletteStateCopyWith(_RouletteState value, $Res Function(_RouletteState) _then) = __$RouletteStateCopyWithImpl;
@override @useResult
$Res call({
 RouletteStatus status, double rotation, double rotationVelocity, int? selectedTeamIndex
});




}
/// @nodoc
class __$RouletteStateCopyWithImpl<$Res>
    implements _$RouletteStateCopyWith<$Res> {
  __$RouletteStateCopyWithImpl(this._self, this._then);

  final _RouletteState _self;
  final $Res Function(_RouletteState) _then;

/// Create a copy of RouletteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? rotation = null,Object? rotationVelocity = null,Object? selectedTeamIndex = freezed,}) {
  return _then(_RouletteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RouletteStatus,rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,rotationVelocity: null == rotationVelocity ? _self.rotationVelocity : rotationVelocity // ignore: cast_nullable_to_non_nullable
as double,selectedTeamIndex: freezed == selectedTeamIndex ? _self.selectedTeamIndex : selectedTeamIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
