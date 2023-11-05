import 'package:employee_management_fe_app/core/router/router_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider<EmployeeCubit>(create: (context) => EmployeeCubit()),
      ],
      child: WidgetsApp.router(
        color: const Color(0x001da1f2),
        routerConfig: GetIt.I.get<AppRouterService>().goRouter,
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          ErrorWidget.builder = (errorDetails) => const Material(
                child: Align(
                  child: Text('Error Screen'),
                ),
              );

          return LayoutBuilder(builder: (context, constraints) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: constraints.maxWidth / 460,
              ),
              child: child!,
            );
          });
        },
      ),
    );
  }
}
