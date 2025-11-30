import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/features/roulette/data/model/team.dart';

part 'team_repository.g.dart';

@Riverpod(keepAlive: true)
class TeamRepository extends _$TeamRepository {
  static const _storageKey = 'roulette.teams';

  SharedPreferences? _prefs;
  bool _hasLoaded = false;

  Future<SharedPreferences> get _preferences async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  List<Team> build() {
    _loadTeams();
    return const [];
  }

  Future<void> _loadTeams() async {
    if (_hasLoaded) {
      return;
    }
    final prefs = await _preferences;
    final stored = prefs.getStringList(_storageKey);
    _hasLoaded = true;
    if (stored == null) {
      return;
    }
    final decoded = stored
        .map(
          (raw) => Team.fromJson(
            jsonDecode(raw) as Map<String, dynamic>,
          ),
        )
        .toList();
    state = decoded;
  }

  Future<void> _persist() async {
    final prefs = await _preferences;
    final serialized =
        state.map((team) => jsonEncode(team.toJson())).toList();
    await prefs.setStringList(_storageKey, serialized);
  }

  void addTeam(String name) {
    final newTeam = Team(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    state = [...state, newTeam];
    unawaited(_persist());
  }

  void removeTeam(String id) {
    state = state.where((team) => team.id != id).toList();
    unawaited(_persist());
  }

  void updateTeamOrder(String id, int order) {
    state = state.map((team) {
      if (team.id == id) {
        return team.copyWith(selectedOrder: order);
      }
      return team;
    }).toList();
    unawaited(_persist());
  }

  void resetOrders() {
    state = state.map((team) => team.copyWith(selectedOrder: null)).toList();
    unawaited(_persist());
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
