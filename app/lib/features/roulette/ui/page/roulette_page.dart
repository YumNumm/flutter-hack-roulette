import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/roulette/data/model/roulette_state.dart';
import 'package:template/features/roulette/data/model/team.dart';
import 'package:template/features/roulette/data/notifier/roulette_notifier.dart';
import 'package:template/features/roulette/data/repository/team_repository.dart';
import 'package:template/features/roulette/ui/components/roulette_scene.dart';

class RoulettePage extends ConsumerWidget {
  const RoulettePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamRepositoryProvider);
    final unselectedTeams = teams
        .where((t) => t.selectedOrder == null)
        .toList();
    final teamRepository = ref.read(teamRepositoryProvider.notifier);
    final rouletteState = ref.watch(rouletteProvider);
    final rouletteNotifier = ref.read(rouletteProvider.notifier);

    if (unselectedTeams.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.pushReplacement('/result');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentRound = teams.length - unselectedTeams.length + 1;
    final totalRounds = teams.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('ルーレット ($currentRound/$totalRounds)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          RouletteScene(teams: unselectedTeams),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: _buildControlButton(
                context,
                ref,
                rouletteState,
                rouletteNotifier,
                teamRepository,
                unselectedTeams,
                currentRound,
              ),
            ),
          ),
          if (rouletteState.status == RouletteStatus.stopped &&
              rouletteState.selectedTeamIndex != null)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '選ばれたチーム',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          unselectedTeams[rouletteState.selectedTeamIndex!]
                              .name,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context,
    WidgetRef ref,
    RouletteState rouletteState,
    RouletteNotifier rouletteNotifier,
    TeamRepository teamRepository,
    List<Team> unselectedTeams,
    int currentRound,
  ) {
    switch (rouletteState.status) {
      case RouletteStatus.idle:
        return ElevatedButton(
          onPressed: () {
            rouletteNotifier.startSpin(unselectedTeams.length);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: const Text('スタート'),
        );
      case RouletteStatus.spinning:
      case RouletteStatus.stopping:
        return const SizedBox.shrink();
      case RouletteStatus.stopped:
        return ElevatedButton(
          onPressed: () {
            final selectedIndex = rouletteNotifier.calculateSelectedIndex(
              unselectedTeams.length,
            );
            if (selectedIndex >= 0 && selectedIndex < unselectedTeams.length) {
              final selectedTeam = unselectedTeams[selectedIndex];
              teamRepository.updateTeamOrder(selectedTeam.id, currentRound - 1);
            }
            rouletteNotifier.reset();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: const Text('次へ'),
        );
    }
  }
}
