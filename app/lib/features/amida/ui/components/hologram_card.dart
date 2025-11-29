import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HologramCard extends HookWidget {
  const HologramCard({
    required this.child,
    this.color = Colors.cyan,
    super.key,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final program = useMemoized(
      () => ui.FragmentProgram.fromAsset('shaders/hologram.frag'),
    );
    final programFuture = useFuture(program);

    final animationController = useAnimationController(
      duration: const Duration(seconds: 3),
    )..repeat();

    final animation = useAnimation(animationController);

    if (!programFuture.hasData) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      );
    }

    return CustomPaint(
      painter: _HologramBorderPainter(
        shader: programFuture.data!.fragmentShader(),
        time: animation,
        color: color,
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withValues(alpha: 0.05),
        ),
        child: child,
      ),
    );
  }
}

class _HologramBorderPainter extends CustomPainter {
  _HologramBorderPainter({
    required this.shader,
    required this.time,
    required this.color,
  });

  final ui.FragmentShader shader;
  final double time;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, size.width) // uSize.x
      ..setFloat(1, size.height) // uSize.y
      ..setFloat(2, time * 10) // uTime
      ..setFloat(3, color.red / 255.0) // uColor.r
      ..setFloat(4, color.green / 255.0) // uColor.g
      ..setFloat(5, color.blue / 255.0) // uColor.b
      ..setFloat(6, 0.8); // uAlpha

    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(12),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(_HologramBorderPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}

