import 'package:flutter/material.dart';
import 'package:roulette/features/amida/data/model/amida_ladder.dart';
import 'package:roulette/features/amida/data/model/amida_path.dart';

class AmidaPainter extends CustomPainter {
  AmidaPainter({
    required this.ladder,
    required this.teamCount,
    this.currentPath,
    this.animationProgress = 0.0,
    this.highlightedPaths = const [],
  });

  final AmidaLadder ladder;
  final int teamCount;
  final AmidaPath? currentPath;
  final double animationProgress;
  final List<AmidaPath> highlightedPaths;

  static const double padding = 40;
  static const double topPadding = 60;
  static const double bottomPadding = 60;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final columnSpacing = (width - padding * 2) / (teamCount - 1);

    _drawVerticalLines(canvas, size, columnSpacing);
    _drawHorizontalLines(canvas, size, columnSpacing);

    if (currentPath != null && animationProgress > 0) {
      _drawAnimatedPath(canvas, size, columnSpacing);
    }

    for (final path in highlightedPaths) {
      _drawHighlightedPath(canvas, size, columnSpacing, path);
    }
  }

  void _drawVerticalLines(Canvas canvas, Size size, double columnSpacing) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < teamCount; i++) {
      final x = padding + i * columnSpacing;
      canvas.drawLine(
        Offset(x, topPadding),
        Offset(x, size.height - bottomPadding),
        paint,
      );
    }
  }

  void _drawHorizontalLines(Canvas canvas, Size size, double columnSpacing) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final availableHeight = size.height - topPadding - bottomPadding;

    for (final line in ladder.horizontalLines) {
      final y = topPadding + line.yPosition * availableHeight;
      final x1 = padding + line.leftIndex * columnSpacing;
      final x2 = padding + line.rightIndex * columnSpacing;

      canvas.drawLine(
        Offset(x1, y),
        Offset(x2, y),
        paint,
      );
    }
  }

  void _drawAnimatedPath(Canvas canvas, Size size, double columnSpacing) {
    if (currentPath == null) {
      return;
    }

    final paint = Paint()
      ..color = Colors.cyan.shade400
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..color = Colors.cyan.withValues(alpha: 0.6)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = _createPathFromPoints(
      currentPath!.points,
      size,
      columnSpacing,
      animationProgress,
    );

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);

    final endPoint = _getPointAtProgress(
      currentPath!.points,
      size,
      columnSpacing,
      animationProgress,
    );

    if (endPoint != null) {
      final circlePaint = Paint()
        ..color = Colors.cyan.shade300
        ..style = PaintingStyle.fill;

      canvas.drawCircle(endPoint, 10, circlePaint);

      final outerCirclePaint = Paint()
        ..color = Colors.cyan.withValues(alpha: 0.6)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(endPoint, 16, outerCirclePaint);
    }
  }

  void _drawHighlightedPath(
    Canvas canvas,
    Size size,
    double columnSpacing,
    AmidaPath path,
  ) {
    final paint = Paint()
      ..color = Colors.green.withValues(alpha: 0.5)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fullPath = _createPathFromPoints(
      path.points,
      size,
      columnSpacing,
      1,
    );

    canvas.drawPath(fullPath, paint);
  }

  Path _createPathFromPoints(
    List<PathPoint> points,
    Size size,
    double columnSpacing,
    double progress,
  ) {
    final path = Path();
    final availableHeight = size.height - topPadding - bottomPadding;

    if (points.isEmpty) {
      return path;
    }

    final totalLength = _calculateTotalLength(points, size, columnSpacing);
    final targetLength = totalLength * progress;

    var currentLength = 0.0;
    var started = false;

    for (var i = 0; i < points.length - 1; i++) {
      final point1 = points[i];
      final point2 = points[i + 1];

      final x1 = padding + point1.columnIndex * columnSpacing;
      final y1 = topPadding + point1.yPosition * availableHeight;
      final x2 = padding + point2.columnIndex * columnSpacing;
      final y2 = topPadding + point2.yPosition * availableHeight;

      final segmentLength = (Offset(x2, y2) - Offset(x1, y1)).distance;

      if (currentLength + segmentLength > targetLength) {
        if (!started) {
          path.moveTo(x1, y1);
          started = true;
        }

        final remainingLength = targetLength - currentLength;
        final ratio = remainingLength / segmentLength;
        final endX = x1 + (x2 - x1) * ratio;
        final endY = y1 + (y2 - y1) * ratio;

        path.lineTo(endX, endY);
        break;
      }

      if (!started) {
        path.moveTo(x1, y1);
        started = true;
      }

      path.lineTo(x2, y2);
      currentLength += segmentLength;
    }

    return path;
  }

  Offset? _getPointAtProgress(
    List<PathPoint> points,
    Size size,
    double columnSpacing,
    double progress,
  ) {
    if (points.isEmpty) {
      return null;
    }

    final availableHeight = size.height - topPadding - bottomPadding;
    final totalLength = _calculateTotalLength(points, size, columnSpacing);
    final targetLength = totalLength * progress;

    var currentLength = 0.0;

    for (var i = 0; i < points.length - 1; i++) {
      final point1 = points[i];
      final point2 = points[i + 1];

      final x1 = padding + point1.columnIndex * columnSpacing;
      final y1 = topPadding + point1.yPosition * availableHeight;
      final x2 = padding + point2.columnIndex * columnSpacing;
      final y2 = topPadding + point2.yPosition * availableHeight;

      final segmentLength = (Offset(x2, y2) - Offset(x1, y1)).distance;

      if (currentLength + segmentLength >= targetLength) {
        final remainingLength = targetLength - currentLength;
        final ratio = remainingLength / segmentLength;
        final endX = x1 + (x2 - x1) * ratio;
        final endY = y1 + (y2 - y1) * ratio;

        return Offset(endX, endY);
      }

      currentLength += segmentLength;
    }

    final lastPoint = points.last;
    return Offset(
      padding + lastPoint.columnIndex * columnSpacing,
      topPadding + lastPoint.yPosition * availableHeight,
    );
  }

  double _calculateTotalLength(
    List<PathPoint> points,
    Size size,
    double columnSpacing,
  ) {
    if (points.length < 2) {
      return 0;
    }

    final availableHeight = size.height - topPadding - bottomPadding;
    var totalLength = 0.0;

    for (var i = 0; i < points.length - 1; i++) {
      final point1 = points[i];
      final point2 = points[i + 1];

      final x1 = padding + point1.columnIndex * columnSpacing;
      final y1 = topPadding + point1.yPosition * availableHeight;
      final x2 = padding + point2.columnIndex * columnSpacing;
      final y2 = topPadding + point2.yPosition * availableHeight;

      totalLength += (Offset(x2, y2) - Offset(x1, y1)).distance;
    }

    return totalLength;
  }

  @override
  bool shouldRepaint(AmidaPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.currentPath != currentPath ||
        oldDelegate.highlightedPaths != highlightedPaths;
  }
}
