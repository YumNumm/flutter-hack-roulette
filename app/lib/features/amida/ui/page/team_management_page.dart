import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/features/amida/data/model/team.dart';
import 'package:roulette/features/amida/data/notifier/amida_state_notifier.dart';
import 'package:roulette/features/amida/data/notifier/team_notifier.dart';
import 'package:roulette/features/amida/ui/components/shader_background.dart';

class TeamManagementPage extends HookConsumerWidget {
  const TeamManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(teamProvider);
    final amidaStateAsync = ref.watch(amidaStateProvider);

    return ShaderBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.3),
          foregroundColor: Colors.white,
          title: const Text('ハッカソン登壇順決定'),
        actions: [
          if (amidaStateAsync.hasValue &&
              (amidaStateAsync.value?.hasLadder ?? false))
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
                  await ref
                      .read(amidaStateProvider.notifier)
                      .reset();
                }
              },
            ),
        ],
      ),
      body: teamsAsync.when(
        data: (teams) => _TeamList(teams: teams),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラー: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTeamDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    ),
    );
  }

  Future<void> _showAddTeamDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('チーム追加'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'チーム名',
            hintText: 'チーム名を入力',
          ),
          autofocus: true,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              ref.read(teamProvider.notifier).addTeam(value);
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref
                    .read(teamProvider.notifier)
                    .addTeam(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );

    controller.dispose();
  }
}

class _TeamList extends HookConsumerWidget {
  const _TeamList({required this.teams});

  final List<Team> teams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amidaStateAsync = ref.watch(amidaStateProvider);
    final amidaState =
        amidaStateAsync.hasValue ? amidaStateAsync.value : null;

    if (teams.isEmpty) {
      return Center(
        child: Text(
          'チームを追加してください\n（右下の + ボタンから追加）',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
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
      );
    }

    return Column(
      children: [
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
                color: Colors.black.withValues(alpha: 0.6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade700,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    team.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white70),
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
        if (teams.length >= 2)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (amidaState?.hasLadder ?? false)
                  ElevatedButton(
                    onPressed: () => context.push('/amida'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      '結果を見る',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(amidaStateProvider.notifier)
                          .generateAmida(teams);
                      if (context.mounted) {
                        await context.push('/amida');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'あみだくじを開始',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  '登録チーム数: ${teams.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
