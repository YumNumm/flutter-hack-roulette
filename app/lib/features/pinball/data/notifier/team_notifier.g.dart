// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'team_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TeamNotifier)
const teamProvider = TeamNotifierProvider._();

final class TeamNotifierProvider
    extends $AsyncNotifierProvider<TeamNotifier, List<Team>> {
  const TeamNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamNotifierHash();

  @$internal
  @override
  TeamNotifier create() => TeamNotifier();
}

String _$teamNotifierHash() => r'081c46417016abaddb44148018c1595a76fe2b33';

abstract class _$TeamNotifier extends $AsyncNotifier<List<Team>> {
  FutureOr<List<Team>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Team>>, List<Team>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Team>>, List<Team>>,
              AsyncValue<List<Team>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
