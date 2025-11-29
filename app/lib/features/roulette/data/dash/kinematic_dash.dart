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
      _node.findAnimationByName('Blink')!,
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
    walkAnimation.loop = true;
    walkAnimation.weight = 1;

    runAnimation.playing = _isRunning && currentSpeed > 0.01;
    runAnimation.loop = true;
    runAnimation.weight = 1;
    runAnimation.playbackTimeScale = currentSpeed * 2;
    blinkAnimation.playing = false;
    blinkAnimation.loop = true;
    blinkAnimation.weight = 1.0;

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

    // 現在の速度を取得して進行方向を更新
    final vx = _simulationX!.dx(_elapsedTime);
    final vy = _simulationY!.dx(_elapsedTime);
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
