import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roulette/features/amida/data/model/amida_ladder.dart';
import 'package:roulette/features/amida/data/model/amida_path.dart';
import 'package:roulette/features/amida/data/model/amida_result.dart';
import 'package:roulette/features/amida/data/model/presentation_state.dart';
import 'package:roulette/features/amida/data/model/team.dart';
import 'package:roulette/features/amida/data/repository/amida_state_repository.dart';
import 'package:roulette/features/amida/data/service/amida_generator.dart';

part 'amida_state_notifier.freezed.dart';
part 'amida_state_notifier.g.dart';

@freezed
class AmidaState with _$AmidaState {
  const factory AmidaState({
    AmidaLadder? ladder,
    AmidaResult? result,
    @Default(PresentationState.initial) PresentationState presentationState,
    List<AmidaPath>? paths,
  }) = _AmidaState;

  const AmidaState._();

  bool get hasLadder => ladder != null;
  bool get hasResult => result != null;
  bool get isPresenting =>
      presentationState.status == PresentationStatus.presenting;
  bool get isCompleted =>
      presentationState.status == PresentationStatus.completed;
}

@riverpod
class AmidaStateNotifier extends _$AmidaStateNotifier {
  @override
  Future<AmidaState> build() async {
    final repository = ref.watch(amidaStateRepositoryProvider);
    
    final ladder = await repository.getLadder();
    final result = await repository.getResult();
    final presentationState = await repository.getPresentationState();

    List<AmidaPath>? paths;
    if (ladder != null) {
      final generator = AmidaGenerator();
      paths = generator.calculatePaths(ladder);
    }

    return AmidaState(
      ladder: ladder,
      result: result,
      presentationState: presentationState,
      paths: paths,
    );
  }

  Future<void> generateAmida(List<Team> teams) async {
    if (teams.length < 2) {
      throw ArgumentError('At least 2 teams are required');
    }

    final generator = AmidaGenerator();
    final ladder = generator.generateLadder(teams.length);
    final paths = generator.calculatePaths(ladder);
    final resultOrder = generator.calculateResultOrder(ladder);

    final result = AmidaResult(
      teamIds: teams.map((t) => t.id).toList(),
      resultOrder: resultOrder,
      generatedAt: DateTime.now(),
    );

    final repository = ref.read(amidaStateRepositoryProvider);
    await repository.saveLadder(ladder);
    await repository.saveResult(result);
    await repository.savePresentationState(PresentationState.initial);

    state = AsyncData(
      AmidaState(
        ladder: ladder,
        result: result,
        presentationState: PresentationState.initial,
        paths: paths,
      ),
    );
  }

  Future<void> startPresentation() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasResult) {
      return;
    }

    const newPresentationState = PresentationState(
      currentIndex: 0,
      status: PresentationStatus.presenting,
    );

    final repository = ref.read(amidaStateRepositoryProvider);
    await repository.savePresentationState(newPresentationState);

    state = AsyncData(
      currentState.copyWith(presentationState: newPresentationState),
    );
  }

  Future<void> showNextTeam() async {
    final currentState = state.value;
    if (currentState == null || currentState.result == null) {
      return;
    }

    final currentIndex = currentState.presentationState.currentIndex;
    final totalTeams = currentState.result!.teamIds.length;

    if (currentIndex >= totalTeams - 1) {
      const completedState = PresentationState(
        currentIndex: -1,
        status: PresentationStatus.completed,
      );

      final repository = ref.read(amidaStateRepositoryProvider);
      await repository.savePresentationState(completedState);

      state = AsyncData(
        currentState.copyWith(presentationState: completedState),
      );
      return;
    }

    final newPresentationState = PresentationState(
      currentIndex: currentIndex + 1,
      status: PresentationStatus.presenting,
    );

    final repository = ref.read(amidaStateRepositoryProvider);
    await repository.savePresentationState(newPresentationState);

    state = AsyncData(
      currentState.copyWith(presentationState: newPresentationState),
    );
  }

  Future<void> reset() async {
    final repository = ref.read(amidaStateRepositoryProvider);
    await repository.resetAll();

    state = const AsyncData(AmidaState());
  }
}

