import 'dart:math';

import 'package:roulette/features/amida/data/model/amida_ladder.dart';
import 'package:roulette/features/amida/data/model/amida_path.dart';

class AmidaGenerator {
  AmidaGenerator({
    this.horizontalLineCount = 20,
    this.seed,
  });

  final int horizontalLineCount;
  final int? seed;

  AmidaLadder generateLadder(int teamCount) {
    if (teamCount < 2) {
      throw ArgumentError('Team count must be at least 2');
    }

    final random = seed != null ? Random(seed) : Random();
    final horizontalLines = <HorizontalLine>[];

    for (var i = 0; i < horizontalLineCount; i++) {
      final yPosition = (i + 1) / (horizontalLineCount + 1);

      final leftIndex = random.nextInt(teamCount - 1);
      horizontalLines.add(
        HorizontalLine(
          leftIndex: leftIndex,
          rightIndex: leftIndex + 1,
          yPosition: yPosition,
        ),
      );
    }

    return AmidaLadder(
      teamCount: teamCount,
      horizontalLines: horizontalLines,
    );
  }

  List<AmidaPath> calculatePaths(AmidaLadder ladder) {
    final paths = <AmidaPath>[];

    for (var startIndex = 0; startIndex < ladder.teamCount; startIndex++) {
      final path = _calculateSinglePath(ladder, startIndex);
      paths.add(path);
    }

    return paths;
  }

  AmidaPath _calculateSinglePath(AmidaLadder ladder, int startIndex) {
    var currentColumn = startIndex;
    final points = <PathPoint>[
      PathPoint(columnIndex: currentColumn, yPosition: 0),
    ];

    final sortedLines = List<HorizontalLine>.from(ladder.horizontalLines)
      ..sort((a, b) => a.yPosition.compareTo(b.yPosition));

    for (final line in sortedLines) {
      if (currentColumn == line.leftIndex) {
        points.add(
          PathPoint(
            columnIndex: currentColumn,
            yPosition: line.yPosition,
          ),
        );
        currentColumn = line.rightIndex;
        points.add(
          PathPoint(
            columnIndex: currentColumn,
            yPosition: line.yPosition,
          ),
        );
      } else if (currentColumn == line.rightIndex) {
        points.add(
          PathPoint(
            columnIndex: currentColumn,
            yPosition: line.yPosition,
          ),
        );
        currentColumn = line.leftIndex;
        points.add(
          PathPoint(
            columnIndex: currentColumn,
            yPosition: line.yPosition,
          ),
        );
      }
    }

    points.add(
      PathPoint(
        columnIndex: currentColumn,
        yPosition: 1,
      ),
    );

    return AmidaPath(
      startIndex: startIndex,
      endIndex: currentColumn,
      points: points,
    );
  }

  List<int> calculateResultOrder(AmidaLadder ladder) {
    final paths = calculatePaths(ladder);

    final resultOrder = List<int>.filled(ladder.teamCount, 0);
    for (var i = 0; i < paths.length; i++) {
      resultOrder[paths[i].endIndex] = i;
    }

    return resultOrder;
  }
}
