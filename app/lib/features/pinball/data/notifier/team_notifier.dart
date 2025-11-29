import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/features/pinball/data/model/team.dart';
import 'package:roulette/features/pinball/data/repository/team_repository.dart';

part 'team_notifier.g.dart';

@riverpod
class TeamNotifier extends _$TeamNotifier {
  @override
  Future<List<Team>> build() async {
    return ref.read(teamRepositoryProvider).getTeams();
  }

  Future<void> addTeam(String name) async {
    await ref.read(teamRepositoryProvider).addTeam(name);
    ref.invalidateSelf();
  }

  Future<void> removeTeam(String id) async {
    await ref.read(teamRepositoryProvider).removeTeam(id);
    ref.invalidateSelf();
  }

  Future<void> updateTeam(Team team) async {
    await ref.read(teamRepositoryProvider).updateTeam(team);
    ref.invalidateSelf();
  }

  Future<void> assignHoleNumber(String teamId, int holeNumber) async {
    await ref.read(teamRepositoryProvider).assignHoleNumber(teamId, holeNumber);
    ref.invalidateSelf();
  }

  Future<void> clearAllResults() async {
    await ref.read(teamRepositoryProvider).clearAllResults();
    ref.invalidateSelf();
  }

  Future<void> calculatePresentationOrder() async {
    await ref.read(teamRepositoryProvider).calculatePresentationOrder();
    ref.invalidateSelf();
  }
}
