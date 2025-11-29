// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'pinball_game_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PinballGameNotifier)
const pinballGameProvider = PinballGameNotifierProvider._();

final class PinballGameNotifierProvider
    extends $NotifierProvider<PinballGameNotifier, GameState> {
  const PinballGameNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinballGameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinballGameNotifierHash();

  @$internal
  @override
  PinballGameNotifier create() => PinballGameNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameState>(value),
    );
  }
}

String _$pinballGameNotifierHash() =>
    r'1af38a88d621cd40ce486f5adc958b1430257d24';

abstract class _$PinballGameNotifier extends $Notifier<GameState> {
  GameState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GameState, GameState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GameState, GameState>,
              GameState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
