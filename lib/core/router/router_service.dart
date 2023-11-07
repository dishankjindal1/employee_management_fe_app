import 'dart:async';
import 'dart:io';

import 'package:employee_management_fe_app/feature/dashboard/presentation/screen/crud_employee_screen.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/screen/employee_dashboard_screen.dart';
import 'package:employee_management_fe_app/feature/splash/splash_splash.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router_service.g.dart';

final rootNavKey = GlobalKey<NavigatorState>();

class AppRouterService {
  final goRouter = GoRouter(
    navigatorKey: rootNavKey,
    debugLogDiagnostics: true,
    routes: $appRoutes,
  );
}

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    const page = SplashScreen();

    if (Platform.isIOS) {
      return CupertinoPage(
        key: state.pageKey,
        child: page,
      );
    } else {
      return MaterialPage(
        key: state.pageKey,
        child: page,
      );
    }
  }
}

@TypedGoRoute<EmployeeDashboardRoute>(path: '/employee/all')
class EmployeeDashboardRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    const page = EmployeeDashboardScreen();

    if (Platform.isIOS) {
      return CupertinoPage(
        key: state.pageKey,
        child: page,
      );
    } else {
      return MaterialPage(
        key: state.pageKey,
        child: page,
      );
    }
  }
}

@TypedGoRoute<CrudEmployeeRoute>(path: '/employee/:crud')
class CrudEmployeeRoute extends GoRouteData {
  final String crud;
  final String? id;
  const CrudEmployeeRoute(
    this.crud, {
    this.id,
  });

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final page = CrudEmployeeScreen(
      operation: CrudOperation.fromString(crud),
      id: id,
    );

    if (Platform.isIOS) {
      return CupertinoPage(
        key: state.pageKey,
        child: page,
      );
    } else {
      return MaterialPage(
        key: state.pageKey,
        child: page,
      );
    }
  }
}
