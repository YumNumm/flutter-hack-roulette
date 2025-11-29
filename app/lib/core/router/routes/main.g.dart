// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'main.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $teamSetupRoute,
  $rouletteRoute,
  $resultRoute,
];

RouteBase get $teamSetupRoute =>
    GoRouteData.$route(path: '/', factory: $TeamSetupRoute._fromState);

mixin $TeamSetupRoute on GoRouteData {
  static TeamSetupRoute _fromState(GoRouterState state) =>
      const TeamSetupRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rouletteRoute =>
    GoRouteData.$route(path: '/roulette', factory: $RouletteRoute._fromState);

mixin $RouletteRoute on GoRouteData {
  static RouletteRoute _fromState(GoRouterState state) => const RouletteRoute();

  @override
  String get location => GoRouteData.$location('/roulette');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $resultRoute =>
    GoRouteData.$route(path: '/result', factory: $ResultRoute._fromState);

mixin $ResultRoute on GoRouteData {
  static ResultRoute _fromState(GoRouterState state) => const ResultRoute();

  @override
  String get location => GoRouteData.$location('/result');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
