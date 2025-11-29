import 'package:freezed_annotation/freezed_annotation.dart';

part 'pinball_result.freezed.dart';
part 'pinball_result.g.dart';

@freezed
abstract class PinballResult with _$PinballResult {
  const factory PinballResult({
    required String teamId,
    required int holeNumber,
    required DateTime timestamp,
  }) = _PinballResult;

  factory PinballResult.fromJson(Map<String, dynamic> json) =>
      _$PinballResultFromJson(json);
}
