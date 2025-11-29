import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/features/pinball/data/notifier/team_notifier.dart';

class ResultPage extends HookConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(teamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('登壇順結果'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await ref.read(teamProvider.notifier).clearAllResults();
              if (context.mounted) {
                context.go('/');
              }
            },
          ),
        ],
      ),
      body: teamsAsync.when(
        data: (teams) {
          // 穴番号でソート
          final sortedTeams = List.from(teams)
            ..sort((a, b) {
              if (a.holeNumber == null) {
                return 1;
              }
              if (b.holeNumber == null) {
                return -1;
              }
              return a.holeNumber!.compareTo(b.holeNumber!);
            });

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.secondaryContainer,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: 64,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '登壇順が決定しました！',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sortedTeams.length,
                  itemBuilder: (context, index) {
                    final team = sortedTeams[index];

                    if (team.holeNumber == null) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.help, color: Colors.white),
                          ),
                          title: Text(team.name),
                          subtitle: const Text('未プレイ'),
                        ),
                      );
                    }

                    final medalColor = index == 0
                        ? Colors.amber.shade700
                        : index == 1
                            ? Colors.grey.shade400
                            : index == 2
                                ? Colors.brown.shade400
                                : Colors.blue;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: index < 3 ? 8 : 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: medalColor,
                          child: index < 3
                              ? const Icon(
                                  Icons.emoji_events,
                                  color: Colors.white,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        title: Text(
                          team.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: index < 3
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text('穴番号: ${team.holeNumber}'),
                        trailing: Text(
                          '${index + 1}番目',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: medalColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.go('/'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Text('チーム管理に戻る'),
                      ),
                    ),
                  ],
                ),
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

