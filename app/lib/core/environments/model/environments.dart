import 'package:freezed_annotation/freezed_annotation.dart';

part 'environments.freezed.dart';
part 'environments.g.dart';

@freezed
abstract class Environments with _$Environments {
  const factory Environments({
    required Flavor flavor,
    required String appIdSuffix,
    required String appName,
  }) = _Environments;

  factory Environments.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentsFromJson(json);
}

enum Flavor {
  dev,
  prod,
}
