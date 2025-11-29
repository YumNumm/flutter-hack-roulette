// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'result_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resultRepository)
const resultRepositoryProvider = ResultRepositoryProvider._();

final class ResultRepositoryProvider
    extends
        $FunctionalProvider<
          ResultRepository,
          ResultRepository,
          ResultRepository
        >
    with $Provider<ResultRepository> {
  const ResultRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resultRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resultRepositoryHash();

  @$internal
  @override
  $ProviderElement<ResultRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResultRepository create(Ref ref) {
    return resultRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResultRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResultRepository>(value),
    );
  }
}

String _$resultRepositoryHash() => r'8d888d0db20183d6ce6b3ba3d6dd85c707d1e1f7';
