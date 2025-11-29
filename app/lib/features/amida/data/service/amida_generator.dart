import 'dart:math';

import 'package:roulette/features/amida/data/model/amida_ladder.dart';
import 'package:roulette/features/amida/data/model/amida_path.dart';

class AmidaGenerator {
  AmidaGenerator({
    this.horizontalLineCount = 30,
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
      // Y位置を完全にランダムにする（重ならないように）
      final yPosition = (i + 1 + random.nextDouble() * 0.8 - 0.4) /
          (horizontalLineCount + 1);

      // この高さで使用可能な列を追跡（連続しないようにする）
      final availableColumns = <int>[];
      for (var col = 0; col < teamCount - 1; col++) {
        availableColumns.add(col);
      }

      // この高さに横線を配置するかどうかをランダムに決定（70%の確率で配置）
      if (random.nextDouble() > 0.3) {
        // 最大で (teamCount - 1) / 2 本まで配置可能
        final maxLines = (teamCount - 1) ~/ 2;
        // 配置する線の本数もランダムに（1本が多め）
        final lineCount = random.nextDouble() < 0.7
            ? 1
            : random.nextInt(maxLines.clamp(1, 3)) + 1;

        for (var j = 0; j < lineCount && availableColumns.isNotEmpty; j++) {
          final selectedIndex =
              availableColumns[random.nextInt(availableColumns.length)];

          horizontalLines.add(
            HorizontalLine(
              leftIndex: selectedIndex,
              rightIndex: selectedIndex + 1,
              yPosition: yPosition.clamp(0.0, 1.0),
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
