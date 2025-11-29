import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/features/amida/data/model/team.dart';
import 'package:roulette/features/amida/data/repository/team_repository.dart';

part 'team_notifier.g.dart';

@riverpod
class TeamNotifier extends _$TeamNotifier {
  @override
  Future<List<Team>> build() {
    final repository = ref.watch(teamRepositoryProvider);
    return repository.getTeams();
  }


  Future<void> addTeam(String name) async {
    final repository = ref.read(teamRepositoryProvider);
    final team = Team(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );

    await repository.addTeam(team);
    ref.invalidateSelf();
  }

  Future<void> removeTeam(String teamId) async {
    final repository = ref.read(teamRepositoryProvider);
    await repository.removeTeam(teamId);
    ref.invalidateSelf();
  }

  Future<void> clearAll() async {
    final repository = ref.read(teamRepositoryProvider);
    await repository.clearTeams();
    ref.invalidateSelf();
  }
}
