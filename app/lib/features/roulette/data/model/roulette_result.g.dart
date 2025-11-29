// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'roulette_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RouletteResult _$RouletteResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_RouletteResult',
      json,
      ($checkedConvert) {
        final val = _RouletteResult(
          teamId: $checkedConvert('team_id', (v) => v as String),
          selectedOrder: $checkedConvert(
            'selected_order',
            (v) => (v as num).toInt(),
          ),
          timestamp: $checkedConvert(
            'timestamp',
            (v) => DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'teamId': 'team_id',
        'selectedOrder': 'selected_order',
      },
    );

Map<String, dynamic> _$RouletteResultToJson(_RouletteResult instance) =>
    <String, dynamic>{
      'team_id': instance.teamId,
      'selected_order': instance.selectedOrder,
      'timestamp': instance.timestamp.toIso8601String(),
    };
