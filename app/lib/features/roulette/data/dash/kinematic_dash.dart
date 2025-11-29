import 'dart:math';

import 'package:flutter/physics.dart';
import 'package:flutter_scene/scene.dart';
import 'package:vector_math/vector_math.dart';

class KinematicDash {
  KinematicDash(this._node) {
    walkAnimation = _node.createAnimationClip(
      _node.findAnimationByName('Walk')!,
    );
    runAnimation = _node.createAnimationClip(
      _node.findAnimationByName('Run')!,
    );
    blinkAnimation = _node.createAnimationClip(
      _node.findAnimationByName('Idle')!,
    );
  }

  final Node _node;

  late final AnimationClip walkAnimation;
  late final AnimationClip runAnimation;
  late final AnimationClip blinkAnimation;

  /* ############# State ############# */
  var _position = Vector3.zero();
  Vector3 get position => _position;

  var _direction = Vector3(0, 1, 1);

  /// ルーレットが動作中かどうか
  var _isRunning = false;
  bool get isRunning => _isRunning;

  /// 摩擦シミュレーション（X軸・Y軸）
  FrictionSimulation? _simulationX;
  FrictionSimulation? _simulationY;

  /// シミュレーション開始からの経過時間
  var _elapsedTime = 0.0;

  /// 摩擦係数（drag coefficient）
  static const _drag = 0.5;

  /// 境界の半径（外部から設定）
  int boundaryRadius = 3;

  /// 現在の速度の大きさ
  double get speed {
    if (_simulationX == null || _simulationY == null) return 0;
    final vx = _simulationX!.dx(_elapsedTime);
    final vy = _simulationY!.dx(_elapsedTime);
    return Vector2(vx, vy).length;
  }

  void updateNode() {
    final transform =
        (Matrix4.translation(_position) *
                Matrix4.rotationY(
                  Vector3(0, 0, 1).angleToSigned(_direction, Vector3(0, 1, 0)),
                ))
            as Matrix4;

    final currentSpeed = speed;
    walkAnimation.playing = false;
    walkAnimation.loop = false;
    walkAnimation.weight = 1;

    runAnimation.playing = _isRunning && currentSpeed > 0.01;
    runAnimation.loop = true;
    runAnimation.weight = 1;
    runAnimation.playbackTimeScale = currentSpeed * 2;
    blinkAnimation.playing = true;
    blinkAnimation.loop = true;
    blinkAnimation.weight = 1;
    blinkAnimation.playbackTimeScale = 1.2;

    _node.globalTransform = transform;
  }

  /// フリック速度を受け取ってルーレットを開始
  void start(Vector2 velocityXY) {
    // FrictionSimulationを作成（初期位置0、初期速度はフリック速度）
    _simulationX = FrictionSimulation(_drag, 0, velocityXY.x);
    _simulationY = FrictionSimulation(_drag, 0, velocityXY.y);
    _elapsedTime = 0;

    if (velocityXY.length > 0) {
      _direction = Vector3(velocityXY.x, 0, velocityXY.y);
      _direction.normalize();
    }

    _isRunning = true;
    _position = Vector3.zero();
    print('🚀 Started! velocity=$velocityXY, isRunning=$_isRunning');
  }

  void update(double deltaSeconds) {
    if (!_isRunning || _simulationX == null || _simulationY == null) {
      updateNode();
      return;
    }

    _elapsedTime += deltaSeconds;

    // FrictionSimulationから現在の位置を取得
    final x = _simulationX!.x(_elapsedTime);
    final y = _simulationY!.x(_elapsedTime);
    _position = Vector3(x, 0, y);

    // 現在の速度を取得
    final vx = _simulationX!.dx(_elapsedTime);
    final vy = _simulationY!.dx(_elapsedTime);

    // 境界チェックと跳ね返り処理
    final posXZ = Vector2(_position.x, _position.z);
    final distanceFromCenter = posXZ.length;

    if (distanceFromCenter > boundaryRadius) {
      _handleBoundaryCollision(posXZ, Vector2(vx, vy));
    }

    // 進行方向を更新
    final currentSpeed = Vector2(vx, vy).length;
    if (currentSpeed > 0.01) {
      _direction = Vector3(vx, 0, vy);
      _direction.normalize();
    }

    // 停止判定（両軸のシミュレーションが完了したら停止）
    final isDone =
        _simulationX!.isDone(_elapsedTime) &&
        _simulationY!.isDone(_elapsedTime);

    if (isDone) {
      _isRunning = false;
      print('🛑 Stopped at position: $_position');
    }

    updateNode();
  }

  static final _random = Random();

  /// 境界との衝突処理（ランダムな角度に跳ね返る）
  void _handleBoundaryCollision(Vector2 posXZ, Vector2 velocity) {
    // 法線ベクトル（中心から外向き）
    final normal = posXZ.normalized();
    final dotProduct = velocity.dot(normal);

    // 外向きに進んでいる場合のみ反射（内向きなら何もしない）
    if (dotProduct > 0) {
      final currentSpeed = velocity.length;

      // 内向き方向（法線の逆）の角度を計算
      final inwardAngle = atan2(-normal.y, -normal.x);

      // 内向き方向を基準に -45度 〜 +45度 の範囲でランダムな角度を選ぶ
      final randomOffset = (_random.nextDouble() - 0.5) * (pi / 2);
      final bounceAngle = inwardAngle + randomOffset;

      // ランダムな角度で新しい速度ベクトルを作成（速度の大きさは維持）
      final bouncedVelocity = Vector2(
        cos(bounceAngle) * currentSpeed,
        sin(bounceAngle) * currentSpeed,
      );

      // 位置を境界の内側に戻す
      final correctedPos = normal * (boundaryRadius * 0.99);
      _position = Vector3(correctedPos.x, 0, correctedPos.y);

      // 新しいシミュレーションを作成（反射後の速度で開始）
      _simulationX = FrictionSimulation(
        _drag,
        _position.x,
        bouncedVelocity.x,
      );
      _simulationY = FrictionSimulation(
        _drag,
        _position.z,
        bouncedVelocity.y,
      );
      _elapsedTime = 0;

      // 進行方向を更新
      if (bouncedVelocity.length > 0.01) {
        _direction = Vector3(bouncedVelocity.x, 0, bouncedVelocity.y);
        _direction.normalize();
      }

      print(
        '🔄 Bounced! angle=${(bounceAngle * 180 / pi).toStringAsFixed(1)}°, '
        'velocity=$bouncedVelocity',
      );
    }
  }

  /// ルーレットをリセット
  void reset() {
    _position = Vector3.zero();
    _simulationX = null;
    _simulationY = null;
    _elapsedTime = 0;
    _direction = Vector3(0, 0, -1);
    _isRunning = false;
    updateNode();
  }
}
