import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:template/features/roulette/ui/page/result_page.dart';
import 'package:template/features/roulette/ui/page/roulette_page.dart';
import 'package:template/features/roulette/ui/page/team_setup_page.dart';

part 'main.g.dart';

@TypedGoRoute<TeamSetupRoute>(
  path: '/',
)
class TeamSetupRoute extends GoRouteData with $TeamSetupRoute {
  const TeamSetupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TeamSetupPage();
  }
}

@TypedGoRoute<RouletteRoute>(
  path: '/roulette',
)
class RouletteRoute extends GoRouteData with $RouletteRoute {
  const RouletteRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RoulettePage();
  }
}

@TypedGoRoute<ResultRoute>(
  path: '/result',
)
class ResultRoute extends GoRouteData with $ResultRoute {
  const ResultRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ResultPage();
  }
}
