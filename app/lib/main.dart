import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roulette/app.dart';
import 'package:roulette/core/gen/i18n/translations.g.dart';
import 'package:roulette/core/providers/package_info.dart';
import 'package:roulette/core/providers/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(
    .edgeToEdge,
    overlays: [.top],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ),
  );

  final container = ProviderContainer();

  await Future.wait([
    container.read(packageInfoInternalProvider.future),
    container.read(sharedPreferencesInternalProvider.future),
  ]);

  runApp(
    TranslationProvider(
      child: UncontrolledProviderScope(
        container: container,
        child: const App(),
      ),
    ),
  );
}
