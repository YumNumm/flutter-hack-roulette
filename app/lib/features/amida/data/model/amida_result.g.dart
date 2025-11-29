// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'amida_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AmidaResult _$AmidaResultFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_AmidaResult',
  json,
  ($checkedConvert) {
    final val = _AmidaResult(
      teamIds: $checkedConvert(
        'team_ids',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      resultOrder: $checkedConvert(
        'result_order',
        (v) => (v as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      ),
      generatedAt: $checkedConvert(
        'generated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'teamIds': 'team_ids',
    'resultOrder': 'result_order',
    'generatedAt': 'generated_at',
  },
);

Map<String, dynamic> _$AmidaResultToJson(_AmidaResult instance) =>
    <String, dynamic>{
      'team_ids': instance.teamIds,
      'result_order': instance.resultOrder,
      'generated_at': instance.generatedAt.toIso8601String(),
    };
