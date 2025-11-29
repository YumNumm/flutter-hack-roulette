import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/core/providers/shared_preferences.dart';
import 'package:roulette/features/amida/data/model/team.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'team_repository.g.dart';

@riverpod
TeamRepository teamRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TeamRepository(prefs);
}


class TeamRepository {
  TeamRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _teamsKey = 'amida_teams';

  Future<List<Team>> getTeams() async {
    final jsonString = _prefs.getString(_teamsKey);
    if (jsonString == null) {
      return [];
    }

    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList
        .map((json) => Team.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTeams(List<Team> teams) async {
    final jsonList = teams.map((team) => team.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString(_teamsKey, jsonString);
  }

  Future<void> addTeam(Team team) async {
    final teams = await getTeams();
    teams.add(team);
    await saveTeams(teams);
  }

  Future<void> removeTeam(String teamId) async {
    final teams = await getTeams();
    teams.removeWhere((team) => team.id == teamId);
    await saveTeams(teams);
  }

  Future<void> clearTeams() async {
    await _prefs.remove(_teamsKey);
  }
}
