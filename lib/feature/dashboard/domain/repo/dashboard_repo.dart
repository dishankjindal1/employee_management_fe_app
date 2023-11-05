import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';

abstract class DashboardRepo {
  const DashboardRepo();

  Future<void> create(EmployeeEntity entity);

  Future<List<EmployeeEntity>> read();

  Future<EmployeeEntity> update(String id, EmployeeEntity entity);

  Future<void> delete(String id);
}
