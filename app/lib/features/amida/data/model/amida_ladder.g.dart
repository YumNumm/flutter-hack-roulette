// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'amida_ladder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AmidaLadder _$AmidaLadderFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_AmidaLadder',
  json,
  ($checkedConvert) {
    final val = _AmidaLadder(
      teamCount: $checkedConvert('team_count', (v) => (v as num).toInt()),
      horizontalLines: $checkedConvert(
        'horizontal_lines',
        (v) => (v as List<dynamic>)
            .map((e) => HorizontalLine.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'teamCount': 'team_count',
    'horizontalLines': 'horizontal_lines',
  },
);

Map<String, dynamic> _$AmidaLadderToJson(_AmidaLadder instance) =>
    <String, dynamic>{
      'team_count': instance.teamCount,
      'horizontal_lines': instance.horizontalLines,
    };

_HorizontalLine _$HorizontalLineFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_HorizontalLine',
      json,
      ($checkedConvert) {
        final val = _HorizontalLine(
          leftIndex: $checkedConvert('left_index', (v) => (v as num).toInt()),
          rightIndex: $checkedConvert('right_index', (v) => (v as num).toInt()),
          yPosition: $checkedConvert(
            'y_position',
            (v) => (v as num).toDouble(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'leftIndex': 'left_index',
        'rightIndex': 'right_index',
        'yPosition': 'y_position',
      },
    );

Map<String, dynamic> _$HorizontalLineToJson(_HorizontalLine instance) =>
    <String, dynamic>{
      'left_index': instance.leftIndex,
      'right_index': instance.rightIndex,
      'y_position': instance.yPosition,
    };
