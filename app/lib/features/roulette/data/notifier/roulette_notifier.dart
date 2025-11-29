import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template/features/roulette/data/model/roulette_state.dart';

part 'roulette_notifier.g.dart';

@riverpod
class RouletteNotifier extends _$RouletteNotifier {
  @override
  RouletteState build() {
    return const RouletteState();
  }

  void startSpin(int teamCount) {
    if (state.status != RouletteStatus.idle) {
      return;
    }

    final random = Random();
    final initialVelocity = 8.0 + random.nextDouble() * 7.0;

    state = state.copyWith(
      status: RouletteStatus.spinning,
      rotationVelocity: initialVelocity,
    );
  }

  void updateRotation(double deltaTime) {
    if (state.status == RouletteStatus.spinning ||
        state.status == RouletteStatus.stopping) {
      final decayFactor = state.status == RouletteStatus.spinning
          ? 0.985
          : 0.95;
      final velocity = state.rotationVelocity * decayFactor;
      final newRotation = state.rotation + velocity * deltaTime;

      if (velocity < 0.05) {
        state = state.copyWith(
          status: RouletteStatus.stopped,
          rotationVelocity: 0,
          rotation: newRotation,
        );
      } else {
        state = state.copyWith(
          rotationVelocity: velocity,
          rotation: newRotation,
        );
      }
    }
  }

  void setSelectedTeam(int teamIndex) {
    state = state.copyWith(selectedTeamIndex: teamIndex);
  }

  void reset() {
    state = const RouletteState();
  }

  void startStopping() {
    if (state.status == RouletteStatus.spinning) {
      state = state.copyWith(status: RouletteStatus.stopping);
    }
  }

  int calculateSelectedIndex(int teamCount) {
    if (teamCount == 0) {
      return -1;
    }
    final normalizedRotation = state.rotation % (2 * pi);
    final segmentAngle = (2 * pi) / teamCount;
    final index = ((normalizedRotation / segmentAngle).floor()) % teamCount;
    return index;
  }
}
