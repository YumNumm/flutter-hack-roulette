import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'roulette_state.freezed.dart';

enum RouletteStatus { idle, spinning, stopping, stopped }

@freezed
abstract class RouletteState with _$RouletteState {
  const factory RouletteState({
    @Default(RouletteStatus.idle) RouletteStatus status,
    // Dashくんの2D位置（円の内部の座標、正規化: -1〜1の範囲）
    @Default(Offset.zero) Offset dashPosition,
    // Dashくんの2D速度ベクトル
    @Default(Offset.zero) Offset dashVelocity,
    // Dashくんの向き（Y軸回転、ラジアン）- 移動方向を向く
    @Default(0.0) double dashHeading,
    // Dashくんの転がり回転角度（X軸回転、ラジアン）- 移動距離に応じて累積
    @Default(0.0) double dashRollAngle,
    // 選択されたチームのインデックス
    int? selectedTeamIndex,
  }) = _RouletteState;
}
