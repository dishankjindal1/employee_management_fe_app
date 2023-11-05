import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:flutter/cupertino.dart';

class FetchEmployeesDataUsecase {
  final DashboardRepo _dashboardRepo;

  const FetchEmployeesDataUsecase(this._dashboardRepo);

  Future<List<EmployeeEntity>> fetch() async {
    try {
      return await _dashboardRepo.read();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
