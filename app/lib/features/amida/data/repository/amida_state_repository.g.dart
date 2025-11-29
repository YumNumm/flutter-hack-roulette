// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'amida_state_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(amidaStateRepository)
const amidaStateRepositoryProvider = AmidaStateRepositoryProvider._();

final class AmidaStateRepositoryProvider
    extends
        $FunctionalProvider<
          AmidaStateRepository,
          AmidaStateRepository,
          AmidaStateRepository
        >
    with $Provider<AmidaStateRepository> {
  const AmidaStateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'amidaStateRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$amidaStateRepositoryHash();

  @$internal
  @override
  $ProviderElement<AmidaStateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AmidaStateRepository create(Ref ref) {
    return amidaStateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AmidaStateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AmidaStateRepository>(value),
    );
  }
}

String _$amidaStateRepositoryHash() =>
    r'ce0eb98967393eba3d91f630c871edb4b159db64';
