import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:roulette/features/amida/ui/page/amida_page.dart';
import 'package:roulette/features/amida/ui/page/team_management_page.dart';

part 'main.g.dart';

@TypedGoRoute<TeamManagementRoute>(
  path: '/',
  routes: [
    TypedGoRoute<AmidaRoute>(
      path: 'amida',
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

class AmidaRoute extends GoRouteData with $AmidaRoute {
  const AmidaRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AmidaPage();
  }
}
