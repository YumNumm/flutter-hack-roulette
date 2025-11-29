import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferencesInternal(
  Ref ref,
) {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  return ref.watch(sharedPreferencesInternalProvider).requireValue;
}


