// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'roulette_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RouletteNotifier)
const rouletteProvider = RouletteNotifierProvider._();

final class RouletteNotifierProvider
    extends $NotifierProvider<RouletteNotifier, RouletteState> {
  const RouletteNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rouletteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rouletteNotifierHash();

  @$internal
  @override
  RouletteNotifier create() => RouletteNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouletteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouletteState>(value),
    );
  }
}

String _$rouletteNotifierHash() => r'430a5254ce1460adb961c1731935f805efeba80c';

abstract class _$RouletteNotifier extends $Notifier<RouletteState> {
  RouletteState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RouletteState, RouletteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RouletteState, RouletteState>,
              RouletteState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
