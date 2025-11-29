// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amida_ladder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AmidaLadder {

 int get teamCount; List<HorizontalLine> get horizontalLines;
/// Create a copy of AmidaLadder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmidaLadderCopyWith<AmidaLadder> get copyWith => _$AmidaLadderCopyWithImpl<AmidaLadder>(this as AmidaLadder, _$identity);

  /// Serializes this AmidaLadder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmidaLadder&&(identical(other.teamCount, teamCount) || other.teamCount == teamCount)&&const DeepCollectionEquality().equals(other.horizontalLines, horizontalLines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamCount,const DeepCollectionEquality().hash(horizontalLines));

@override
String toString() {
  return 'AmidaLadder(teamCount: $teamCount, horizontalLines: $horizontalLines)';
}


}

/// @nodoc
abstract mixin class $AmidaLadderCopyWith<$Res>  {
  factory $AmidaLadderCopyWith(AmidaLadder value, $Res Function(AmidaLadder) _then) = _$AmidaLadderCopyWithImpl;
@useResult
$Res call({
 int teamCount, List<HorizontalLine> horizontalLines
});




}
/// @nodoc
class _$AmidaLadderCopyWithImpl<$Res>
    implements $AmidaLadderCopyWith<$Res> {
  _$AmidaLadderCopyWithImpl(this._self, this._then);

  final AmidaLadder _self;
  final $Res Function(AmidaLadder) _then;

/// Create a copy of AmidaLadder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamCount = null,Object? horizontalLines = null,}) {
  return _then(_self.copyWith(
teamCount: null == teamCount ? _self.teamCount : teamCount // ignore: cast_nullable_to_non_nullable
as int,horizontalLines: null == horizontalLines ? _self.horizontalLines : horizontalLines // ignore: cast_nullable_to_non_nullable
as List<HorizontalLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [AmidaLadder].
extension AmidaLadderPatterns on AmidaLadder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmidaLadder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmidaLadder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmidaLadder value)  $default,){
final _that = this;
switch (_that) {
case _AmidaLadder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmidaLadder value)?  $default,){
final _that = this;
switch (_that) {
case _AmidaLadder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int teamCount,  List<HorizontalLine> horizontalLines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmidaLadder() when $default != null:
return $default(_that.teamCount,_that.horizontalLines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int teamCount,  List<HorizontalLine> horizontalLines)  $default,) {final _that = this;
switch (_that) {
case _AmidaLadder():
return $default(_that.teamCount,_that.horizontalLines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int teamCount,  List<HorizontalLine> horizontalLines)?  $default,) {final _that = this;
switch (_that) {
case _AmidaLadder() when $default != null:
return $default(_that.teamCount,_that.horizontalLines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmidaLadder implements AmidaLadder {
  const _AmidaLadder({required this.teamCount, required final  List<HorizontalLine> horizontalLines}): _horizontalLines = horizontalLines;
  factory _AmidaLadder.fromJson(Map<String, dynamic> json) => _$AmidaLadderFromJson(json);

@override final  int teamCount;
 final  List<HorizontalLine> _horizontalLines;
@override List<HorizontalLine> get horizontalLines {
  if (_horizontalLines is EqualUnmodifiableListView) return _horizontalLines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_horizontalLines);
}


/// Create a copy of AmidaLadder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmidaLadderCopyWith<_AmidaLadder> get copyWith => __$AmidaLadderCopyWithImpl<_AmidaLadder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmidaLadderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmidaLadder&&(identical(other.teamCount, teamCount) || other.teamCount == teamCount)&&const DeepCollectionEquality().equals(other._horizontalLines, _horizontalLines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamCount,const DeepCollectionEquality().hash(_horizontalLines));

@override
String toString() {
  return 'AmidaLadder(teamCount: $teamCount, horizontalLines: $horizontalLines)';
}


}

/// @nodoc
abstract mixin class _$AmidaLadderCopyWith<$Res> implements $AmidaLadderCopyWith<$Res> {
  factory _$AmidaLadderCopyWith(_AmidaLadder value, $Res Function(_AmidaLadder) _then) = __$AmidaLadderCopyWithImpl;
@override @useResult
$Res call({
 int teamCount, List<HorizontalLine> horizontalLines
});




}
/// @nodoc
class __$AmidaLadderCopyWithImpl<$Res>
    implements _$AmidaLadderCopyWith<$Res> {
  __$AmidaLadderCopyWithImpl(this._self, this._then);

  final _AmidaLadder _self;
  final $Res Function(_AmidaLadder) _then;

/// Create a copy of AmidaLadder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamCount = null,Object? horizontalLines = null,}) {
  return _then(_AmidaLadder(
teamCount: null == teamCount ? _self.teamCount : teamCount // ignore: cast_nullable_to_non_nullable
as int,horizontalLines: null == horizontalLines ? _self._horizontalLines : horizontalLines // ignore: cast_nullable_to_non_nullable
as List<HorizontalLine>,
  ));
}


}


/// @nodoc
mixin _$HorizontalLine {

 int get leftIndex; int get rightIndex; double get yPosition;
/// Create a copy of HorizontalLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HorizontalLineCopyWith<HorizontalLine> get copyWith => _$HorizontalLineCopyWithImpl<HorizontalLine>(this as HorizontalLine, _$identity);

  /// Serializes this HorizontalLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HorizontalLine&&(identical(other.leftIndex, leftIndex) || other.leftIndex == leftIndex)&&(identical(other.rightIndex, rightIndex) || other.rightIndex == rightIndex)&&(identical(other.yPosition, yPosition) || other.yPosition == yPosition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leftIndex,rightIndex,yPosition);

@override
String toString() {
  return 'HorizontalLine(leftIndex: $leftIndex, rightIndex: $rightIndex, yPosition: $yPosition)';
}


}

/// @nodoc
abstract mixin class $HorizontalLineCopyWith<$Res>  {
  factory $HorizontalLineCopyWith(HorizontalLine value, $Res Function(HorizontalLine) _then) = _$HorizontalLineCopyWithImpl;
@useResult
$Res call({
 int leftIndex, int rightIndex, double yPosition
});




}
/// @nodoc
class _$HorizontalLineCopyWithImpl<$Res>
    implements $HorizontalLineCopyWith<$Res> {
  _$HorizontalLineCopyWithImpl(this._self, this._then);

  final HorizontalLine _self;
  final $Res Function(HorizontalLine) _then;

/// Create a copy of HorizontalLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leftIndex = null,Object? rightIndex = null,Object? yPosition = null,}) {
  return _then(_self.copyWith(
leftIndex: null == leftIndex ? _self.leftIndex : leftIndex // ignore: cast_nullable_to_non_nullable
as int,rightIndex: null == rightIndex ? _self.rightIndex : rightIndex // ignore: cast_nullable_to_non_nullable
as int,yPosition: null == yPosition ? _self.yPosition : yPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [HorizontalLine].
extension HorizontalLinePatterns on HorizontalLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HorizontalLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HorizontalLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HorizontalLine value)  $default,){
final _that = this;
switch (_that) {
case _HorizontalLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HorizontalLine value)?  $default,){
final _that = this;
switch (_that) {
case _HorizontalLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int leftIndex,  int rightIndex,  double yPosition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HorizontalLine() when $default != null:
return $default(_that.leftIndex,_that.rightIndex,_that.yPosition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int leftIndex,  int rightIndex,  double yPosition)  $default,) {final _that = this;
switch (_that) {
case _HorizontalLine():
return $default(_that.leftIndex,_that.rightIndex,_that.yPosition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int leftIndex,  int rightIndex,  double yPosition)?  $default,) {final _that = this;
switch (_that) {
case _HorizontalLine() when $default != null:
return $default(_that.leftIndex,_that.rightIndex,_that.yPosition);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HorizontalLine implements HorizontalLine {
  const _HorizontalLine({required this.leftIndex, required this.rightIndex, required this.yPosition});
  factory _HorizontalLine.fromJson(Map<String, dynamic> json) => _$HorizontalLineFromJson(json);

@override final  int leftIndex;
@override final  int rightIndex;
@override final  double yPosition;

/// Create a copy of HorizontalLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HorizontalLineCopyWith<_HorizontalLine> get copyWith => __$HorizontalLineCopyWithImpl<_HorizontalLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HorizontalLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HorizontalLine&&(identical(other.leftIndex, leftIndex) || other.leftIndex == leftIndex)&&(identical(other.rightIndex, rightIndex) || other.rightIndex == rightIndex)&&(identical(other.yPosition, yPosition) || other.yPosition == yPosition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leftIndex,rightIndex,yPosition);

@override
String toString() {
  return 'HorizontalLine(leftIndex: $leftIndex, rightIndex: $rightIndex, yPosition: $yPosition)';
}


}

/// @nodoc
abstract mixin class _$HorizontalLineCopyWith<$Res> implements $HorizontalLineCopyWith<$Res> {
  factory _$HorizontalLineCopyWith(_HorizontalLine value, $Res Function(_HorizontalLine) _then) = __$HorizontalLineCopyWithImpl;
@override @useResult
$Res call({
 int leftIndex, int rightIndex, double yPosition
});




}
/// @nodoc
class __$HorizontalLineCopyWithImpl<$Res>
    implements _$HorizontalLineCopyWith<$Res> {
  __$HorizontalLineCopyWithImpl(this._self, this._then);

  final _HorizontalLine _self;
  final $Res Function(_HorizontalLine) _then;

/// Create a copy of HorizontalLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leftIndex = null,Object? rightIndex = null,Object? yPosition = null,}) {
  return _then(_HorizontalLine(
leftIndex: null == leftIndex ? _self.leftIndex : leftIndex // ignore: cast_nullable_to_non_nullable
as int,rightIndex: null == rightIndex ? _self.rightIndex : rightIndex // ignore: cast_nullable_to_non_nullable
as int,yPosition: null == yPosition ? _self.yPosition : yPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
