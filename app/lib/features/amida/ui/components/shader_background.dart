import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShaderBackground extends HookWidget {
  const ShaderBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final program = useMemoized(
      () => ui.FragmentProgram.fromAsset('shaders/background_gradient.frag'),
    );
    final programFuture = useFuture(program);

    final animationController = useAnimationController(
      duration: const Duration(seconds: 10),
    )..repeat();

    if (!programFuture.hasData) {
      return child;
    }

    return CustomPaint(
      painter: _ShaderBackgroundPainter(
        shader: programFuture.data!.fragmentShader(),
        time: animationController.value,
      ),
      child: child,
    );
  }
}

class _ShaderBackgroundPainter extends CustomPainter {
  _ShaderBackgroundPainter({
    required this.shader,
    required this.time,
  });

  final ui.FragmentShader shader;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, size.width) // uSize.x
      ..setFloat(1, size.height) // uSize.y
      ..setFloat(2, time * 10) // uTime
      // uColor1 (blue)
      ..setFloat(3, 0.2)
      ..setFloat(4, 0.3)
      ..setFloat(5, 0.8)
      // uColor2 (purple)
      ..setFloat(6, 0.5)
      ..setFloat(7, 0.2)
      ..setFloat(8, 0.7);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_ShaderBackgroundPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}

