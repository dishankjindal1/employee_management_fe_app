import 'package:employee_management_fe_app/feature/dashboard/data/repo/dashboard_repo.dart';
import 'package:employee_management_fe_app/feature/dashboard/data/source/db/employee_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/repo/dashboard_repo.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'fetch_employee_data_test.mocks.dart';

@GenerateMocks([EmployeeService])
void main() {
  group('test fetch usecase', () {
    late EmployeeService service;
    late DashboardRepo repo;

    setUp(() {
      service = MockEmployeeService();
      repo = DashboardRepoImpl(service);
    });
    test('test empty array', () async {
      when(service.fetchEntity())
          .thenAnswer((realInvocation) => Future.value([]));

      expect(await repo.read(), isA<List<EmployeeEntity>>());
    });

    test('test array with 1 item', () async {
      when(service.fetchEntity()).thenAnswer((realInvocation) => Future.value([
            EmployeeEntity.uuid(
                name: 'name',
                designation: Designation.flutterDeveloper,
                startDate: DateUtils.dateOnly(
                    DateTime.now().subtract(const Duration(days: 3))),
                endDate: DateUtils.dateOnly(
                    DateTime.now().add(const Duration(days: 3))))
          ]));

      expect(
        await repo.read(),
        isA<List<EmployeeEntity>>()
            .having((p0) => p0, 'Check if it has data', isNotEmpty)
            .having((p0) => p0.first.name, 'Check if it has name = "name"',
                contains('name')),
      );
    });

    test('throw error', () async {
      when(service.fetchEntity()).thenThrow(Exception('unknown'));

      expect(
          repo.read,
          throwsA(isA<Exception>().having((p0) => p0.toString(),
              'Check if the error msg is "unknown"', contains('unknown'))));
    });
  });
}
