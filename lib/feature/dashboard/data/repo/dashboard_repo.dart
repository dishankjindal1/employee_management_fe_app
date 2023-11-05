import 'package:employee_management_fe_app/feature/dashboard/data/source/db/employee_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';

class DashboardRepoImpl extends DashboardRepo {
  final EmployeeService _employeeService;

  const DashboardRepoImpl(this._employeeService);

  @override
  Future<void> create(EmployeeEntity entity) async {
    try {
      await _employeeService.createEntity(entity);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<EmployeeEntity>> read() async {
    try {
      return _employeeService.fetchAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EmployeeEntity> update(String id, EmployeeEntity entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    try {
      return _employeeService.deleteEntity(id);
    } catch (e) {
      rethrow;
    }
  }
}
