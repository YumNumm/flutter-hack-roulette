import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/roulette/data/model/roulette_state.dart';
import 'package:template/features/roulette/data/model/team.dart';

const _ballRadius = 14.0;
const _minLaunchVelocity = 350.0;
const _velocityFallbackScale = 8.0;

class RouletteScene extends HookConsumerWidget {
  const RouletteScene({
    required this.teams,
    required this.onTeamDecided,
    super.key,
  });

  final List<Team> teams;
  final void Function(Team team) onTeamDecided;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (teams.isEmpty) {
      return const Center(
        child: Text('チームがありません'),
      );
    }

    final simulation = useMemoized(_BallSimulation.new);
    final ballPosition = useState(Offset.zero);
    final status = useState(RouletteStatus.idle);

    final dragStart = useRef<Offset?>(null);
    final dragCurrent = useRef<Offset?>(null);
    final lastElapsed = useRef<Duration?>(null);
    final hasReportedResult = useRef(false);

    final teamsRef = useRef<List<Team>>(teams);
    teamsRef.value = teams;

    final onTeamDecidedRef = useRef(onTeamDecided);
    onTeamDecidedRef.value = onTeamDecided;

    final tickerProvider = useSingleTickerProvider();

    useEffect(
      () {
        final ticker = tickerProvider.createTicker((elapsed) {
          final previous = lastElapsed.value;
          lastElapsed.value = elapsed;
          if (previous == null || simulation.boundaryRadius == 0) {
            return;
          }
          final deltaSeconds =
              (elapsed - previous).inMicroseconds / Duration.microsecondsPerSecond;
          if (deltaSeconds <= 0) {
            return;
          }

          final wasRunning = simulation.isRunning;
          simulation.step(deltaSeconds);
          ballPosition.value = simulation.position;

          if (simulation.isRunning && status.value == RouletteStatus.idle) {
            status.value = RouletteStatus.spinning;
          }

          if (wasRunning && !simulation.isRunning) {
            status.value = RouletteStatus.stopped;
            if (!hasReportedResult.value && teamsRef.value.isNotEmpty) {
              hasReportedResult.value = true;
              final winnerIndex = _RouletteMath.segmentIndexFor(
                simulation.position,
                teamsRef.value.length,
              );
              onTeamDecidedRef.value(teamsRef.value[winnerIndex]);
            }
          }
        });

        ticker.start();
        return () {
          ticker.dispose();
          lastElapsed.value = null;
        };
      },
      [tickerProvider, simulation],
    );

    useEffect(
      () {
        simulation.reset();
        ballPosition.value = Offset.zero;
        status.value = RouletteStatus.idle;
        dragStart.value = null;
        dragCurrent.value = null;
        hasReportedResult.value = false;
        return null;
      },
      [teams],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final radius = size.shortestSide * 0.45;
        final safeRadius = max(radius - _ballRadius * 1.2, 4);
        final center = Offset(size.width / 2, size.height / 2);
        simulation.boundaryRadius = safeRadius;

        int? highlightedIndex;
        if (teams.isNotEmpty) {
          highlightedIndex = _RouletteMath.segmentIndexFor(
            ballPosition.value,
            teams.length,
          );
        }

        Offset clampToCircle(Offset localPosition) {
          final relative = localPosition - center;
          final distance = relative.distance;
          if (distance <= safeRadius) {
            return relative;
          }
          if (distance == 0) {
            return Offset.zero;
          }
          final normalized = relative / distance;
          return normalized * safeRadius;
        }

        void updateBallPosition(Offset relative) {
          simulation.placeBall(relative);
          ballPosition.value = simulation.position;
        }

        void startSimulation(Offset velocity) {
          if (velocity.distance < _minLaunchVelocity) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('もう少し強くスワイプしてください')),
            );
            return;
          }
          hasReportedResult.value = false;
          status.value = RouletteStatus.spinning;
          simulation.start(velocity);
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (details) {
            if (simulation.isRunning) {
              return;
            }
            dragStart.value = details.localPosition;
            dragCurrent.value = details.localPosition;
            updateBallPosition(clampToCircle(details.localPosition));
          },
          onPanUpdate: (details) {
            if (simulation.isRunning) {
              return;
            }
            dragCurrent.value = details.localPosition;
            updateBallPosition(clampToCircle(details.localPosition));
          },
          onPanCancel: () {
            dragStart.value = null;
            dragCurrent.value = null;
          },
          onPanEnd: (details) {
            if (simulation.isRunning || dragStart.value == null) {
              return;
            }
            final velocity = details.velocity.pixelsPerSecond;
            Offset effectiveVelocity = velocity;
            if (effectiveVelocity.distance < 50 &&
                dragCurrent.value != null &&
                dragStart.value != null) {
              effectiveVelocity =
                  (dragCurrent.value! - dragStart.value!) * _velocityFallbackScale;
            }
            startSimulation(effectiveVelocity);
            dragStart.value = null;
            dragCurrent.value = null;
          },
          child: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: _RoulettePainter(
                    teams: teams,
                    center: center,
                    radius: radius,
                    ballPosition: ballPosition.value,
                    ballRadius: _ballRadius,
                    highlightedIndex: highlightedIndex,
                  ),
                ),
              ),
              if (status.value != RouletteStatus.spinning)
                Positioned(
                  bottom: 48,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.swipe,
                        color: Colors.white.withOpacity(0.9),
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'ボールをドラッグしてスワイプ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 6),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (status.value == RouletteStatus.stopped && highlightedIndex != null)
                Positioned(
                  top: 24,
                  left: 0,
                  right: 0,
                  child: Text(
                    '${teams[highlightedIndex].name} が選ばれました',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(blurRadius: 4),
                      ],
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

class _RoulettePainter extends CustomPainter {
  _RoulettePainter({
    required this.teams,
    required this.center,
    required this.radius,
    required this.ballPosition,
    required this.ballRadius,
    required this.highlightedIndex,
  });

  final List<Team> teams;
  final Offset center;
  final double radius;
  final Offset ballPosition;
  final double ballRadius;
  final int? highlightedIndex;

  static const _segmentColors = [
    Color(0xFFE57373),
    Color(0xFF64B5F6),
    Color(0xFF81C784),
    Color(0xFFFFF176),
    Color(0xFFFFB74D),
    Color(0xFF9575CD),
    Color(0xFFF06292),
    Color(0xFF4DB6AC),
    Color(0xFF4DD0E1),
    Color(0xFFFFD54F),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (teams.isEmpty) {
      return;
    }

    final diskRadius = min(radius, size.shortestSide / 2);
    final segmentAngle = (2 * pi) / teams.length;

    for (var i = 0; i < teams.length; i++) {
      final startAngle = i * segmentAngle - pi / 2;
      final isHighlighted = highlightedIndex == i;
      final paint = Paint()
        ..color = _segmentColors[i % _segmentColors.length]
            .withOpacity(isHighlighted ? 0.95 : 0.75)
        ..style = PaintingStyle.fill;

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: diskRadius),
          startAngle,
          segmentAngle,
          false,
        )
        ..close();

      canvas.drawPath(path, paint);

      final borderPaint = Paint()
        ..color = Colors.white.withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isHighlighted ? 4 : 2;
      canvas.drawPath(path, borderPaint);

      final textAngle = startAngle + segmentAngle / 2;
      final textRadius = diskRadius * 0.7;
      final textPosition = Offset(
        center.dx + cos(textAngle) * textRadius,
        center.dy + sin(textAngle) * textRadius,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: teams[i].name,
          style: TextStyle(
            color: Colors.white,
            fontSize: isHighlighted ? 20 : 16,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(blurRadius: 2),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: diskRadius * 0.5);

      canvas
        ..save()
        ..translate(textPosition.dx, textPosition.dy)
        ..rotate(textAngle + pi / 2);

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }

    final hubPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, diskRadius * 0.12, hubPaint);

    final ballCenter = center + ballPosition;
    final ballPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFF90CAF9),
        ],
      ).createShader(
        Rect.fromCircle(center: ballCenter, radius: ballRadius),
      );
    canvas.drawCircle(ballCenter, ballRadius, ballPaint);
    canvas.drawCircle(
      ballCenter,
      ballRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _RoulettePainter oldDelegate) {
    return oldDelegate.teams != teams ||
        oldDelegate.ballPosition != ballPosition ||
        oldDelegate.highlightedIndex != highlightedIndex;
  }
}

