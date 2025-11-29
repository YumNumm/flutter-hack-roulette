import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_scene/scene.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/roulette/data/dash/kinematic_dash.dart';
import 'package:template/features/roulette/data/model/team.dart';
import 'package:vector_math/vector_math.dart' as vm;

class RouletteScene extends HookConsumerWidget {
  const RouletteScene({
    required this.teams,
    super.key,
  });

  final List<Team> teams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scene = useMemoized(Scene.new);

    final camera = useMemoized(
      () => PerspectiveCamera(
        position: vm.Vector3(0, 10, 10),
        target: vm.Vector3(0, 0, 0),
      ),
    );

    final kinematicDash = useState<KinematicDash?>(null);
    final isSceneReady = useState(false);

    final ticker = useSingleTickerProvider();
    final controller = useAnimationController(
      duration: const Duration(hours: 1),
      vsync: ticker,
    );

    useEffect(
      () {
        unawaited(
          Scene.initializeStaticResources().then((_) async {
            final node = await Node.fromAsset('build/models/dash.model');
            scene.add(node);

            final dash = KinematicDash(node);
            dash.updateNode();
            kinematicDash.value = dash;
            debugPrint('✅ Dash model loaded successfully');

            final skySphere = await Node.fromAsset(
              'build/models/sky_sphere.model',
            );

            Node convertToUnlit(Node node) {
              // Search for all mesh primitives and convert them to unlit.
              if (node.mesh != null) {
                for (final primitive in node.mesh!.primitives) {
                  if (primitive.material is PhysicallyBasedMaterial) {
                    final pbr = primitive.material as PhysicallyBasedMaterial;
                    primitive.material = UnlitMaterial(
                      colorTexture: pbr.baseColorTexture,
                    );
                  }
                }
              }
              for (final child in node.children) {
                convertToUnlit(child);
              }

              return node;
            }

            final sky = convertToUnlit(skySphere);
            sky.globalTransform = vm.Matrix4.translation(
              vm.Vector3(0, 1, 1),
            );
            scene.add(sky);
            isSceneReady.value = true;
          }),
        );
        unawaited(controller.repeat());
        return null;
      },
      [],
    );

    useEffect(
      () {
        void update() {
          const deltaTime = 1.0 / 60.0;
          // KinematicDashのアニメーションと位置を更新
          kinematicDash.value?.update(deltaTime);
        }

        controller.addListener(update);
        return () => controller.removeListener(update);
      },
      [controller, teams.length, kinematicDash.value],
    );

    final panStartOffset = useRef<Offset?>(null);

    return LayoutBuilder(
      builder: (context, constraints) {
        // 画面の短辺/2を基準に境界半径を計算
        // 3Dワールド座標へのスケール変換（調整可能）
        const worldScale = 0.01;
        final screenRadius = constraints.biggest.shortestSide * 0.5;
        final worldBoundaryRadius = screenRadius * worldScale;

        // 境界半径を設定
        kinematicDash.value?.boundaryRadius = worldBoundaryRadius.toInt();

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (details) => panStartOffset.value = details.localPosition,
          onPanEnd: (details) {
            final dash = kinematicDash.value;
            if (dash == null || dash.isRunning) {
              return;
            }
            if (panStartOffset.value == null) {
              return;
            }
            final startOffset = panStartOffset.value!;
            final endOffset = details.localPosition;
            final diff = endOffset - startOffset;

            // 最小速度を設定
            const minVelocity = 0.5;
            if (diff.distance < minVelocity) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Flick too slow'),
                ),
              );
              return;
            }

            debugPrint(
              '🎯 Flick detected: velocity=$diff, '
              'length=${diff.distance}',
            );
            dash.start(vm.Vector2(-diff.dx, diff.dy) / 10);
          },
          child: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 3, 0.0001) // perspective
                  ..rotateX(-pi / 12)
                  ..rotateY(0),
                child: SizedBox.expand(
                  child: CustomPaint(
                    painter: _RouletteDiskPainter(
                      teams: teams,
                    ),
                  ),
                ),
              ),
              // 3D Dashくんを前景に描画
              if (kinematicDash.value != null)
                SizedBox.expand(
                  child: CustomPaint(
                    painter: _ScenePainter(
                      scene: scene,
                      camera: camera,
                      repaint: controller,
                    ),
                  ),
                ),
              // フリック案内表示（ルーレット未開始時のみ）
              if (kinematicDash.value != null &&
                  !kinematicDash.value!.isRunning)
                const Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      '画面をフリックしてルーレットを開始',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RouletteDiskPainter extends CustomPainter {
  _RouletteDiskPainter({
    required this.teams,
  });

  final List<Team> teams;

  @override
  void paint(Canvas canvas, Size size) {
    if (teams.isEmpty) {
      return;
    }

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.5;

    final segmentAngle = (2 * pi) / teams.length;

    // ルーレット円盤を描画
    for (var i = 0; i < teams.length; i++) {
      final startAngle = i * segmentAngle - pi / 2;
      final paint = Paint()
        ..color = _getSegmentColor(i)
        ..style = PaintingStyle.fill;

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          segmentAngle,
          false,
        )
        ..close();

      canvas.drawPath(path, paint);

      // セグメントの境界線を描画
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawPath(path, borderPaint);

      // チーム名を描画
      final textAngle = startAngle + segmentAngle / 2;
      final textRadius = radius * 0.7;
      final textX = center.dx + cos(textAngle) * textRadius;
      final textY = center.dy + sin(textAngle) * textRadius;

      final textPainter = TextPainter(
        text: TextSpan(
          text: teams[i].name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas
        ..save()
        ..translate(textX, textY)
        ..rotate(textAngle + pi / 2);

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }

    // 中央の円を描画
    final centerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.15, centerCirclePaint);
  }

  Color _getSegmentColor(int index) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.amber,
    ];
    return colors[index % colors.length];
  }

  @override
  bool shouldRepaint(_RouletteDiskPainter oldDelegate) =>
      oldDelegate.teams != teams;
}

class _ScenePainter extends CustomPainter {
  _ScenePainter({
    required this.scene,
    required this.camera,
    required Listenable repaint,
  }) : super(repaint: repaint);

  final Scene scene;
  final Camera camera;

  @override
  void paint(Canvas canvas, Size size) {
    scene.render(camera, canvas, viewport: Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
