// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'pinball_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PinballResult _$PinballResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_PinballResult',
      json,
      ($checkedConvert) {
        final val = _PinballResult(
          teamId: $checkedConvert('team_id', (v) => v as String),
          holeNumber: $checkedConvert('hole_number', (v) => (v as num).toInt()),
          timestamp: $checkedConvert(
            'timestamp',
            (v) => DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'teamId': 'team_id', 'holeNumber': 'hole_number'},
    );

Map<String, dynamic> _$PinballResultToJson(_PinballResult instance) =>
    <String, dynamic>{
      'team_id': instance.teamId,
      'hole_number': instance.holeNumber,
      'timestamp': instance.timestamp.toIso8601String(),
    };
