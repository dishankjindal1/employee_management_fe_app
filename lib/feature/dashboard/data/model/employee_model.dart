part of 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel._({
    required String id,
    required String name,
    required String designation,
    required int from,
    required int to,
    required int createdAt,
  }) : super._(
          id: id,
          name: name,
          designation: Designation.fromString(designation),
          from: DateTime.fromMillisecondsSinceEpoch(from),
          to: DateTime.fromMillisecondsSinceEpoch(to),
          createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
        );

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel._(
      id: map['id'] as String,
      name: map['name'] as String,
      designation: map['designation'] as String,
      from: map['from'] as int,
      to: map['to'] as int,
      createdAt: map['createdAt'] as int,
    );
  }

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
