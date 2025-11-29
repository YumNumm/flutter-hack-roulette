// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'amida_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AmidaStateNotifier)
const amidaStateProvider = AmidaStateNotifierProvider._();

final class AmidaStateNotifierProvider
    extends $AsyncNotifierProvider<AmidaStateNotifier, AmidaState> {
  const AmidaStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'amidaStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$amidaStateNotifierHash();

  @$internal
  @override
  AmidaStateNotifier create() => AmidaStateNotifier();
}

String _$amidaStateNotifierHash() =>
    r'ec51ed7e1e130c336e434fe4694b75d466ff8b27';

abstract class _$AmidaStateNotifier extends $AsyncNotifier<AmidaState> {
  FutureOr<AmidaState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AmidaState>, AmidaState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AmidaState>, AmidaState>,
              AsyncValue<AmidaState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
