import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/features/pinball/data/notifier/team_notifier.dart';

class TeamManagementPage extends HookConsumerWidget {
  const TeamManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(teamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('チーム管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.casino),
            onPressed: () {
              teamsAsync.whenData((teams) {
                if (teams.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('チームを追加してください')),
                  );
                } else {
                  context.push('/pinball');
                }
              });
            },
          ),
        ],
      ),
      body: teamsAsync.when(
        data: (teams) {
          if (teams.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_add, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'チームを追加してください\n（右下の + ボタンから追加）',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '登録チーム数: ${teams.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (teams.any((t) => t.holeNumber != null))
                      TextButton.icon(
                        onPressed: () async {
                          await ref
                              .read(teamProvider.notifier)
                              .clearAllResults();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('リセット'),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final team = teams[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: team.holeNumber != null
                              ? Colors.green
                              : Colors.blue,
                          child: Text(
                            team.holeNumber?.toString() ?? '${index + 1}',
                          ),
                        ),
                        title: Text(
                          team.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: team.holeNumber != null
                            ? Text('穴番号: ${team.holeNumber}')
                            : null,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await ref
                                .read(teamProvider.notifier)
                                .removeTeam(team.id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('エラー: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTeamDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTeamDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('チーム名を入力'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'チーム名',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('追加'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty && context.mounted) {
      await ref.read(teamProvider.notifier).addTeam(result);
    }
  }
}
