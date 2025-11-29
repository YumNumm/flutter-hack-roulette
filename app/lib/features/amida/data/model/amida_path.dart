import 'package:freezed_annotation/freezed_annotation.dart';

part 'amida_path.freezed.dart';

@freezed
class AmidaPath with _$AmidaPath {
  const factory AmidaPath({
    required int startIndex,
    required int endIndex,
    required List<PathPoint> points,
  }) = _AmidaPath;
}

@freezed
class PathPoint with _$PathPoint {
  const factory PathPoint({
    required int columnIndex,
    required double yPosition,
  }) = _PathPoint;
}

