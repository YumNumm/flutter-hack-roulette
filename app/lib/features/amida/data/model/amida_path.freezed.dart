// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amida_path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AmidaPath {

 int get startIndex; int get endIndex; List<PathPoint> get points;
/// Create a copy of AmidaPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmidaPathCopyWith<AmidaPath> get copyWith => _$AmidaPathCopyWithImpl<AmidaPath>(this as AmidaPath, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmidaPath&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex)&&(identical(other.endIndex, endIndex) || other.endIndex == endIndex)&&const DeepCollectionEquality().equals(other.points, points));
}


@override
int get hashCode => Object.hash(runtimeType,startIndex,endIndex,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'AmidaPath(startIndex: $startIndex, endIndex: $endIndex, points: $points)';
}


}

/// @nodoc
abstract mixin class $AmidaPathCopyWith<$Res>  {
  factory $AmidaPathCopyWith(AmidaPath value, $Res Function(AmidaPath) _then) = _$AmidaPathCopyWithImpl;
@useResult
$Res call({
 int startIndex, int endIndex, List<PathPoint> points
});




}
/// @nodoc
class _$AmidaPathCopyWithImpl<$Res>
    implements $AmidaPathCopyWith<$Res> {
  _$AmidaPathCopyWithImpl(this._self, this._then);

  final AmidaPath _self;
  final $Res Function(AmidaPath) _then;

/// Create a copy of AmidaPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startIndex = null,Object? endIndex = null,Object? points = null,}) {
  return _then(_self.copyWith(
startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,endIndex: null == endIndex ? _self.endIndex : endIndex // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<PathPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [AmidaPath].
extension AmidaPathPatterns on AmidaPath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmidaPath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmidaPath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmidaPath value)  $default,){
final _that = this;
switch (_that) {
case _AmidaPath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmidaPath value)?  $default,){
final _that = this;
switch (_that) {
case _AmidaPath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int startIndex,  int endIndex,  List<PathPoint> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmidaPath() when $default != null:
return $default(_that.startIndex,_that.endIndex,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int startIndex,  int endIndex,  List<PathPoint> points)  $default,) {final _that = this;
switch (_that) {
case _AmidaPath():
return $default(_that.startIndex,_that.endIndex,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int startIndex,  int endIndex,  List<PathPoint> points)?  $default,) {final _that = this;
switch (_that) {
case _AmidaPath() when $default != null:
return $default(_that.startIndex,_that.endIndex,_that.points);case _:
  return null;

}
}

}

/// @nodoc


class _AmidaPath implements AmidaPath {
  const _AmidaPath({required this.startIndex, required this.endIndex, required final  List<PathPoint> points}): _points = points;
  

@override final  int startIndex;
@override final  int endIndex;
 final  List<PathPoint> _points;
@override List<PathPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of AmidaPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmidaPathCopyWith<_AmidaPath> get copyWith => __$AmidaPathCopyWithImpl<_AmidaPath>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmidaPath&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex)&&(identical(other.endIndex, endIndex) || other.endIndex == endIndex)&&const DeepCollectionEquality().equals(other._points, _points));
}


@override
int get hashCode => Object.hash(runtimeType,startIndex,endIndex,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'AmidaPath(startIndex: $startIndex, endIndex: $endIndex, points: $points)';
}


}

/// @nodoc
abstract mixin class _$AmidaPathCopyWith<$Res> implements $AmidaPathCopyWith<$Res> {
  factory _$AmidaPathCopyWith(_AmidaPath value, $Res Function(_AmidaPath) _then) = __$AmidaPathCopyWithImpl;
@override @useResult
$Res call({
 int startIndex, int endIndex, List<PathPoint> points
});




}
/// @nodoc
class __$AmidaPathCopyWithImpl<$Res>
    implements _$AmidaPathCopyWith<$Res> {
  __$AmidaPathCopyWithImpl(this._self, this._then);

  final _AmidaPath _self;
  final $Res Function(_AmidaPath) _then;

/// Create a copy of AmidaPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startIndex = null,Object? endIndex = null,Object? points = null,}) {
  return _then(_AmidaPath(
startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,endIndex: null == endIndex ? _self.endIndex : endIndex // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PathPoint>,
  ));
}


}

