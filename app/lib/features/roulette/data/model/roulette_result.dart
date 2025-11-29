import 'package:freezed_annotation/freezed_annotation.dart';

part 'roulette_result.freezed.dart';
part 'roulette_result.g.dart';

@freezed
abstract class RouletteResult with _$RouletteResult {
  const factory RouletteResult({
    required String teamId,
    required int selectedOrder,
    required DateTime timestamp,
  }) = _RouletteResult;

  factory RouletteResult.fromJson(Map<String, dynamic> json) =>
      _$RouletteResultFromJson(json);
}
