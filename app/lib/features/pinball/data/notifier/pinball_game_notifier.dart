import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/features/pinball/data/model/game_state.dart';

part 'pinball_game_notifier.g.dart';

@riverpod
class PinballGameNotifier extends _$PinballGameNotifier {
  Timer? _gameTimer;

  @override
  GameState build() {
    ref.onDispose(() {
      _gameTimer?.cancel();
    });

    return const GameState();
  }

  void startGame(int teamIndex) {
    state = state.copyWith(
      status: GameStatus.ready,
      currentTeamIndex: teamIndex,
    );
  }

  void launchBall() {
    if (state.status != GameStatus.ready) {
      return;
    }

    state = state.copyWith(status: GameStatus.ballLaunched);

    // ゲーム更新ループを開始（物理演算用）
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(
      const Duration(milliseconds: 16), // ~60 FPS
      (_) {
        _updateGame();
      },
    );
  }

  void _updateGame() {
    // 物理演算の更新はここで行う
    // 実際の実装は3Dシーン側で処理
  }

  void setFlipperLeft({required bool active}) {
    state = state.copyWith(isFlipperLeftActive: active);
  }

  void setFlipperRight({required bool active}) {
    state = state.copyWith(isFlipperRightActive: active);
  }

  void onBallInHole(int holeNumber) {
    state = state.copyWith(
      status: GameStatus.ballInHole,
      lastHoleNumber: holeNumber,
    );

    _gameTimer?.cancel();
  }

  void nextTeam() {
    final currentIndex = state.currentTeamIndex;
    if (currentIndex == null) {
      return;
    }

    state = const GameState();
  }

  void finishGame() {
    state = state.copyWith(status: GameStatus.finished);
    _gameTimer?.cancel();
  }

  void reset() {
    _gameTimer?.cancel();
    state = const GameState();
  }
}
