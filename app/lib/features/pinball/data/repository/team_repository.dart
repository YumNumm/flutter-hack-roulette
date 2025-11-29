import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/core/providers/shared_preferences.dart';
import 'package:roulette/features/pinball/data/model/team.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'team_repository.g.dart';

@riverpod
TeamRepository teamRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TeamRepository(prefs: prefs);
}

class TeamRepository {
  TeamRepository({
    required this.prefs,
  });

  final SharedPreferences prefs;
  static const _teamsKey = 'pinball_teams';
  static const _uuid = Uuid();

  List<Team> getTeams() {
    final teamsJson = prefs.getString(_teamsKey);
    if (teamsJson == null) {
      return [];
    }

    final teamsList = jsonDecode(teamsJson) as List<dynamic>;
    return teamsList
        .map((json) => Team.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTeams(List<Team> teams) async {
    final teamsJson = jsonEncode(teams.map((t) => t.toJson()).toList());
    await prefs.setString(_teamsKey, teamsJson);
  }

  Future<void> addTeam(String name) async {
    final teams = getTeams();
    final newTeam = Team(
      id: _uuid.v4(),
      name: name,
    );
    teams.add(newTeam);
    await saveTeams(teams);
  }

  Future<void> removeTeam(String id) async {
    final teams = getTeams();
    teams.removeWhere((t) => t.id == id);
    await saveTeams(teams);
  }

  Future<void> updateTeam(Team team) async {
    final teams = getTeams();
    final index = teams.indexWhere((t) => t.id == team.id);
    if (index != -1) {
      teams[index] = team;
      await saveTeams(teams);
    }
  }

  Future<void> assignHoleNumber(String teamId, int holeNumber) async {
    final teams = getTeams();
    final index = teams.indexWhere((t) => t.id == teamId);
    if (index != -1) {
      teams[index] = teams[index].copyWith(holeNumber: holeNumber);
      await saveTeams(teams);
    }
  }

  Future<void> clearAllResults() async {
    final teams = getTeams();
    final clearedTeams = teams
        .map(
          (t) => t.copyWith(
            holeNumber: null,
            presentationOrder: null,
          ),
        )
        .toList();
    await saveTeams(clearedTeams);
  }

  Future<void> calculatePresentationOrder() async {
    final teams = getTeams();
    // 穴番号でソート（小さい順が登壇順）
    final sortedTeams = List<Team>.from(teams)
      ..sort((a, b) {
        if (a.holeNumber == null) {
          return 1;
        }
        if (b.holeNumber == null) {
          return -1;
        }
        return a.holeNumber!.compareTo(b.holeNumber!);
      });

    // 登壇順を割り当て
    final updatedTeams = <Team>[];
    var order = 1;
    for (final team in sortedTeams) {
      if (team.holeNumber != null) {
        updatedTeams.add(team.copyWith(presentationOrder: order++));
      } else {
        updatedTeams.add(team);
      }
    }

    await saveTeams(updatedTeams);
  }
}
