import 'package:employee_management_fe_app/core/router/router_service.dart';
import 'package:employee_management_fe_app/core/storage/storage_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/data/repo/dashboard_repo.dart';
import 'package:employee_management_fe_app/feature/dashboard/data/source/db/employee_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/create_employee_data.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/delete_employees_data.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/fetch_employees_data.dart';
import 'package:get_it/get_it.dart';

Future<void> intializeDependencies() async {
  /// Initialize Service Locator
  final app = GetIt.instance;

  /// Initialize App Storage
  await AppStorageService.initalize();
  const appStorage = AppStorageService();
  app.registerSingleton(appStorage);

  /// Initialize App Storage
  final appRouter = AppRouterService();
  app.registerSingleton(appRouter);

  const employeeService = EmployeeService(appStorage);
  app.registerSingleton(employeeService);

  const DashboardRepo dashboardRepo = DashboardRepoImpl(employeeService);
  app.registerSingleton(dashboardRepo);

  const fetchEmployeesDataUsecase = FetchEmployeesDataUsecase(dashboardRepo);
  app.registerSingleton(fetchEmployeesDataUsecase);

  const createEmployeesDataUsecase = CreateEmployeesDataUsecase(dashboardRepo);
  app.registerSingleton(createEmployeesDataUsecase);

  const deleteEmployeesDataUsecase = DeleteEmployeesDataUsecase(dashboardRepo);
  app.registerSingleton(deleteEmployeesDataUsecase);
}
