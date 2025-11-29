// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pinball_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PinballResult {

 String get teamId; int get holeNumber; DateTime get timestamp;
/// Create a copy of PinballResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinballResultCopyWith<PinballResult> get copyWith => _$PinballResultCopyWithImpl<PinballResult>(this as PinballResult, _$identity);

  /// Serializes this PinballResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinballResult&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.holeNumber, holeNumber) || other.holeNumber == holeNumber)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,holeNumber,timestamp);

@override
String toString() {
  return 'PinballResult(teamId: $teamId, holeNumber: $holeNumber, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $PinballResultCopyWith<$Res>  {
  factory $PinballResultCopyWith(PinballResult value, $Res Function(PinballResult) _then) = _$PinballResultCopyWithImpl;
@useResult
$Res call({
 String teamId, int holeNumber, DateTime timestamp
});




}
/// @nodoc
class _$PinballResultCopyWithImpl<$Res>
    implements $PinballResultCopyWith<$Res> {
  _$PinballResultCopyWithImpl(this._self, this._then);

  final PinballResult _self;
  final $Res Function(PinballResult) _then;

/// Create a copy of PinballResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamId = null,Object? holeNumber = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,holeNumber: null == holeNumber ? _self.holeNumber : holeNumber // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PinballResult].
extension PinballResultPatterns on PinballResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinballResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinballResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinballResult value)  $default,){
final _that = this;
switch (_that) {
case _PinballResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinballResult value)?  $default,){
final _that = this;
switch (_that) {
case _PinballResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String teamId,  int holeNumber,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinballResult() when $default != null:
return $default(_that.teamId,_that.holeNumber,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String teamId,  int holeNumber,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _PinballResult():
return $default(_that.teamId,_that.holeNumber,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String teamId,  int holeNumber,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _PinballResult() when $default != null:
return $default(_that.teamId,_that.holeNumber,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinballResult implements PinballResult {
  const _PinballResult({required this.teamId, required this.holeNumber, required this.timestamp});
  factory _PinballResult.fromJson(Map<String, dynamic> json) => _$PinballResultFromJson(json);

@override final  String teamId;
@override final  int holeNumber;
@override final  DateTime timestamp;

/// Create a copy of PinballResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinballResultCopyWith<_PinballResult> get copyWith => __$PinballResultCopyWithImpl<_PinballResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinballResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinballResult&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.holeNumber, holeNumber) || other.holeNumber == holeNumber)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,holeNumber,timestamp);

@override
String toString() {
  return 'PinballResult(teamId: $teamId, holeNumber: $holeNumber, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PinballResultCopyWith<$Res> implements $PinballResultCopyWith<$Res> {
  factory _$PinballResultCopyWith(_PinballResult value, $Res Function(_PinballResult) _then) = __$PinballResultCopyWithImpl;
@override @useResult
$Res call({
 String teamId, int holeNumber, DateTime timestamp
});




}
/// @nodoc
class __$PinballResultCopyWithImpl<$Res>
    implements _$PinballResultCopyWith<$Res> {
  __$PinballResultCopyWithImpl(this._self, this._then);

  final _PinballResult _self;
  final $Res Function(_PinballResult) _then;

/// Create a copy of PinballResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamId = null,Object? holeNumber = null,Object? timestamp = null,}) {
  return _then(_PinballResult(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,holeNumber: null == holeNumber ? _self.holeNumber : holeNumber // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
