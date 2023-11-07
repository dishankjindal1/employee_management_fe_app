import 'package:employee_management_fe_app/feature/dashboard/data/repo/dashboard_repo.dart';
import 'package:employee_management_fe_app/feature/dashboard/data/source/db/employee_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'update_employee_data_test.mocks.dart';

@GenerateMocks([EmployeeService])
void main() {
  group('test UPDATE usecase', () {
    late EmployeeService service;
    late DashboardRepo repo;
    late EmployeeEntity entity;

    setUp(() {
      service = MockEmployeeService();
      repo = DashboardRepoImpl(service);
      entity = EmployeeEntity.uuid(
        name: 'Dishank',
        designation: Designation.flutterDeveloper,
        startDate: DateUtils.dateOnly(
            DateTime.now().subtract(const Duration(days: 3))),
        endDate:
            DateUtils.dateOnly(DateTime.now().add(const Duration(days: 3))),
      );
    });

    test('test update name to "bunty"', () async {
      when(
        service.updateEntity(
          entity.id,
          entity.copyWith(
            name: 'Bunty',
          ),
        ),
      ).thenAnswer((realInvocation) async {});

      expect(
          repo.update(
            entity.id,
            entity.copyWith(
              name: 'Bunty',
            ),
          ),
          isA<void>());
    });
  });
}
