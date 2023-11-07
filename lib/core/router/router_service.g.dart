// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_service.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $employeeDashboardRoute,
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

RouteBase get $employeeDashboardRoute => GoRouteData.$route(
      path: '/employee/all',
      factory: $EmployeeDashboardRouteExtension._fromState,
    );

extension $EmployeeDashboardRouteExtension on EmployeeDashboardRoute {
  static EmployeeDashboardRoute _fromState(GoRouterState state) =>
      EmployeeDashboardRoute();

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
        id: state.uri.queryParameters['id'],
      );

  String get location => GoRouteData.$location(
        '/employee/${Uri.encodeComponent(crud)}',
        queryParams: {
          if (id != null) 'id': id,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
