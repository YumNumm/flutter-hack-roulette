// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'environments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Environments _$EnvironmentsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_Environments',
  json,
  ($checkedConvert) {
    final val = _Environments(
      flavor: $checkedConvert('flavor', (v) => $enumDecode(_$FlavorEnumMap, v)),
      appIdSuffix: $checkedConvert('app_id_suffix', (v) => v as String),
      appName: $checkedConvert('app_name', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'appIdSuffix': 'app_id_suffix', 'appName': 'app_name'},
);

Map<String, dynamic> _$EnvironmentsToJson(_Environments instance) =>
    <String, dynamic>{
      'flavor': _$FlavorEnumMap[instance.flavor]!,
      'app_id_suffix': instance.appIdSuffix,
      'app_name': instance.appName,
    };

const _$FlavorEnumMap = {Flavor.dev: 'dev', Flavor.prod: 'prod'};
