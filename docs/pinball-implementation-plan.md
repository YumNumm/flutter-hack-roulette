# 3Dピンボール抽選システム（Dashくん版）実装プラン

**最終更新**: 2025-11-29
**ステータス**: 実装開始

## 概要

three_jsを使った本格的な3Dピンボールゲームを実装します。通常のボールの代わりにFlutterのマスコット「Dashくん」の3Dモデルを使用し、各チームがプレイして穴に落ちた番号で登壇順を決定します。

## 技術スタック

- **3D描画**: three_js（Three.js Dartポート）
- **物理エンジン**: three_js_cannon（Cannon.js物理エンジン）
- **3Dモデル**: Dashくんの3DモデルをGLB/glTF形式で使用
- **状態管理**: Riverpod + flutter_hooks
- **データモデル**: freezed
- **永続化**: SharedPreferences

## 実装進捗

### Phase 1: プロジェクトのクリーンアップと準備

- [ ] 既存コードの削除（`lib/features/dice/`と`lib/features/amida/`）
- [ ] 不要なパッケージの削除（`flutter_scene`、`flutter_shaders`）
- [ ] `three_js`、`three_js_cannon`、`three_js_simple_loaders`の追加
- [ ] Dashくんの3DモデルをGLB/glTF形式で準備
- [ ] `assets/models/dash.glb`に配置
- [ ] `pubspec.yaml`のassetsに追加

### Phase 2: データモデルの実装

- [ ] `lib/features/pinball/data/model/team.dart` - Teamモデル作成
- [ ] `lib/features/pinball/data/model/pinball_result.dart` - PinballResultモデル作成
- [ ] `lib/features/pinball/data/model/game_state.dart` - GameStateモデル作成
- [ ] `build_runner`でコード生成

### Phase 3: リポジトリとNotifierの実装

- [ ] `lib/features/pinball/data/repository/team_repository.dart` - TeamRepository実装
- [ ] `lib/features/pinball/data/repository/result_repository.dart` - ResultRepository実装
- [ ] `lib/features/pinball/data/notifier/team_notifier.dart` - TeamNotifier実装
- [ ] `lib/features/pinball/data/notifier/pinball_game_notifier.dart` - PinballGameNotifier実装

### Phase 4: 物理エンジンの実装

- [ ] `lib/features/pinball/data/service/pinball_physics.dart` - Cannon.js統合
- [ ] Dashくんの物理ボディ（球体コライダー）実装
- [ ] フリッパーの物理ボディ（HingeConstraint）実装
- [ ] 壁・バンパー・穴の衝突判定実装

### Phase 5: 3Dシーンの実装

- [ ] `lib/features/pinball/ui/components/pinball_table_3d.dart` - 基本シーン作成
- [ ] Scene、Camera、Rendererのセットアップ
- [ ] ライティング（DirectionalLight、AmbientLight）
- [ ] ピンボール台のジオメトリ作成
- [ ] 壁・バンパー・フリッパーのメッシュ作成
- [ ] 穴（チーム数に応じて1-N個）の配置

### Phase 6: Dashくんの3Dモデル統合

- [ ] `lib/features/pinball/data/service/dash_model_loader.dart` - GLTFLoader実装
- [ ] Dashくんのモデル読み込み
- [ ] スケール調整
- [ ] 物理ボディと3Dメッシュの同期処理

### Phase 7: ゲームロジックの実装

- [ ] ボール発射機構の実装
- [ ] フリッパー制御ロジックの実装
- [ ] 穴判定ロジックの実装
- [ ] ゲームフロー管理（チーム切り替え、結果記録）
- [ ] パーティクルエフェクト（穴に入った時）

### Phase 8: UI実装

- [ ] `lib/features/pinball/ui/page/team_management_page.dart` - チーム管理画面
- [ ] `lib/features/pinball/ui/page/pinball_game_page.dart` - ピンボールゲーム画面
- [ ] `lib/features/pinball/ui/page/result_page.dart` - 結果画面
- [ ] `lib/features/pinball/ui/components/flipper_controls.dart` - フリッパーコントロール
- [ ] `lib/features/pinball/ui/components/score_board.dart` - スコアボード

