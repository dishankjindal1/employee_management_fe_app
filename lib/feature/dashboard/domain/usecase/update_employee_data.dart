import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:flutter/cupertino.dart';

class UpdateEmployeesDataUsecase {
  final DashboardRepo _dashboardRepo;

  const UpdateEmployeesDataUsecase(this._dashboardRepo);

  Future<void> update(String id, EmployeeEntity entity) async {
    try {
      return _dashboardRepo.update(id, entity);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
