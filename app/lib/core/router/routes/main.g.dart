// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'main.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$teamManagementRoute];

RouteBase get $teamManagementRoute => GoRouteData.$route(
  path: '/',
  factory: $TeamManagementRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'pinball', factory: $PinballRoute._fromState),
    GoRouteData.$route(path: 'result', factory: $ResultRoute._fromState),
  ],
);

mixin $TeamManagementRoute on GoRouteData {
  static TeamManagementRoute _fromState(GoRouterState state) =>
      const TeamManagementRoute();

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

mixin $PinballRoute on GoRouteData {
  static PinballRoute _fromState(GoRouterState state) => const PinballRoute();

  @override
  String get location => GoRouteData.$location('/pinball');

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
