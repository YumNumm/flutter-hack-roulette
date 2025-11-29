import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template/features/roulette/data/model/team.dart';

part 'team_repository.g.dart';

@riverpod
class TeamRepository extends _$TeamRepository {
  @override
  List<Team> build() {
    return [];
  }

  void addTeam(String name) {
    final newTeam = Team(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    state = [...state, newTeam];
  }

  void removeTeam(String id) {
    state = state.where((team) => team.id != id).toList();
  }

  void updateTeamOrder(String id, int order) {
    state = state.map((team) {
      if (team.id == id) {
        return team.copyWith(selectedOrder: order);
      }
      return team;
    }).toList();
  }

  void resetOrders() {
    state = state.map((team) => team.copyWith(selectedOrder: null)).toList();
  }

  List<Team> getUnselectedTeams() {
    return state.where((team) => team.selectedOrder == null).toList();
  }

  List<Team> getSelectedTeams() {
    final selected = state.where((team) => team.selectedOrder != null).toList();
    selected.sort((a, b) => a.selectedOrder!.compareTo(b.selectedOrder!));
    return selected;
  }
}
