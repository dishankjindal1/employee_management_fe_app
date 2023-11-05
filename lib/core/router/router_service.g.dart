// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_service.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $employeeFlowRoute,
      $employeeListRoute,
      $crudEmployeeRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => SplashRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $employeeFlowRoute => GoRouteData.$route(
      path: '/employee',
      factory: $EmployeeFlowRouteExtension._fromState,
    );

extension $EmployeeFlowRouteExtension on EmployeeFlowRoute {
  static EmployeeFlowRoute _fromState(GoRouterState state) =>
      EmployeeFlowRoute();

  String get location => GoRouteData.$location(
        '/employee',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $employeeListRoute => GoRouteData.$route(
      path: '/employee/all',
      factory: $EmployeeListRouteExtension._fromState,
    );

extension $EmployeeListRouteExtension on EmployeeListRoute {
  static EmployeeListRoute _fromState(GoRouterState state) =>
      EmployeeListRoute();

  String get location => GoRouteData.$location(
        '/employee/all',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $crudEmployeeRoute => GoRouteData.$route(
      path: '/employee/:crud',
      factory: $CrudEmployeeRouteExtension._fromState,
    );

extension $CrudEmployeeRouteExtension on CrudEmployeeRoute {
  static CrudEmployeeRoute _fromState(GoRouterState state) => CrudEmployeeRoute(
        state.pathParameters['crud']!,
      );

  String get location => GoRouteData.$location(
        '/employee/${Uri.encodeComponent(crud)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
