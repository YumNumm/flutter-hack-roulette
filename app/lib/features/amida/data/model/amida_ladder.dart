import 'package:freezed_annotation/freezed_annotation.dart';

part 'amida_ladder.freezed.dart';
part 'amida_ladder.g.dart';

@freezed
abstract class AmidaLadder with _$AmidaLadder {
  const factory AmidaLadder({
    required int teamCount,
    required List<HorizontalLine> horizontalLines,
  }) = _AmidaLadder;

  factory AmidaLadder.fromJson(Map<String, dynamic> json) =>
      _$AmidaLadderFromJson(json);
}

@freezed
abstract class HorizontalLine with _$HorizontalLine {
  const factory HorizontalLine({
    required int leftIndex,
    required int rightIndex,
    required double yPosition,
  }) = _HorizontalLine;

  factory HorizontalLine.fromJson(Map<String, dynamic> json) =>
      _$HorizontalLineFromJson(json);
}
