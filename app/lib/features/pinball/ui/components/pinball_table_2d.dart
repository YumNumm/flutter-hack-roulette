import 'dart:async';
import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/features/pinball/data/model/game_state.dart';
import 'package:roulette/features/pinball/data/notifier/pinball_game_notifier.dart';

/// 2Dピンボールテーブルコンポーネント
class PinballTable2D extends HookConsumerWidget {
  const PinballTable2D({
    required this.onHoleDetected,
    super.key,
  });

  final void Function(int holeNumber) onHoleDetected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = useMemoized(
      () => PinballGame(onHoleDetected: onHoleDetected),
    );
    final gameState = ref.watch(pinballGameProvider);

    useEffect(
      () {
        return () {};
      },
      [],
    );

    // ゲーム状態の変更を監視
    useEffect(
      () {
        if (gameState.status == GameStatus.ballLaunched &&
            !game.isBallLaunched) {
          game.launchBall();
        }

        game.setFlipperStates(
          leftActive: gameState.isFlipperLeftActive,
          rightActive: gameState.isFlipperRightActive,
        );

        return null;
      },
      [gameState],
    );

    return GameWidget(game: game);
  }
}

/// Flameベースのピンボールゲーム
class PinballGame extends Forge2DGame {
  PinballGame({
    required this.onHoleDetected,
  }) : super(gravity: Vector2(0, 20));

  final void Function(int) onHoleDetected;

  late Ball ball;
  LeftFlipper? leftFlipper;
  RightFlipper? rightFlipper;
  final List<Hole> holes = [];

  bool isBallLaunched = false;
  bool _isInitialized = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // カメラ設定
    camera.viewfinder.position = Vector2(0, 0);
    camera.viewfinder.zoom = 10;

    // ピンボールテーブルを作成
    _createTable();
    _createBall();
    _createFlippers();
    _createHoles(6);
    _createBumpers();
    
    _isInitialized = true;
  }

  void _createTable() {
    // テーブルの壁
    // 上壁
    world.add(Wall(Vector2(0, -15), Vector2(12, 0.5)));
    // 下壁
    world.add(Wall(Vector2(0, 15), Vector2(12, 0.5)));
    // 左壁
    world.add(Wall(Vector2(-6, 0), Vector2(0.5, 30)));
    // 右壁
    world.add(Wall(Vector2(6, 0), Vector2(0.5, 30)));
  }

  void _createBall() {
    ball = Ball(
      position: Vector2(5, -12),
      onHoleDetected: (holeNumber) {
        isBallLaunched = false;
        onHoleDetected(holeNumber);
        // ボールをリセット
        ball.body.setTransform(Vector2(5, -12), 0);
        ball.body.linearVelocity = Vector2.zero();
        ball.body.angularVelocity = 0;
      },
    );
    world.add(ball);
  }

  void _createFlippers() {
    final left = LeftFlipper(position: Vector2(-2, 12));
    final right = RightFlipper(position: Vector2(2, 12));
    leftFlipper = left;
    rightFlipper = right;
    world.add(left);
    world.add(right);
  }

  void _createHoles(int count) {
    const startX = -5.0;
    final spacing = 10.0 / (count - 1);

    for (var i = 0; i < count; i++) {
      final x = startX + (spacing * i);
      final hole = Hole(
        position: Vector2(x, 13),
        number: i + 1,
      );
      holes.add(hole);
      world.add(hole);
    }
  }

  void _createBumpers() {
    // バンパーを中央に配置
    final bumperPositions = [
      Vector2(-3, -5),
      Vector2(3, -5),
      Vector2(0, 0),
      Vector2(-3, 5),
      Vector2(3, 5),
    ];

    for (final pos in bumperPositions) {
      world.add(Bumper(position: pos));
    }
  }

  void launchBall() {
    if (!isBallLaunched && _isInitialized) {
      isBallLaunched = true;
      // ボールに初速度を与える
      final random = math.Random();
      ball.body.linearVelocity = Vector2(
        -10 + random.nextDouble() * 5,
        15,
      );
    }
  }

  void setFlipperStates({required bool leftActive, required bool rightActive}) {
    if (!_isInitialized) {
      return;
    }
    
    leftFlipper?.isActive = leftActive;
    rightFlipper?.isActive = rightActive;
  }
}

/// ボール
class Ball extends BodyComponent {
  Ball({
    required Vector2 position,
    required this.onHoleDetected,
  }) : _initialPosition = position;

