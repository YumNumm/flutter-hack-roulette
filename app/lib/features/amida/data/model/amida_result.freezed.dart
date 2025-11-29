// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'amida_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AmidaResult {

 List<String> get teamIds; List<int> get resultOrder; DateTime get generatedAt;
/// Create a copy of AmidaResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmidaResultCopyWith<AmidaResult> get copyWith => _$AmidaResultCopyWithImpl<AmidaResult>(this as AmidaResult, _$identity);

  /// Serializes this AmidaResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmidaResult&&const DeepCollectionEquality().equals(other.teamIds, teamIds)&&const DeepCollectionEquality().equals(other.resultOrder, resultOrder)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(teamIds),const DeepCollectionEquality().hash(resultOrder),generatedAt);

@override
String toString() {
  return 'AmidaResult(teamIds: $teamIds, resultOrder: $resultOrder, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $AmidaResultCopyWith<$Res>  {
  factory $AmidaResultCopyWith(AmidaResult value, $Res Function(AmidaResult) _then) = _$AmidaResultCopyWithImpl;
@useResult
$Res call({
 List<String> teamIds, List<int> resultOrder, DateTime generatedAt
});




}
/// @nodoc
class _$AmidaResultCopyWithImpl<$Res>
    implements $AmidaResultCopyWith<$Res> {
  _$AmidaResultCopyWithImpl(this._self, this._then);

  final AmidaResult _self;
  final $Res Function(AmidaResult) _then;

/// Create a copy of AmidaResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamIds = null,Object? resultOrder = null,Object? generatedAt = null,}) {
  return _then(_self.copyWith(
teamIds: null == teamIds ? _self.teamIds : teamIds // ignore: cast_nullable_to_non_nullable
as List<String>,resultOrder: null == resultOrder ? _self.resultOrder : resultOrder // ignore: cast_nullable_to_non_nullable
as List<int>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AmidaResult].
extension AmidaResultPatterns on AmidaResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmidaResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmidaResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmidaResult value)  $default,){
final _that = this;
switch (_that) {
case _AmidaResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmidaResult value)?  $default,){
final _that = this;
switch (_that) {
case _AmidaResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> teamIds,  List<int> resultOrder,  DateTime generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmidaResult() when $default != null:
return $default(_that.teamIds,_that.resultOrder,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> teamIds,  List<int> resultOrder,  DateTime generatedAt)  $default,) {final _that = this;
switch (_that) {
case _AmidaResult():
return $default(_that.teamIds,_that.resultOrder,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> teamIds,  List<int> resultOrder,  DateTime generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AmidaResult() when $default != null:
return $default(_that.teamIds,_that.resultOrder,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmidaResult implements AmidaResult {
  const _AmidaResult({required final  List<String> teamIds, required final  List<int> resultOrder, required this.generatedAt}): _teamIds = teamIds,_resultOrder = resultOrder;
  factory _AmidaResult.fromJson(Map<String, dynamic> json) => _$AmidaResultFromJson(json);

 final  List<String> _teamIds;
@override List<String> get teamIds {
  if (_teamIds is EqualUnmodifiableListView) return _teamIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teamIds);
}

 final  List<int> _resultOrder;
@override List<int> get resultOrder {
  if (_resultOrder is EqualUnmodifiableListView) return _resultOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resultOrder);
}

@override final  DateTime generatedAt;

/// Create a copy of AmidaResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmidaResultCopyWith<_AmidaResult> get copyWith => __$AmidaResultCopyWithImpl<_AmidaResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmidaResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmidaResult&&const DeepCollectionEquality().equals(other._teamIds, _teamIds)&&const DeepCollectionEquality().equals(other._resultOrder, _resultOrder)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_teamIds),const DeepCollectionEquality().hash(_resultOrder),generatedAt);

@override
String toString() {
  return 'AmidaResult(teamIds: $teamIds, resultOrder: $resultOrder, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$AmidaResultCopyWith<$Res> implements $AmidaResultCopyWith<$Res> {
  factory _$AmidaResultCopyWith(_AmidaResult value, $Res Function(_AmidaResult) _then) = __$AmidaResultCopyWithImpl;
@override @useResult
$Res call({
 List<String> teamIds, List<int> resultOrder, DateTime generatedAt
});




}
/// @nodoc
class __$AmidaResultCopyWithImpl<$Res>
    implements _$AmidaResultCopyWith<$Res> {
  __$AmidaResultCopyWithImpl(this._self, this._then);

  final _AmidaResult _self;
  final $Res Function(_AmidaResult) _then;

/// Create a copy of AmidaResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamIds = null,Object? resultOrder = null,Object? generatedAt = null,}) {
  return _then(_AmidaResult(
teamIds: null == teamIds ? _self._teamIds : teamIds // ignore: cast_nullable_to_non_nullable
as List<String>,resultOrder: null == resultOrder ? _self._resultOrder : resultOrder // ignore: cast_nullable_to_non_nullable
as List<int>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
