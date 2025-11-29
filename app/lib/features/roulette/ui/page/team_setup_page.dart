import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/roulette/data/repository/team_repository.dart';
import 'package:template/features/roulette/ui/components/team_list.dart';

class TeamSetupPage extends HookConsumerWidget {
  const TeamSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamRepositoryProvider);
    final teamRepository = ref.read(teamRepositoryProvider.notifier);
    final nameController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('チーム登録'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'チーム名',
                      border: OutlineInputBorder(),
                      hintText: 'チーム名を入力',
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        teamRepository.addTeam(value.trim());
                        nameController.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isNotEmpty) {
                      teamRepository.addTeam(nameController.text.trim());
                      nameController.clear();
                    }
                  },
                  child: const Text('追加'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TeamList(
              teams: teams,
              onRemove: teamRepository.removeTeam,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: teams.length >= 2
                    ? () {
                        teamRepository.resetOrders();
                        context.push('/roulette');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('ルーレット開始'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
