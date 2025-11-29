import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/core/providers/shared_preferences.dart';
import 'package:roulette/features/amida/data/model/amida_ladder.dart';
import 'package:roulette/features/amida/data/model/amida_result.dart';
import 'package:roulette/features/amida/data/model/presentation_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'amida_state_repository.g.dart';

@riverpod
AmidaStateRepository amidaStateRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AmidaStateRepository(prefs);
}


class AmidaStateRepository {
  AmidaStateRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _ladderKey = 'amida_ladder';
  static const _resultKey = 'amida_result';
  static const _presentationStateKey = 'amida_presentation_state';

  Future<AmidaLadder?> getLadder() async {
    final jsonString = _prefs.getString(_ladderKey);
    if (jsonString == null) {
      return null;
    }

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return AmidaLadder.fromJson(json);
  }

  Future<void> saveLadder(AmidaLadder ladder) async {
    final jsonString = jsonEncode(ladder.toJson());
    await _prefs.setString(_ladderKey, jsonString);
  }

  Future<AmidaResult?> getResult() async {
    final jsonString = _prefs.getString(_resultKey);
    if (jsonString == null) {
      return null;
    }

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return AmidaResult.fromJson(json);
  }

  Future<void> saveResult(AmidaResult result) async {
    final jsonString = jsonEncode(result.toJson());
    await _prefs.setString(_resultKey, jsonString);
  }

  Future<PresentationState> getPresentationState() async {
    final jsonString = _prefs.getString(_presentationStateKey);
    if (jsonString == null) {
      return PresentationState.initial;
    }

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return PresentationState.fromJson(json);
  }

  Future<void> savePresentationState(PresentationState state) async {
    final jsonString = jsonEncode(state.toJson());
    await _prefs.setString(_presentationStateKey, jsonString);
  }

  Future<void> resetAll() async {
    await Future.wait([
      _prefs.remove(_ladderKey),
      _prefs.remove(_resultKey),
      _prefs.remove(_presentationStateKey),
    ]);
  }
}