### Phase 9: ルーティング設定

- [ ] `lib/core/router/routes/main.dart`にルート追加
  - `/` - チーム管理画面
  - `/pinball` - ピンボールゲーム画面
  - `/result` - 結果画面

### Phase 10: ビジュアル調整と最適化

- [ ] マテリアルとテクスチャの適用
- [ ] エフェクトとアニメーションの追加
- [ ] パフォーマンス最適化（60 FPS維持）
- [ ] エラーハンドリング
- [ ] 最終動作確認

## アーキテクチャ

```
lib/features/pinball/
├── data/
│   ├── model/
│   │   ├── team.dart
│   │   ├── pinball_result.dart
│   │   └── game_state.dart
│   ├── repository/
│   │   ├── team_repository.dart
│   │   └── result_repository.dart
│   ├── notifier/
│   │   ├── team_notifier.dart
│   │   └── pinball_game_notifier.dart
│   └── service/
│       ├── pinball_physics.dart
│       └── dash_model_loader.dart
└── ui/
    ├── page/
    │   ├── team_management_page.dart
    │   ├── pinball_game_page.dart
    │   └── result_page.dart
    └── components/
        ├── pinball_table_3d.dart
        ├── flipper_controls.dart
        └── score_board.dart
```

## データモデル設計

### Team
```dart
@freezed
abstract class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    int? holeNumber,           // 落ちた穴の番号
    int? presentationOrder,    // 最終的な登壇順
  }) = _Team;
}
```

### PinballResult
```dart
@freezed
abstract class PinballResult with _$PinballResult {
  const factory PinballResult({
    required String teamId,
    required int holeNumber,
    required DateTime timestamp,
  }) = _PinballResult;
}
```

### GameState
```dart
enum GameStatus { waiting, playing, ballLaunched, finished }

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    @Default(GameStatus.waiting) GameStatus status,
    int? currentTeamIndex,
    // Dashくんの物理状態
  }) = _GameState;
}
```

## 期待される動作フロー

1. **チーム管理画面**
   - チームを追加・削除
   - ゲーム開始ボタンをタップ

2. **ピンボールゲーム画面**
   - Dashくんが発射位置に配置される
   - 発射ボタンでDashくんが転がり始める
   - 左右のフリッパーボタンで操作
   - バンパーに当たって跳ね返る
   - 穴に落ちると番号が記録される
   - 次のチームに自動切り替え

3. **結果画面**
   - 全チームの結果を表示
   - 穴番号順に登壇順を表示

## 主要な技術実装メモ

### three_js基本セットアップ
```dart
import 'package:three_js/three_js.dart' as three;

final scene = three.Scene();
final camera = three.PerspectiveCamera(75, aspectRatio, 0.1, 1000);
final renderer = three.WebGLRenderer();
```

### Cannon.js物理エンジン
```dart
import 'package:three_js_cannon/three_js_cannon.dart' as cannon;

final world = cannon.World();
world.gravity.set(0, -9.82, 0);

// Dashくんの物理ボディ
final dashShape = cannon.Sphere(0.5);
final dashBody = cannon.Body(mass: 1, shape: dashShape);
world.addBody(dashBody);
```

### フリッパーのHingeConstraint
```dart
final constraint = cannon.HingeConstraint(
  flipperBody,
  tableBody,
  pivotA: Vector3(0, 0, 0),
  axisA: Vector3(0, 1, 0),
);
constraint.enableMotor();
```

## 参考リソース

- [three_js GitHub Examples](https://github.com/Knightro63/three_js/tree/main/examples)
- [three_js pub.dev](https://pub.dev/packages/three_js)
- three_js_cannon（物理エンジンアドオン）
- three_js_simple_loaders（GLB/glTFローダー）

## 課題と検討事項

- [ ] Dashくんの3Dモデルの入手方法
- [ ] 物理演算の調整（反発係数、摩擦係数）
- [ ] カメラワークの最適化
- [ ] パフォーマンス（特にモバイルデバイス）

## 変更履歴

- 2025-11-29: 初版作成
