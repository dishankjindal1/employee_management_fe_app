import 'package:employee_management_fe_app/core/router/router_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

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
          const errorWidget = Material(
            child: Align(
              child: Text('Error Screen'),
            ),
          );

          ErrorWidget.builder = (errorDetails) => errorWidget;

          if (child == null) {
            return errorWidget;
          }

          return LayoutBuilder(builder: (context, constraints) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: constraints.maxWidth / 460,
              ),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: GoogleFonts.robotoTextTheme(),
                  ),
                  child: ScaffoldMessenger(child: child)),
            );
          });
        },
      ),
    );
  }
}
