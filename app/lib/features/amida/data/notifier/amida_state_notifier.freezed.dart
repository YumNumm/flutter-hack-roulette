// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amida_state_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AmidaState {

 AmidaLadder? get ladder; AmidaResult? get result; PresentationState get presentationState; List<AmidaPath>? get paths;
/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmidaStateCopyWith<AmidaState> get copyWith => _$AmidaStateCopyWithImpl<AmidaState>(this as AmidaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmidaState&&(identical(other.ladder, ladder) || other.ladder == ladder)&&(identical(other.result, result) || other.result == result)&&(identical(other.presentationState, presentationState) || other.presentationState == presentationState)&&const DeepCollectionEquality().equals(other.paths, paths));
}


@override
int get hashCode => Object.hash(runtimeType,ladder,result,presentationState,const DeepCollectionEquality().hash(paths));

@override
String toString() {
  return 'AmidaState(ladder: $ladder, result: $result, presentationState: $presentationState, paths: $paths)';
}


}

/// @nodoc
abstract mixin class $AmidaStateCopyWith<$Res>  {
  factory $AmidaStateCopyWith(AmidaState value, $Res Function(AmidaState) _then) = _$AmidaStateCopyWithImpl;
@useResult
$Res call({
 AmidaLadder? ladder, AmidaResult? result, PresentationState presentationState, List<AmidaPath>? paths
});


$AmidaLadderCopyWith<$Res>? get ladder;$AmidaResultCopyWith<$Res>? get result;$PresentationStateCopyWith<$Res> get presentationState;

}
/// @nodoc
class _$AmidaStateCopyWithImpl<$Res>
    implements $AmidaStateCopyWith<$Res> {
  _$AmidaStateCopyWithImpl(this._self, this._then);

  final AmidaState _self;
  final $Res Function(AmidaState) _then;

/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ladder = freezed,Object? result = freezed,Object? presentationState = null,Object? paths = freezed,}) {
  return _then(_self.copyWith(
ladder: freezed == ladder ? _self.ladder : ladder // ignore: cast_nullable_to_non_nullable
as AmidaLadder?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AmidaResult?,presentationState: null == presentationState ? _self.presentationState : presentationState // ignore: cast_nullable_to_non_nullable
as PresentationState,paths: freezed == paths ? _self.paths : paths // ignore: cast_nullable_to_non_nullable
as List<AmidaPath>?,
  ));
}
/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmidaLadderCopyWith<$Res>? get ladder {
    if (_self.ladder == null) {
    return null;
  }

  return $AmidaLadderCopyWith<$Res>(_self.ladder!, (value) {
    return _then(_self.copyWith(ladder: value));
  });
}/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmidaResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $AmidaResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PresentationStateCopyWith<$Res> get presentationState {
  
  return $PresentationStateCopyWith<$Res>(_self.presentationState, (value) {
    return _then(_self.copyWith(presentationState: value));
  });
}
}


/// Adds pattern-matching-related methods to [AmidaState].
extension AmidaStatePatterns on AmidaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmidaState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmidaState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmidaState value)  $default,){
final _that = this;
switch (_that) {
case _AmidaState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmidaState value)?  $default,){
final _that = this;
switch (_that) {
case _AmidaState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AmidaLadder? ladder,  AmidaResult? result,  PresentationState presentationState,  List<AmidaPath>? paths)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmidaState() when $default != null:
return $default(_that.ladder,_that.result,_that.presentationState,_that.paths);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AmidaLadder? ladder,  AmidaResult? result,  PresentationState presentationState,  List<AmidaPath>? paths)  $default,) {final _that = this;
switch (_that) {
case _AmidaState():
return $default(_that.ladder,_that.result,_that.presentationState,_that.paths);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AmidaLadder? ladder,  AmidaResult? result,  PresentationState presentationState,  List<AmidaPath>? paths)?  $default,) {final _that = this;
switch (_that) {
case _AmidaState() when $default != null:
return $default(_that.ladder,_that.result,_that.presentationState,_that.paths);case _:
  return null;

}
}

}

/// @nodoc


class _AmidaState extends AmidaState {
  const _AmidaState({this.ladder, this.result, this.presentationState = PresentationState.initial, final  List<AmidaPath>? paths}): _paths = paths,super._();
  

@override final  AmidaLadder? ladder;
@override final  AmidaResult? result;
@override@JsonKey() final  PresentationState presentationState;
 final  List<AmidaPath>? _paths;
@override List<AmidaPath>? get paths {
  final value = _paths;
  if (value == null) return null;
  if (_paths is EqualUnmodifiableListView) return _paths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmidaStateCopyWith<_AmidaState> get copyWith => __$AmidaStateCopyWithImpl<_AmidaState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmidaState&&(identical(other.ladder, ladder) || other.ladder == ladder)&&(identical(other.result, result) || other.result == result)&&(identical(other.presentationState, presentationState) || other.presentationState == presentationState)&&const DeepCollectionEquality().equals(other._paths, _paths));
}


@override
int get hashCode => Object.hash(runtimeType,ladder,result,presentationState,const DeepCollectionEquality().hash(_paths));

@override
String toString() {
  return 'AmidaState(ladder: $ladder, result: $result, presentationState: $presentationState, paths: $paths)';
}


}

/// @nodoc
abstract mixin class _$AmidaStateCopyWith<$Res> implements $AmidaStateCopyWith<$Res> {
  factory _$AmidaStateCopyWith(_AmidaState value, $Res Function(_AmidaState) _then) = __$AmidaStateCopyWithImpl;
@override @useResult
$Res call({
 AmidaLadder? ladder, AmidaResult? result, PresentationState presentationState, List<AmidaPath>? paths
});


@override $AmidaLadderCopyWith<$Res>? get ladder;@override $AmidaResultCopyWith<$Res>? get result;@override $PresentationStateCopyWith<$Res> get presentationState;

}
/// @nodoc
class __$AmidaStateCopyWithImpl<$Res>
    implements _$AmidaStateCopyWith<$Res> {
  __$AmidaStateCopyWithImpl(this._self, this._then);

  final _AmidaState _self;
  final $Res Function(_AmidaState) _then;

/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ladder = freezed,Object? result = freezed,Object? presentationState = null,Object? paths = freezed,}) {
  return _then(_AmidaState(
ladder: freezed == ladder ? _self.ladder : ladder // ignore: cast_nullable_to_non_nullable
as AmidaLadder?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as AmidaResult?,presentationState: null == presentationState ? _self.presentationState : presentationState // ignore: cast_nullable_to_non_nullable
as PresentationState,paths: freezed == paths ? _self._paths : paths // ignore: cast_nullable_to_non_nullable
as List<AmidaPath>?,
  ));
}

/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmidaLadderCopyWith<$Res>? get ladder {
    if (_self.ladder == null) {
    return null;
  }

  return $AmidaLadderCopyWith<$Res>(_self.ladder!, (value) {
    return _then(_self.copyWith(ladder: value));
  });
}/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmidaResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $AmidaResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of AmidaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PresentationStateCopyWith<$Res> get presentationState {
  
  return $PresentationStateCopyWith<$Res>(_self.presentationState, (value) {
    return _then(_self.copyWith(presentationState: value));
  });
}
}

// dart format on
