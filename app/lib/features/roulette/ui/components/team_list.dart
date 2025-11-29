import 'package:flutter/material.dart';
import 'package:template/features/roulette/data/model/team.dart';

class TeamList extends StatelessWidget {
  const TeamList({
    required this.teams,
    required this.onRemove,
    super.key,
  });

  final List<Team> teams;
  final void Function(String teamId) onRemove;

  @override
  Widget build(BuildContext context) {
    if (teams.isEmpty) {
      return const Center(
        child: Text(
          'チームを追加してください',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(
              team.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: team.selectedOrder != null
                ? Text('登壇順: ${team.selectedOrder! + 1}番目')
                : null,
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onRemove(team.id),
            ),
          ),
        );
      },
    );
  }
}
