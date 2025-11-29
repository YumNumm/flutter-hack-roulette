import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:roulette/features/pinball/ui/page/pinball_game_page.dart';
import 'package:roulette/features/pinball/ui/page/result_page.dart';
import 'package:roulette/features/pinball/ui/page/team_management_page.dart';

part 'main.g.dart';

@TypedGoRoute<TeamManagementRoute>(
  path: '/',
  routes: [
    TypedGoRoute<PinballRoute>(
      path: 'pinball',
    ),
    TypedGoRoute<ResultRoute>(
      path: 'result',
    ),
  ],
)
class TeamManagementRoute extends GoRouteData with $TeamManagementRoute {
  const TeamManagementRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TeamManagementPage();
  }
}

class PinballRoute extends GoRouteData with $PinballRoute {
  const PinballRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PinballGamePage();
  }
}

class ResultRoute extends GoRouteData with $ResultRoute {
  const ResultRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ResultPage();
  }
}