  final Vector2 _initialPosition;
  final void Function(int) onHoleDetected;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 0.4;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.6,
      friction: 0.5,
    );

    final bodyDef = BodyDef(
      position: _initialPosition,
      type: BodyType.dynamic,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color(0xFF00FF88)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, 0.4, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 穴との衝突判定
    if (parent case final PinballGame game) {
      for (final hole in game.holes) {
        final distance = (body.position - hole.body.position).length;
        if (distance < 0.8) {
          onHoleDetected(hole.number);
          break;
        }
      }
    }
  }
}

/// 壁
class Wall extends BodyComponent {
  Wall(Vector2 position, Vector2 size) : _position = position, _size = size;

  final Vector2 _position;
  final Vector2 _size;

  @override
  Body createBody() {
    final shape = PolygonShape()
      ..setAsBox(_size.x / 2, _size.y / 2, Vector2.zero(), 0);

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      friction: 0.3,
    );

    final bodyDef = BodyDef(
      position: _position,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color(0xFF8B4513)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: _size.x,
        height: _size.y,
      ),
      paint,
    );
  }
}

/// フリッパー（左）
class LeftFlipper extends BodyComponent {
  LeftFlipper({required Vector2 position}) : _position = position;

  final Vector2 _position;
  bool isActive = false;
  late RevoluteJoint joint;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(1, 0.15, Vector2.zero(), 0);

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      density: 2,
    );

    final bodyDef = BodyDef(
      position: _position,
      type: BodyType.dynamic,
    );

    final flipperBody = world.createBody(bodyDef)..createFixture(fixtureDef);

    // アンカーを作成
    final anchorBodyDef = BodyDef(
      position: _position,
    );
    final anchorBody = world.createBody(anchorBodyDef);

    // 回転ジョイントを作成
    final jointDef = RevoluteJointDef()
      ..initialize(anchorBody, flipperBody, _position)
      ..enableLimit = true
      ..lowerAngle = 0
      ..upperAngle =
          math.pi /
          3 // 60度
      ..enableMotor = true
      ..maxMotorTorque = 1000;

    joint = RevoluteJoint(jointDef);

    return flipperBody;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isActive) {
      joint.motorSpeed = -20; // 上げる
    } else {
      joint.motorSpeed = 10; // 下げる
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color(0xFFFF6B6B)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: 2,
        height: 0.3,
      ),
      paint,
    );
  }
}

/// フリッパー（右）
class RightFlipper extends BodyComponent {
  RightFlipper({required Vector2 position}) : _position = position;

  final Vector2 _position;
  bool isActive = false;
  late RevoluteJoint joint;

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(1, 0.15, Vector2.zero(), 0);

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.8,
      density: 2,
    );

    final bodyDef = BodyDef(
      position: _position,
      type: BodyType.dynamic,
    );

    final flipperBody = world.createBody(bodyDef)..createFixture(fixtureDef);

    // アンカーを作成
    final anchorBodyDef = BodyDef(
      position: _position,
    );
    final anchorBody = world.createBody(anchorBodyDef);

    // 回転ジョイントを作成
    final jointDef = RevoluteJointDef()
      ..initialize(anchorBody, flipperBody, _position)
      ..enableLimit = true
      ..lowerAngle =
          -math.pi /
          3 // -60度
      ..upperAngle = 0
      ..enableMotor = true
      ..maxMotorTorque = 1000;

    joint = RevoluteJoint(jointDef);

    return flipperBody;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isActive) {
      joint.motorSpeed = 20; // 上げる
    } else {
      joint.motorSpeed = -10; // 下げる
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color(0xFFFF6B6B)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: 2,
        height: 0.3,
      ),
      paint,
    );
  }
}

/// 穴
class Hole extends BodyComponent {
  Hole({
    required Vector2 position,
    required this.number,
  }) : _position = position;

  final Vector2 _position;
  final int number;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 0.8;

    final fixtureDef = FixtureDef(
      shape,
      isSensor: true, // センサーとして機能
    );

    final bodyDef = BodyDef(
      position: _position,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // 穴
    final holePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 0.8, holePaint);

    // 光るエフェクト
    final glowPaint = Paint()
      ..color = const Color(0xFF0066FF).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.1;
    canvas.drawCircle(Offset.zero, 0.8, glowPaint);

    // 番号
    final textPainter = TextPainter(
      text: TextSpan(
        text: number.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 0.6,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
  }
}

/// バンパー
class Bumper extends BodyComponent {
  Bumper({required Vector2 position}) : _position = position;

  final Vector2 _position;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 0.5;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 1.5, // 高い反発係数
    );

    final bodyDef = BodyDef(
      position: _position,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = const Color(0xFFFFAA00)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, 0.5, paint);

    // 光るエフェクト
    final glowPaint = Paint()
      ..color = const Color(0xFFFFAA00).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 0.6, glowPaint);
  }
}
