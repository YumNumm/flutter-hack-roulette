import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HologramText extends HookWidget {
  const HologramText({
    required this.text,
    this.style,
    super.key,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final program = useMemoized(
      () => ui.FragmentProgram.fromAsset('shaders/hologram.frag'),
    );
    final programFuture = useFuture(program);

    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat();

    final animation = useAnimation(animationController);

    if (!programFuture.hasData) {
      return Text(text, style: style);
    }

    return ShaderMask(
      shaderCallback: (bounds) {
        final shader = programFuture.data!.fragmentShader();
        shader
          ..setFloat(0, bounds.width) // uSize.x
          ..setFloat(1, bounds.height) // uSize.y
          ..setFloat(2, animation * 10) // uTime
          // uColor (cyan)
          ..setFloat(3, 0.0)
          ..setFloat(4, 0.8)
          ..setFloat(5, 1.0)
          ..setFloat(6, 1.0); // uAlpha

        return shader;
      },
      child: Text(
        text,
        style: style?.copyWith(color: Colors.white) ??
            const TextStyle(color: Colors.white),
      ),
    );
  }
}

