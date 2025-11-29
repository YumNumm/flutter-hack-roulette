import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/features/pinball/data/model/game_state.dart';
import 'package:roulette/features/pinball/data/notifier/pinball_game_notifier.dart';
import 'package:roulette/features/pinball/data/notifier/team_notifier.dart';
import 'package:roulette/features/pinball/ui/components/flipper_controls.dart';
import 'package:roulette/features/pinball/ui/components/pinball_table_3d.dart';

class PinballGamePage extends HookConsumerWidget {
  const PinballGamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(pinballGameProvider);
    final teamsAsync = ref.watch(teamProvider);
    final currentTeamIndex = useState(0);
    final hasShownResultDialog = useState(false);

    // ゲーム開始
    useEffect(
      () {
        ref
            .read(pinballGameProvider.notifier)
            .startGame(currentTeamIndex.value);
        return null;
      },
      [],
    );

    // 穴に入った時の処理
    useEffect(
      () {
        if (gameState.status == GameStatus.ballInHole &&
            !hasShownResultDialog.value) {
          hasShownResultDialog.value = true;

          teamsAsync.whenData((teams) async {
            if (currentTeamIndex.value < teams.length) {
              final team = teams[currentTeamIndex.value];
              final holeNumber = gameState.lastHoleNumber!;

              // 穴番号を記録
              await ref
                  .read(teamProvider.notifier)
                  .assignHoleNumber(team.id, holeNumber);

              if (context.mounted) {
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text('結果'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.celebration,
                          size: 64,
                          color: Colors.amber.shade700,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          team.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '穴番号: $holeNumber',
                          style: const TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                    actions: [
                      if (currentTeamIndex.value < teams.length - 1)
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            currentTeamIndex.value++;
                            hasShownResultDialog.value = false;
                            ref
                                .read(pinballGameProvider.notifier)
                                .nextTeam();
                            ref
                                .read(pinballGameProvider.notifier)
                                .startGame(currentTeamIndex.value);
                          },
                          child: const Text('次のチーム'),
                        )
                      else
                        TextButton(
                          onPressed: () async {
                            await ref
                                .read(teamProvider.notifier)
                                .calculatePresentationOrder();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              context.go('/result');
                            }
                          },
                          child: const Text('結果を見る'),
                        ),
                    ],
                  ),
                );
              }
            }
          });
        }
        return null;
      },
      [gameState.status, gameState.lastHoleNumber],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ピンボール'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(pinballGameProvider.notifier).reset();
              currentTeamIndex.value = 0;
              hasShownResultDialog.value = false;
            },
          ),
        ],
      ),
      body: teamsAsync.when(
        data: (teams) {
          if (teams.isEmpty) {
            return const Center(
              child: Text('チームを追加してください'),
            );
          }

          final currentTeam = teams[currentTeamIndex.value];

          return Column(
            children: [
              // チーム情報
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    Text(
                      '現在のチーム',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      currentTeam.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      '${currentTeamIndex.value + 1} / ${teams.length}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // 3Dピンボールテーブル
              Expanded(
                flex: 3,
                child: ColoredBox(
                  color: Colors.black87,
                  child: PinballTable3D(
                    onHoleDetected: (holeNumber) {
                      ref
                          .read(pinballGameProvider.notifier)
                          .onBallInHole(holeNumber);
                    },
                  ),
                ),
              ),

              // 発射ボタン
              if (gameState.status == GameStatus.ready)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(pinballGameProvider.notifier)
                          .launchBall();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      '発射！',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),

              // フリッパーコントロール
              if (gameState.status == GameStatus.ballLaunched)
                FlipperControls(
                  onLeftFlipperPressed: () {
                    ref
                        .read(pinballGameProvider.notifier)
                        .setFlipperLeft(active: true);
                  },
                  onLeftFlipperReleased: () {
                    ref
                        .read(pinballGameProvider.notifier)
                        .setFlipperLeft(active: false);
                  },
                  onRightFlipperPressed: () {
                    ref
                        .read(pinballGameProvider.notifier)
                        .setFlipperRight(active: true);
                  },
                  onRightFlipperReleased: () {
                    ref
                        .read(pinballGameProvider.notifier)
                        .setFlipperRight(active: false);
                  },
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラー: $error')),
      ),
    );
  }
}

