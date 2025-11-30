// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'team_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TeamRepository)
const teamRepositoryProvider = TeamRepositoryProvider._();

final class TeamRepositoryProvider
    extends $NotifierProvider<TeamRepository, List<Team>> {
  const TeamRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamRepositoryHash();

  @$internal
  @override
  TeamRepository create() => TeamRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Team> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Team>>(value),
    );
  }
}

String _$teamRepositoryHash() => r'f47adfee5340d575f5c94ee1563981e066779ddc';

abstract class _$TeamRepository extends $Notifier<List<Team>> {
  List<Team> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Team>, List<Team>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Team>, List<Team>>,
              List<Team>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
