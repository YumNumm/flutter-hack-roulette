import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/features/pinball/data/model/game_state.dart';
import 'package:roulette/features/pinball/data/notifier/pinball_game_notifier.dart';
import 'package:three_js/three_js.dart' as three;

/// 3Dピンボールテーブルコンポーネント
class PinballTable3D extends HookConsumerWidget {
  const PinballTable3D({
    required this.onHoleDetected,
    super.key,
  });

  final void Function(int holeNumber) onHoleDetected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sceneController = useMemoized(
      () => _PinballSceneController(onHoleDetected),
    );
    final gameState = ref.watch(pinballGameProvider);

    useEffect(
      () {
        return sceneController.dispose;
      },
      [],
    );

    // ゲーム状態の変更を監視
    useEffect(
      () {
        if (gameState.status == GameStatus.ballLaunched &&
            !sceneController.isBallLaunched) {
          sceneController.launchBall();
        }

        sceneController.setFlipperStates(
          leftActive: gameState.isFlipperLeftActive,
          rightActive: gameState.isFlipperRightActive,
        );

        return null;
      },
      [gameState],
    );

    return Stack(
      children: [
        sceneController.threeJs.build(),
        // デバッグ情報
        if (sceneController.isBallLaunched)
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black54,
              child: Text(
                'Ball: (${sceneController.ballPosX.toStringAsFixed(1)}, '
                '${sceneController.ballPosY.toStringAsFixed(1)}, '
                '${sceneController.ballPosZ.toStringAsFixed(1)})',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}

/// ピンボールシーンのコントローラー
class _PinballSceneController {
  _PinballSceneController(this.onHoleDetected) {
    threeJs = three.ThreeJS(
      onSetupComplete: () {
        // セットアップ完了後、アニメーションループを開始
        _startAnimationLoop();
      },
      setup: setup,
      settings: three.Settings(),
    );
  }

  final void Function(int) onHoleDetected;
  late three.ThreeJS threeJs;

  late three.Mesh ball;
  late three.Mesh leftFlipper;
  late three.Mesh rightFlipper;

  final List<_Hole> holes = [];

  // ボールの物理パラメータ
  double ballPosX = 0;
  double ballPosY = 2;
  double ballPosZ = 0;
  double ballVelX = 0;
  double ballVelY = 0;
  double ballVelZ = 0;

  final gravity = -15.0; // 重力加速度
  final tableWidth = 12.0;
  final tableLength = 20.0;
  final ballRadius = 0.4;

  bool isBallLaunched = false;
  bool isFlipperLeftActive = false;
  bool isFlipperRightActive = false;

  double leftFlipperAngle = 0;
  double rightFlipperAngle = 0;
  final flipperSpeed = 5.0;
  final double maxFlipperAngle = math.pi / 3; // 60度

  Timer? _animationTimer;
  bool _disposed = false;

  Future<void> setup() async {
    // Camera
    threeJs.camera = three.PerspectiveCamera(
      60,
      threeJs.width / threeJs.height,
      0.1,
      1000,
    );
    threeJs.camera.position.setValues(0, 15, 15);

    // Scene
    threeJs.scene = three.Scene();
    threeJs.scene.background = three.Color.fromHex32(0x1a1a2e);

    // カメラをシーンに追加（ライトがカメラの子要素なので重要）
    threeJs.scene.add(threeJs.camera);

    // Lights
    final ambientLight = three.AmbientLight(0xffffff, 0.6);
    threeJs.scene.add(ambientLight);

    final directionalLight = three.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.setValues(5, 10, 5);
    directionalLight.castShadow = true;
    threeJs.scene.add(directionalLight);

    final pointLight = three.PointLight(0x00ffff, 1.0, 50);
    pointLight.position.setValues(0, 5, -8);
    threeJs.camera.add(pointLight);

    _createTable();
    _createBall();
    _createFlippers();
    _createHoles(6); // 6つの穴を作成
    _createBumpers();
  }

  void _startAnimationLoop() {
    _animationTimer = Timer.periodic(
      const Duration(milliseconds: 16), // ~60 FPS
      (_) => _update(),
    );
  }

  void _createTable() {
    // テーブル本体（傾斜あり）
    final tableGeometry = three.BoxGeometry(tableWidth, 0.5, tableLength);
    final tableMaterial = three.MeshPhongMaterial.fromMap({
      'color': 0x2d3561,
      'specular': 0x111111,
      'shininess': 30,
    });
    final table = three.Mesh(tableGeometry, tableMaterial);
    table.position.setValues(0, 0, 0);
    table.rotation.x = 0.1; // 約5.7度の傾斜
    table.receiveShadow = true;
    threeJs.scene.add(table);

    // テーブルの枠
    final frameGeometry = three.BoxGeometry(tableWidth + 0.5, 1, 0.3);
    final frameMaterial = three.MeshPhongMaterial.fromMap({'color': 0x8b4513});

    // 上端
    final topFrame = three.Mesh(frameGeometry, frameMaterial);
    topFrame.position.setValues(0, 0.5, -tableLength / 2);
    threeJs.scene.add(topFrame);

    // 下端
    final bottomFrame = three.Mesh(frameGeometry, frameMaterial);
    bottomFrame.position.setValues(0, 0.5, tableLength / 2);
    threeJs.scene.add(bottomFrame);

    // 側面
    final sideFrameGeometry = three.BoxGeometry(0.3, 1, tableLength);
    final leftFrame = three.Mesh(sideFrameGeometry, frameMaterial);
    leftFrame.position.setValues(-tableWidth / 2, 0.5, 0);
    threeJs.scene.add(leftFrame);

    final rightFrame = three.Mesh(sideFrameGeometry, frameMaterial);
    rightFrame.position.setValues(tableWidth / 2, 0.5, 0);
    threeJs.scene.add(rightFrame);
  }

  void _createBall() {
    final ballGeometry = three.SphereGeometry(ballRadius, 32, 32);
    final ballMaterial = three.MeshPhongMaterial.fromMap({
      'color': 0x00ff88,
      'emissive': 0x004422,
      'shininess': 100,
    });
    ball = three.Mesh(ballGeometry, ballMaterial);

    // 初期位置
    ballPosX = tableWidth / 2 - 1.5;
    ballPosY = 2;
    ballPosZ = -tableLength / 2 + 3;
    ball.position.setValues(ballPosX, ballPosY, ballPosZ);
    ball.castShadow = true;
    threeJs.scene.add(ball);
  }

  void _createFlippers() {
    final flipperGeometry = three.BoxGeometry(2, 0.3, 0.5);
    final flipperMaterial = three.MeshPhongMaterial.fromMap({
      'color': 0xff6b6b,
      'emissive': 0x440000,
    });

    // 左フリッパー
    leftFlipper = three.Mesh(flipperGeometry, flipperMaterial);
    leftFlipper.position.setValues(-2, 0.5, tableLength / 2 - 3);
    leftFlipper.castShadow = true;
    threeJs.scene.add(leftFlipper);

    // 右フリッパー
    rightFlipper = three.Mesh(flipperGeometry, flipperMaterial);
    rightFlipper.position.setValues(2, 0.5, tableLength / 2 - 3);
    rightFlipper.castShadow = true;
    threeJs.scene.add(rightFlipper);
  }

  void _createHoles(int count) {
    const holeRadius = 0.8;
    final holeGeometry = three.CylinderGeometry(
      holeRadius,
      holeRadius,
      0.2,
      32,
    );
    final holeMaterial = three.MeshPhongMaterial.fromMap({
      'color': 0x000000,
      'emissive': 0x0066ff,
    });

    // 穴を下部に配置
    final startX = -tableWidth / 2 + 2;
    final spacing = (tableWidth - 4) / (count - 1);
    final z = tableLength / 2 - 2;

    for (var i = 0; i < count; i++) {
      final holeMesh = three.Mesh(holeGeometry, holeMaterial);
      final x = startX + (spacing * i);
      holeMesh.position.setValues(x, 0.3, z);
      holeMesh.rotation.x = math.pi / 2;
      threeJs.scene.add(holeMesh);

      // 番号をテキストで表示するメッシュ（簡易版）
      final numberGeometry = three.SphereGeometry(0.2, 16, 16);
      final numberMaterial = three.MeshPhongMaterial.fromMap({
        'color': 0xffffff,
        'emissive': 0x666666,
      });
      final numberMesh = three.Mesh(numberGeometry, numberMaterial);
      numberMesh.position.setValues(x, 0.6, z);
      threeJs.scene.add(numberMesh);

      holes.add(
        _Hole(
          number: i + 1,
          x: x,
          y: 0,
          z: z,
          radius: holeRadius,
        ),
      );
    }
  }

  void _createBumpers() {
    final bumperGeometry = three.CylinderGeometry(0.5, 0.5, 1, 16);
    final bumperMaterial = three.MeshPhongMaterial.fromMap({
      'color': 0xffaa00,
      'emissive': 0x664400,
    });

    // バンパーを中央に配置
    final bumperPositions = [
      [-3.0, 0.5, -3.0],
      [3.0, 0.5, -3.0],
      [0.0, 0.5, 0.0],
      [-3.0, 0.5, 3.0],
      [3.0, 0.5, 3.0],
    ];

    for (final pos in bumperPositions) {
      final bumper = three.Mesh(bumperGeometry, bumperMaterial);
      bumper.position.setValues(pos[0], pos[1], pos[2]);
      bumper.castShadow = true;
      threeJs.scene.add(bumper);
    }
  }

  void launchBall() {
    if (isBallLaunched) {
      return;
    }

    isBallLaunched = true;
    // 発射速度
    ballVelX = -8 + (math.Random().nextDouble() * 4 - 2);
    ballVelY = 0;
    ballVelZ = 12;
  }

  void setFlipperStates({required bool leftActive, required bool rightActive}) {
    isFlipperLeftActive = leftActive;
    isFlipperRightActive = rightActive;
  }

  void _update() {
    if (_disposed) {
      return;
    }

    const deltaTime = 0.016; // 16ms

    if (isBallLaunched) {
      // 重力適用
      ballVelY += gravity * deltaTime;

      // ボール移動
      ballPosX += ballVelX * deltaTime;
      ballPosY += ballVelY * deltaTime;
      ballPosZ += ballVelZ * deltaTime;

      // テーブル境界チェック
      if (ballPosX < -tableWidth / 2 + ballRadius) {
        ballPosX = -tableWidth / 2 + ballRadius;
        ballVelX = -ballVelX * 0.8; // 反発係数
      }
      if (ballPosX > tableWidth / 2 - ballRadius) {
        ballPosX = tableWidth / 2 - ballRadius;
        ballVelX = -ballVelX * 0.8;
      }

      // テーブル上面チェック
      if (ballPosY < 0.5 + ballRadius) {
        ballPosY = 0.5 + ballRadius;
        ballVelY = -ballVelY * 0.6;

        // 摩擦
        ballVelX *= 0.98;
        ballVelZ *= 0.98;
      }

      // 上端チェック
      if (ballPosZ < -tableLength / 2 + ballRadius) {
        ballPosZ = -tableLength / 2 + ballRadius;
        ballVelZ = -ballVelZ * 0.8;
      }

      // ボール位置更新
      ball.position.setValues(ballPosX, ballPosY, ballPosZ);

      // フリッパーとの衝突チェック
      _checkFlipperCollision();

      // 穴判定
      _checkHoleCollision();

      // ボールの回転
      ball.rotation.x += ballVelZ * deltaTime;
      ball.rotation.z -= ballVelX * deltaTime;
    }

    // フリッパーアニメーション
    _updateFlippers(deltaTime);
  }

  void _updateFlippers(double deltaTime) {
    // 左フリッパー
    if (isFlipperLeftActive) {
      leftFlipperAngle = (leftFlipperAngle + flipperSpeed * deltaTime).clamp(
        0.0,
        maxFlipperAngle,
      );
    } else {
      leftFlipperAngle = (leftFlipperAngle - flipperSpeed * deltaTime).clamp(
        0.0,
        maxFlipperAngle,
      );
    }
    leftFlipper.rotation.y = leftFlipperAngle;

    // 右フリッパー
    if (isFlipperRightActive) {
      rightFlipperAngle = (rightFlipperAngle - flipperSpeed * deltaTime).clamp(
        -maxFlipperAngle,
        0.0,
      );
    } else {
      rightFlipperAngle = (rightFlipperAngle + flipperSpeed * deltaTime).clamp(
        -maxFlipperAngle,
        0.0,
      );
    }
    rightFlipper.rotation.y = rightFlipperAngle;
  }

  void _checkFlipperCollision() {
    // 簡易的な衝突判定
    // 左フリッパー
    final leftFlipperPos = leftFlipper.position;
    if (_isNearFlipper(leftFlipperPos) && isFlipperLeftActive) {
      ballVelZ = -15; // 跳ね返す
      ballVelX += -5;
    }

    // 右フリッパー
    final rightFlipperPos = rightFlipper.position;
    if (_isNearFlipper(rightFlipperPos) && isFlipperRightActive) {
      ballVelZ = -15;
      ballVelX += 5;
    }
  }

  bool _isNearFlipper(three.Vector3 flipperPos) {
    final dx = ballPosX - flipperPos.x;
    final dz = ballPosZ - flipperPos.z;
    final distance = math.sqrt(dx * dx + dz * dz);
    return distance < 2.0 && ballPosY < 1.5;
  }

  void _checkHoleCollision() {
    for (final hole in holes) {
      final dx = ballPosX - hole.x;
      final dz = ballPosZ - hole.z;
      final distance = math.sqrt(dx * dx + dz * dz);

      if (distance < hole.radius && ballPosY < 1.0) {
        // 穴に入った！
        onHoleDetected(hole.number);
        isBallLaunched = false;
        // ボールをリセット
        ballPosX = tableWidth / 2 - 1.5;
        ballPosY = 2;
        ballPosZ = -tableLength / 2 + 3;
        ball.position.setValues(ballPosX, ballPosY, ballPosZ);
        ballVelX = 0;
        ballVelY = 0;
        ballVelZ = 0;
        break;
      }
    }
  }

  void dispose() {
    _disposed = true;
    _animationTimer?.cancel();
    threeJs.dispose();
  }
}

class _Hole {
  _Hole({
    required this.number,
    required this.x,
    required this.y,
    required this.z,
    required this.radius,
  });

  final int number;
  final double x;
  final double y;
  final double z;
  final double radius;
}
