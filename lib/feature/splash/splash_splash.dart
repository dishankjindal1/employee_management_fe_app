import 'package:employee_management_fe_app/core/router/router_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EmployeeDashboardRoute().pushReplacement(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Align(
        child: FlutterLogo(),
      ),
    );
  }
}
