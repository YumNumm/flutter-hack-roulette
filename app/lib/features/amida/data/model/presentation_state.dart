import 'package:freezed_annotation/freezed_annotation.dart';

part 'presentation_state.freezed.dart';
part 'presentation_state.g.dart';

@freezed
abstract class PresentationState with _$PresentationState {
  const factory PresentationState({
    required int currentIndex,
    required PresentationStatus status,
  }) = _PresentationState;

  factory PresentationState.fromJson(Map<String, dynamic> json) =>
      _$PresentationStateFromJson(json);

  static const initial = PresentationState(
    currentIndex: -1,
    status: PresentationStatus.notStarted,
  );
}

enum PresentationStatus {
  notStarted,
  presenting,
  completed,
}
