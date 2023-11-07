part of 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel._({
    required String id,
    required String name,
    required String designation,
    required int startDate,
    required int endDate,
    required int createdAt,
  }) : super._(
          id: id,
          name: name,
          designation: Designation.fromString(designation),
          startDate: DateTime.fromMillisecondsSinceEpoch(startDate),
          endDate: DateTime.fromMillisecondsSinceEpoch(endDate),
          createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
        );

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel._(
      id: map['id'] as String,
      name: map['name'] as String,
      designation: map['designation'] as String,
      startDate: map['start_date'] as int,
      endDate: map['end_date'] as int,
      createdAt: map['createdAt'] as int,
    );
  }

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
