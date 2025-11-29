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
import 'package:roulette/features/amida/ui/components/result_modal.dart';
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
          foregroundColor: Colors.white,
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

              if (confirmed ?? false) {
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
    final hasShownModal = useState(false);

    useEffect(
      () {
        if (amidaState.presentationState.status ==
            PresentationStatus.presenting) {
          final index = amidaState.presentationState.currentIndex;
          if (index >= 0 && index < teams.length) {
            currentTeamIndex.value = index;
            hasShownModal.value = false;
            animationController.forward(from: 0);
          }
        }
        return null;
      },
      [amidaState.presentationState],
    );

    useEffect(
      () {
        if (animation >= 1 &&
            !hasShownModal.value &&
            currentTeamIndex.value != null &&
            amidaState.presentationState.status ==
                PresentationStatus.presenting) {
          hasShownModal.value = true;

          final index = currentTeamIndex.value!;
          final team = teams[index];
          final path = amidaState.paths![index];
          final order = path.endIndex + 1;
          final isLast = index >= teams.length - 1;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (context) => ResultModal(
                  teamName: team.name,
                  order: order,
                  isLast: isLast,
                ),
              ).then((_) async {
                if (context.mounted) {
                  await ref
                      .read(amidaStateProvider.notifier)
                      .showNextTeam();
                }
              });
            }
          });
        }
        return null;
      },
      [animation, hasShownModal.value, currentTeamIndex.value],
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
              }
            },
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.3),
              child: CustomPaint(
                painter: AmidaPainter(
                  ladder: amidaState.ladder!,
                  teamCount: teams.length,
                  currentPath: currentPath,
                  animationProgress: animation,
                ),
                child: Stack(
                  children: [
                    _TopNumbers(teamCount: teams.length),
                    _BottomTeamNames(teams: teams),
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

class _TopNumbers extends StatelessWidget {
  const _TopNumbers({required this.teamCount});

  final int teamCount;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: AmidaPainter.topPadding,
      child: Row(
        children: List.generate(
          teamCount,
          (index) {
            return Expanded(
              child: Center(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.8),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.8),
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
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

class _BottomTeamNames extends StatelessWidget {
  const _BottomTeamNames({required this.teams});

  final List<Team> teams;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: AmidaPainter.bottomPadding,
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.8),
                          offset: const Offset(1, 1),
                          blurRadius: 3,
                        ),
                      ],
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
            Text(
              '画面をタップして発表を開始',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${teams.length}チームの登壇順を決定します',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (status == PresentationStatus.presenting) {
      final team = teams[currentIndex];

      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900.withValues(alpha: 0.5),
              Colors.purple.shade900.withValues(alpha: 0.5),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              team.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: animationProgress,
              minHeight: 8,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.8),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  team.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.8),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
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