class _BallSimulation {
  static const _drag = 1.6;

  Offset position = Offset.zero;
  Offset velocity = Offset.zero;
  double boundaryRadius = 0;

  FrictionSimulation? _simulationX;
  FrictionSimulation? _simulationY;
  double _elapsed = 0;
  bool isRunning = false;

  void placeBall(Offset newPosition) {
    position = newPosition;
    velocity = Offset.zero;
    _stop();
  }

  void start(Offset initialVelocity) {
    if (initialVelocity == Offset.zero) {
      return;
    }
    _simulationX = FrictionSimulation(_drag, position.dx, initialVelocity.dx);
    _simulationY = FrictionSimulation(_drag, position.dy, initialVelocity.dy);
    _elapsed = 0;
    velocity = initialVelocity;
    isRunning = true;
  }

  void step(double deltaSeconds) {
    if (!isRunning || _simulationX == null || _simulationY == null) {
      return;
    }
    _elapsed += deltaSeconds;
    position = Offset(
      _simulationX!.x(_elapsed),
      _simulationY!.x(_elapsed),
    );
    velocity = Offset(
      _simulationX!.dx(_elapsed),
      _simulationY!.dx(_elapsed),
    );

    final distance = position.distance;
    if (boundaryRadius > 0 && distance >= boundaryRadius && distance > 0) {
      _handleBounce(distance);
    }

    final isDone =
        _simulationX!.isDone(_elapsed) && _simulationY!.isDone(_elapsed);
    if (isDone || velocity.distance < 10) {
      _stop();
    }
  }

  void reset() {
    position = Offset.zero;
    velocity = Offset.zero;
    _stop();
  }

  void _stop() {
    _simulationX = null;
    _simulationY = null;
    _elapsed = 0;
    isRunning = false;
  }

  void _handleBounce(double distance) {
    final normal = position / distance;
    final reflectedVelocity = _reflect(velocity, normal);
    position = normal * boundaryRadius * 0.98;
    _simulationX = FrictionSimulation(_drag, position.dx, reflectedVelocity.dx);
    _simulationY = FrictionSimulation(_drag, position.dy, reflectedVelocity.dy);
    _elapsed = 0;
    velocity = reflectedVelocity;
  }

  Offset _reflect(Offset velocity, Offset normal) {
    final dot = velocity.dx * normal.dx + velocity.dy * normal.dy;
    return velocity - normal * (2 * dot);
  }
}

class _RouletteMath {
  static int segmentIndexFor(Offset position, int segmentCount) {
    if (segmentCount == 0) {
      return 0;
    }
    final angle = (atan2(position.dy, position.dx) + 2 * pi) % (2 * pi);
    final segmentAngle = (2 * pi) / segmentCount;
    final index = angle ~/ segmentAngle;
    return index.clamp(0, segmentCount - 1);
  }
}
