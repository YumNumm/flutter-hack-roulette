// ignore_for_file: do_not_use_environment

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:template/core/environments/model/environments.dart';

part 'environments_provider.g.dart';

@Riverpod(keepAlive: true)
Environments environments(Ref ref) => Environments(
  appIdSuffix: const String.fromEnvironment('APP_ID_SUFFIX'),
  appName: const String.fromEnvironment('APP_NAME'),
  flavor: Flavor.values.firstWhere(
    (flavor) => flavor.name == const String.fromEnvironment('FLAVOR'),
  ),
);
