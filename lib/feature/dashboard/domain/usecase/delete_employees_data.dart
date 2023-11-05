import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:flutter/cupertino.dart';

class DeleteEmployeesDataUsecase {
  final DashboardRepo _dashboardRepo;

  const DeleteEmployeesDataUsecase(this._dashboardRepo);

  Future<void> delete(String id) async {
    try {
      return _dashboardRepo.delete(id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
