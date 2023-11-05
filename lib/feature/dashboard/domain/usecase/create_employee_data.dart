import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:flutter/cupertino.dart';

class CreateEmployeesDataUsecase {
  final DashboardRepo _dashboardRepo;

  const CreateEmployeesDataUsecase(this._dashboardRepo);

  Future<void> create(EmployeeEntity entity) async {
    try {
      return _dashboardRepo.create(entity);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
