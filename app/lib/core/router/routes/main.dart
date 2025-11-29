import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:template/features/home/ui/page/home_page.dart';

part 'main.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}
