import 'dart:async';
import 'dart:io';

import 'package:employee_management_fe_app/feature/dashboard/presentation/crud_employee_screen.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/employee_dashboard_screen.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router_service.g.dart';

class AppRouterService {
  final goRouter = GoRouter(
    debugLogDiagnostics: true,
    routes: $appRoutes,
  );
}

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData {
  @override
  String? redirect(BuildContext context, GoRouterState state) {
    return EmployeeFlowRoute().location;
  }
}

@TypedGoRoute<EmployeeFlowRoute>(path: '/employee')
class EmployeeFlowRoute extends GoRouteData {
  @override
  String? redirect(BuildContext context, GoRouterState state) {
    return EmployeeListRoute().location;
  }
}

@TypedGoRoute<EmployeeListRoute>(path: '/employee/all')
class EmployeeListRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    const page = EmployeeDashboardScreen();

    if (Platform.isIOS) {
      return const CupertinoPage(child: page);
    } else {
      return const MaterialPage(child: page);
    }
  }
}

@TypedGoRoute<CrudEmployeeRoute>(path: '/employee/:crud')
class CrudEmployeeRoute extends GoRouteData {
  final String crud;
  const CrudEmployeeRoute(this.crud);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final page = CrudEmployeeScreen(operation: CrudOperation.fromString(crud));

    if (Platform.isIOS) {
      return CupertinoPage(child: page);
    } else {
      return MaterialPage(child: page);
    }
  }
}
