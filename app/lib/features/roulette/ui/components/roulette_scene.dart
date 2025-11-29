import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_scene/scene.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/roulette/data/model/team.dart';
import 'package:template/features/roulette/data/notifier/roulette_notifier.dart';
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
        position: vm.Vector3(0, 5, 8),
        target: vm.Vector3(0, 0, 0),
      ),
    );

    final rouletteNode = useMemoized(Node.new);
    final dashNode = useState<Node?>(null);

    final ticker = useSingleTickerProvider();
    final controller = useAnimationController(
      duration: const Duration(hours: 1),
      vsync: ticker,
    );

    final rouletteState = ref.watch(rouletteProvider);
    final rouletteNotifier = ref.read(rouletteProvider.notifier);

    useEffect(
      () {
        _setupScene(scene, rouletteNode, teams);
        _loadDashModel(scene, dashNode);
        controller.repeat();
        return null;
      },
      [],
    );

    useEffect(
      () {
        void update() {
          const deltaTime = 1.0 / 60.0;
          rouletteNotifier.updateRotation(deltaTime);
        }

        controller.addListener(update);
        return () => controller.removeListener(update);
      },
      [controller],
    );

    useEffect(
      () {
        rouletteNode.localTransform = vm.Matrix4.identity()
          ..rotateY(rouletteState.rotation);
        if (dashNode.value != null) {
          dashNode.value!.localTransform = vm.Matrix4.identity()
            ..translate(vm.Vector3(0, 1, 0))
            ..rotateY(rouletteState.rotation)
            ..scale(vm.Vector3.all(0.5));
        }
        return null;
      },
      [rouletteState.rotation],
    );

    return Stack(
      children: [
        // 2Dルーレット円盤を背景に描画
        CustomPaint(
          painter: _RouletteDiskPainter(
            teams: teams,
            rotation: rouletteState.rotation,
          ),
          size: Size.infinite,
        ),
        // 3D Dashくんを前景に描画
        CustomPaint(
          painter: _ScenePainter(
            scene: scene,
            camera: camera,
          ),
          size: Size.infinite,
        ),
      ],
    );
  }

  void _setupScene(Scene scene, Node rouletteNode, List<Team> teams) {
    scene.add(rouletteNode);
  }

  Future<void> _loadDashModel(
    Scene scene,
    ValueNotifier<Node?> dashNode,
  ) async {
    try {
      final node = await Node.fromAsset('assets/models/dash.glb');
      node.localTransform = vm.Matrix4.identity()
        ..translate(vm.Vector3(0, 1, 0))
        ..scale(vm.Vector3.all(0.5));
      scene.add(node);
      dashNode.value = node;
    } catch (e) {
      debugPrint('Failed to load dash model: $e');
    }
  }
}

class _RouletteDiskPainter extends CustomPainter {
  _RouletteDiskPainter({
    required this.teams,
    required this.rotation,
  });

  final List<Team> teams;
  final double rotation;

  @override
  void paint(Canvas canvas, Size size) {
    if (teams.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.35;

    final segmentAngle = (2 * pi) / teams.length;

    for (var i = 0; i < teams.length; i++) {
      final startAngle = i * segmentAngle + rotation - pi / 2;
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
      oldDelegate.rotation != rotation || oldDelegate.teams != teams;
}

class _ScenePainter extends CustomPainter {
  _ScenePainter({
    required this.scene,
    required this.camera,
  });

  final Scene scene;
  final Camera camera;

  @override
  void paint(Canvas canvas, Size size) {
    scene.render(camera, canvas);
  }

  @override
  bool shouldRepaint(_ScenePainter oldDelegate) => true;
}
