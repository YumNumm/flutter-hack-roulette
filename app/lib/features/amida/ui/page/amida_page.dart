import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/features/amida/data/model/presentation_state.dart';
import 'package:roulette/features/amida/data/model/team.dart';
import 'package:roulette/features/amida/data/notifier/amida_state_notifier.dart';
import 'package:roulette/features/amida/data/notifier/team_notifier.dart';
import 'package:roulette/features/amida/ui/components/amida_painter.dart';
import 'package:roulette/features/amida/ui/components/hologram_card.dart';
import 'package:roulette/features/amida/ui/components/hologram_text.dart';
import 'package:roulette/features/amida/ui/components/shader_background.dart';

class AmidaPage extends HookConsumerWidget {
  const AmidaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amidaStateAsync = ref.watch(amidaStateProvider);
    final teamsAsync = ref.watch(teamProvider);

    return ShaderBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.3),
          title: const Text('あみだくじ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('リセット'),
                  content: const Text('あみだくじをリセットしますか？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('リセット'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                await ref.read(amidaStateProvider.notifier).reset();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
      body: amidaStateAsync.when(
        data: (amidaState) {
          if (!amidaState.hasLadder) {
            return const Center(
              child: Text('あみだくじが生成されていません'),
            );
          }

          return teamsAsync.when(
            data: (teams) => _AmidaView(
              amidaState: amidaState,
              teams: teams,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('エラー: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラー: $error')),
      ),
    ),
    );
  }
}

class _AmidaView extends HookConsumerWidget {
  const _AmidaView({
    required this.amidaState,
    required this.teams,
  });

  final AmidaState amidaState;
  final List<Team> teams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 3),
    );
    final animation = useAnimation(animationController);

    final currentTeamIndex = useState<int?>(null);

    useEffect(
      () {
        if (amidaState.presentationState.status ==
            PresentationStatus.presenting) {
          final index = amidaState.presentationState.currentIndex;
          if (index >= 0 && index < teams.length) {
            currentTeamIndex.value = index;
            animationController.forward(from: 0);
          }
        }
        return null;
      },
      [amidaState.presentationState],
    );

    final currentPath = currentTeamIndex.value != null &&
            amidaState.paths != null &&
            currentTeamIndex.value! < amidaState.paths!.length
        ? amidaState.paths![currentTeamIndex.value!]
        : null;

    return Column(
      children: [
        Expanded(
            child: GestureDetector(
            onTap: () async {
              if (amidaState.presentationState.status ==
                  PresentationStatus.notStarted) {
                await ref
                    .read(amidaStateProvider.notifier)
                    .startPresentation();
              } else if (amidaState.presentationState.status ==
                      PresentationStatus.presenting &&
                  animation >= 1) {
                await ref
                    .read(amidaStateProvider.notifier)
                    .showNextTeam();
              }
            },
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.1),
              child: CustomPaint(
                painter: AmidaPainter(
                  ladder: amidaState.ladder!,
                  teamCount: teams.length,
                  currentPath: currentPath,
                  animationProgress: animation,
                ),
                child: Stack(
                  children: [
                    _TeamLabels(teams: teams),
                  ],
                ),
              ),
            ),
          ),
        ),
        _BottomPanel(
          amidaState: amidaState,
          teams: teams,
          animationProgress: animation,
        ),
      ],
    );
  }
}

class _TeamLabels extends StatelessWidget {
  const _TeamLabels({required this.teams});

  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: AmidaPainter.topPadding,
      child: Row(
        children: List.generate(
          teams.length,
          (index) {
            final team = teams[index];
            return Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    team.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BottomPanel extends HookConsumerWidget {
  const _BottomPanel({
    required this.amidaState,
    required this.teams,
    required this.animationProgress,
  });

  final AmidaState amidaState;
  final List<Team> teams;
  final double animationProgress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = amidaState.presentationState.status;
    final currentIndex = amidaState.presentationState.currentIndex;

    if (status == PresentationStatus.notStarted) {
      return Container(
        padding: const EdgeInsets.all(24),
        color: Colors.grey.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '画面をタップして発表を開始',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${teams.length}チームの登壇順を決定します',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ),
      );
    }

    if (status == PresentationStatus.presenting) {
      final team = teams[currentIndex];
      final path = amidaState.paths![currentIndex];
      final order = path.endIndex + 1;

      if (animationProgress >= 1) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900.withValues(alpha: 0.3),
                Colors.purple.shade900.withValues(alpha: 0.3),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HologramCard(
                color: Colors.cyan,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      HologramText(
                        text: '第${order}番目',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      HologramText(
                        text: team.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'タップして次へ',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.all(24),
        color: Colors.grey.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              team.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: animationProgress,
              minHeight: 8,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade900.withValues(alpha: 0.3),
            Colors.teal.shade900.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            size: 48,
            color: Colors.green,
          ),
          const SizedBox(height: 8),
              const HologramText(
                text: '発表完了！',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          const SizedBox(height: 16),
          _ResultList(amidaState: amidaState, teams: teams),
        ],
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  const _ResultList({
    required this.amidaState,
    required this.teams,
  });

  final AmidaState amidaState;
  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    if (amidaState.paths == null) {
      return const SizedBox.shrink();
    }

    final orderedTeams = List.generate(teams.length, (index) {
      final path = amidaState.paths!.firstWhere((p) => p.endIndex == index);
      return teams[path.startIndex];
    });

    return Column(
      children: List.generate(
        orderedTeams.length,
        (index) {
          final team = orderedTeams[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    '${index + 1}.',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    team.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
