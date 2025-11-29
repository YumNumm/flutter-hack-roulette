import 'package:flutter/material.dart';

class FlipperControls extends StatelessWidget {
  const FlipperControls({
    required this.onLeftFlipperPressed,
    required this.onLeftFlipperReleased,
    required this.onRightFlipperPressed,
    required this.onRightFlipperReleased,
    super.key,
  });

  final VoidCallback onLeftFlipperPressed;
  final VoidCallback onLeftFlipperReleased;
  final VoidCallback onRightFlipperPressed;
  final VoidCallback onRightFlipperReleased;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左フリッパー
          GestureDetector(
            onTapDown: (_) => onLeftFlipperPressed(),
            onTapUp: (_) => onLeftFlipperReleased(),
            onTapCancel: onLeftFlipperReleased,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
                size: 48,
              ),
            ),
          ),

          // 右フリッパー
          GestureDetector(
            onTapDown: (_) => onRightFlipperPressed(),
            onTapUp: (_) => onRightFlipperReleased(),
            onTapCancel: onRightFlipperReleased,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
                size: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
