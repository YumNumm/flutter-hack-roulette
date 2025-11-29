import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        ],
      ),
    );
  }
}
