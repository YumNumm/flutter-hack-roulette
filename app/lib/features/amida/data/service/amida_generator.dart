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

    // 各高さのレベルで横線を配置
    for (var i = 0; i < horizontalLineCount; i++) {
      final yPosition = (i + 1) / (horizontalLineCount + 1);

      // この高さで使用可能な列を追跡（連続しないようにする）
      final availableColumns = <int>[];
      for (var col = 0; col < teamCount - 1; col++) {
        availableColumns.add(col);
      }

      // この高さに1本以上の横線を配置（ランダムに決定）
      // 最大で (teamCount - 1) / 2 本まで配置可能
      final maxLines = (teamCount - 1) ~/ 2;
      final lineCount = random.nextInt(maxLines) + 1;

      for (var j = 0; j < lineCount && availableColumns.isNotEmpty; j++) {
        final selectedIndex =
            availableColumns[random.nextInt(availableColumns.length)];

        horizontalLines.add(
          HorizontalLine(
            leftIndex: selectedIndex,
            rightIndex: selectedIndex + 1,
            yPosition: yPosition,
          ),
        );

        // この列と隣接する列を使用不可にする
        availableColumns.removeWhere(
          (col) =>
              col == selectedIndex ||
              col == selectedIndex - 1 ||
              col == selectedIndex + 1,
        );
      }
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
