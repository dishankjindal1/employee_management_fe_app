import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:employee_management_fe_app/utility/utlity.dart';

part 'package:employee_management_fe_app/feature/dashboard/data/model/employee_model.dart';

class EmployeeEntity extends Equatable {
  final String id;
  final String name;
  final Designation designation;
  final DateTime from;
  final DateTime to;
  final DateTime createdAt;

  const EmployeeEntity._({
    required this.id,
    required this.name,
    required this.designation,
    required this.from,
    required this.to,
    required this.createdAt,
  });

  EmployeeEntity.uuid({
    required this.name,
    required this.designation,
    required this.from,
    required this.to,
  })  : id = const Uuid().v4(),
        createdAt = DateTime.now();

  EmployeeEntity copyWith({
    String? id,
    String? name,
    Designation? designation,
    DateTime? from,
    DateTime? to,
    DateTime? createdAt,
  }) {
    return EmployeeEntity._(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      from: from ?? this.from,
      to: to ?? this.to,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'designation': designation.name.toLowerCase(),
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        id,
        name,
        designation,
        from,
        to,
        createdAt,
      ];
}

extension EmployeeEntityHelperFunctions on EmployeeEntity {
  String get formatFrom {
    return 'From ${DateFormat('dd MMM, yyyy').format(from)}';
  }

  String get formatToFrom {
    return '${DateFormat('dd MMM, yyyy').format(from)} - ${DateFormat('dd MMM, yyyy').format(to)}';
  }
}