/// @nodoc
mixin _$PathPoint {

 int get columnIndex; double get yPosition;
/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PathPointCopyWith<PathPoint> get copyWith => _$PathPointCopyWithImpl<PathPoint>(this as PathPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PathPoint&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.yPosition, yPosition) || other.yPosition == yPosition));
}


@override
int get hashCode => Object.hash(runtimeType,columnIndex,yPosition);

@override
String toString() {
  return 'PathPoint(columnIndex: $columnIndex, yPosition: $yPosition)';
}


}

/// @nodoc
abstract mixin class $PathPointCopyWith<$Res>  {
  factory $PathPointCopyWith(PathPoint value, $Res Function(PathPoint) _then) = _$PathPointCopyWithImpl;
@useResult
$Res call({
 int columnIndex, double yPosition
});




}
/// @nodoc
class _$PathPointCopyWithImpl<$Res>
    implements $PathPointCopyWith<$Res> {
  _$PathPointCopyWithImpl(this._self, this._then);

  final PathPoint _self;
  final $Res Function(PathPoint) _then;

/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? columnIndex = null,Object? yPosition = null,}) {
  return _then(_self.copyWith(
columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,yPosition: null == yPosition ? _self.yPosition : yPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PathPoint].
extension PathPointPatterns on PathPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PathPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PathPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PathPoint value)  $default,){
final _that = this;
switch (_that) {
case _PathPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PathPoint value)?  $default,){
final _that = this;
switch (_that) {
case _PathPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int columnIndex,  double yPosition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PathPoint() when $default != null:
return $default(_that.columnIndex,_that.yPosition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int columnIndex,  double yPosition)  $default,) {final _that = this;
switch (_that) {
case _PathPoint():
return $default(_that.columnIndex,_that.yPosition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int columnIndex,  double yPosition)?  $default,) {final _that = this;
switch (_that) {
case _PathPoint() when $default != null:
return $default(_that.columnIndex,_that.yPosition);case _:
  return null;

}
}

}

/// @nodoc


class _PathPoint implements PathPoint {
  const _PathPoint({required this.columnIndex, required this.yPosition});
  

@override final  int columnIndex;
@override final  double yPosition;

/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PathPointCopyWith<_PathPoint> get copyWith => __$PathPointCopyWithImpl<_PathPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PathPoint&&(identical(other.columnIndex, columnIndex) || other.columnIndex == columnIndex)&&(identical(other.yPosition, yPosition) || other.yPosition == yPosition));
}


@override
int get hashCode => Object.hash(runtimeType,columnIndex,yPosition);

@override
String toString() {
  return 'PathPoint(columnIndex: $columnIndex, yPosition: $yPosition)';
}


}

/// @nodoc
abstract mixin class _$PathPointCopyWith<$Res> implements $PathPointCopyWith<$Res> {
  factory _$PathPointCopyWith(_PathPoint value, $Res Function(_PathPoint) _then) = __$PathPointCopyWithImpl;
@override @useResult
$Res call({
 int columnIndex, double yPosition
});




}
/// @nodoc
class __$PathPointCopyWithImpl<$Res>
    implements _$PathPointCopyWith<$Res> {
  __$PathPointCopyWithImpl(this._self, this._then);

  final _PathPoint _self;
  final $Res Function(_PathPoint) _then;

/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? columnIndex = null,Object? yPosition = null,}) {
  return _then(_PathPoint(
columnIndex: null == columnIndex ? _self.columnIndex : columnIndex // ignore: cast_nullable_to_non_nullable
as int,yPosition: null == yPosition ? _self.yPosition : yPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
