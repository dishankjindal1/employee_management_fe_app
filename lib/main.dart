import 'package:employee_management_fe_app/dep_inj.dart';
import 'package:employee_management_fe_app/feature/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await intializeDependencies();

  runApp(const App());
}
