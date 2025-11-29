// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'presentation_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresentationState _$PresentationStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PresentationState', json, ($checkedConvert) {
      final val = _PresentationState(
        currentIndex: $checkedConvert(
          'current_index',
          (v) => (v as num).toInt(),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$PresentationStatusEnumMap, v),
        ),
      );
      return val;
    }, fieldKeyMap: const {'currentIndex': 'current_index'});

Map<String, dynamic> _$PresentationStateToJson(_PresentationState instance) =>
    <String, dynamic>{
      'current_index': instance.currentIndex,
      'status': _$PresentationStatusEnumMap[instance.status]!,
    };

const _$PresentationStatusEnumMap = {
  PresentationStatus.notStarted: 'notStarted',
  PresentationStatus.presenting: 'presenting',
  PresentationStatus.completed: 'completed',
};
