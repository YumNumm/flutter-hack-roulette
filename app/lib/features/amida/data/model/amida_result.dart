import 'package:freezed_annotation/freezed_annotation.dart';

part 'amida_result.freezed.dart';
part 'amida_result.g.dart';

@freezed
class AmidaResult with _$AmidaResult {
  const factory AmidaResult({
    required List<String> teamIds,
    required List<int> resultOrder,
    required DateTime generatedAt,
  }) = _AmidaResult;

  factory AmidaResult.fromJson(Map<String, dynamic> json) =>
      _$AmidaResultFromJson(json);
}

