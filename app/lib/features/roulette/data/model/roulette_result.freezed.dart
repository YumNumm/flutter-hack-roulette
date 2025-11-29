// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roulette_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RouletteResult {

 String get teamId; int get selectedOrder; DateTime get timestamp;
/// Create a copy of RouletteResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouletteResultCopyWith<RouletteResult> get copyWith => _$RouletteResultCopyWithImpl<RouletteResult>(this as RouletteResult, _$identity);

  /// Serializes this RouletteResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouletteResult&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.selectedOrder, selectedOrder) || other.selectedOrder == selectedOrder)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,selectedOrder,timestamp);

@override
String toString() {
  return 'RouletteResult(teamId: $teamId, selectedOrder: $selectedOrder, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $RouletteResultCopyWith<$Res>  {
  factory $RouletteResultCopyWith(RouletteResult value, $Res Function(RouletteResult) _then) = _$RouletteResultCopyWithImpl;
@useResult
$Res call({
 String teamId, int selectedOrder, DateTime timestamp
});




}
/// @nodoc
class _$RouletteResultCopyWithImpl<$Res>
    implements $RouletteResultCopyWith<$Res> {
  _$RouletteResultCopyWithImpl(this._self, this._then);

  final RouletteResult _self;
  final $Res Function(RouletteResult) _then;

/// Create a copy of RouletteResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamId = null,Object? selectedOrder = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,selectedOrder: null == selectedOrder ? _self.selectedOrder : selectedOrder // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RouletteResult].
extension RouletteResultPatterns on RouletteResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouletteResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouletteResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouletteResult value)  $default,){
final _that = this;
switch (_that) {
case _RouletteResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouletteResult value)?  $default,){
final _that = this;
switch (_that) {
case _RouletteResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String teamId,  int selectedOrder,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouletteResult() when $default != null:
return $default(_that.teamId,_that.selectedOrder,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String teamId,  int selectedOrder,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _RouletteResult():
return $default(_that.teamId,_that.selectedOrder,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String teamId,  int selectedOrder,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _RouletteResult() when $default != null:
return $default(_that.teamId,_that.selectedOrder,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RouletteResult implements RouletteResult {
  const _RouletteResult({required this.teamId, required this.selectedOrder, required this.timestamp});
  factory _RouletteResult.fromJson(Map<String, dynamic> json) => _$RouletteResultFromJson(json);

@override final  String teamId;
@override final  int selectedOrder;
@override final  DateTime timestamp;

/// Create a copy of RouletteResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouletteResultCopyWith<_RouletteResult> get copyWith => __$RouletteResultCopyWithImpl<_RouletteResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouletteResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouletteResult&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.selectedOrder, selectedOrder) || other.selectedOrder == selectedOrder)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,selectedOrder,timestamp);

@override
String toString() {
  return 'RouletteResult(teamId: $teamId, selectedOrder: $selectedOrder, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$RouletteResultCopyWith<$Res> implements $RouletteResultCopyWith<$Res> {
  factory _$RouletteResultCopyWith(_RouletteResult value, $Res Function(_RouletteResult) _then) = __$RouletteResultCopyWithImpl;
@override @useResult
$Res call({
 String teamId, int selectedOrder, DateTime timestamp
});




}
/// @nodoc
class __$RouletteResultCopyWithImpl<$Res>
    implements _$RouletteResultCopyWith<$Res> {
  __$RouletteResultCopyWithImpl(this._self, this._then);

  final _RouletteResult _self;
  final $Res Function(_RouletteResult) _then;

/// Create a copy of RouletteResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamId = null,Object? selectedOrder = null,Object? timestamp = null,}) {
  return _then(_RouletteResult(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,selectedOrder: null == selectedOrder ? _self.selectedOrder : selectedOrder // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
