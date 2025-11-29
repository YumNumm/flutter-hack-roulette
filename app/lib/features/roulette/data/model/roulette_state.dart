import 'package:freezed_annotation/freezed_annotation.dart';

part 'roulette_state.freezed.dart';

enum RouletteStatus { idle, spinning, stopping, stopped }

@freezed
abstract class RouletteState with _$RouletteState {
  const factory RouletteState({
    @Default(RouletteStatus.idle) RouletteStatus status,
    @Default(0.0) double rotation,
    @Default(0.0) double rotationVelocity,
    int? selectedTeamIndex,
  }) = _RouletteState;
}
