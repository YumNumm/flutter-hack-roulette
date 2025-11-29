import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

enum GameStatus {
  waiting, // ゲーム開始待ち
  ready, // 発射準備完了
  ballLaunched, // ボール（Dash）発射済み
  ballInHole, // 穴に入った
  finished, // ゲーム終了
}

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    @Default(GameStatus.waiting) GameStatus status,
    int? currentTeamIndex,
    @Default(false) bool isFlipperLeftActive,
    @Default(false) bool isFlipperRightActive,
    int? lastHoleNumber,
  }) = _GameState;
}


