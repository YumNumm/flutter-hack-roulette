import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/core/providers/shared_preferences.dart';
import 'package:roulette/features/pinball/data/model/pinball_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'result_repository.g.dart';

@riverpod
ResultRepository resultRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ResultRepository(sharedPreferences: prefs);
}

class ResultRepository {
  ResultRepository({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;
  static const _resultsKey = 'pinball_results';

  List<PinballResult> getResults() {
    final resultsJson = sharedPreferences.getString(_resultsKey);
    if (resultsJson == null) {
      return [];
    }

    final resultsList = jsonDecode(resultsJson) as List<dynamic>;
    return resultsList
        .map(
          (json) => PinballResult.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> saveResults(List<PinballResult> results) async {
    final resultsJson = jsonEncode(results.map((r) => r.toJson()).toList());
    await sharedPreferences.setString(_resultsKey, resultsJson);
  }

  Future<void> addResult(PinballResult result) async {
    final results = getResults();
    results.add(result);
    await saveResults(results);
  }

  Future<void> clearResults() async {
    await sharedPreferences.remove(_resultsKey);
  }
}
