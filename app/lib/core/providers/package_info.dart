import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info.g.dart';

@riverpod
PackageInfo packageInfo(Ref ref) =>
    ref.watch(packageInfoInternalProvider).requireValue;

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfoInternal(Ref ref) => PackageInfo.fromPlatform();
