import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/create_employee_data.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/delete_employee_data.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/fetch_employees_data.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/update_employee_data.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EmployeeCubit extends Cubit<List<EmployeeEntity>> {
  final FetchEmployeesDataUsecase _fetchEmployeesDataUsecase;
  final CreateEmployeesDataUsecase _createEmployeesDataUsecase;
  final DeleteEmployeesDataUsecase _deleteEmployeesDataUsecase;
  final UpdateEmployeesDataUsecase _updateEmployeesDataUsecase;

  EmployeeCubit()
      : _fetchEmployeesDataUsecase = GetIt.I.get(),
        _createEmployeesDataUsecase = GetIt.I.get(),
        _deleteEmployeesDataUsecase = GetIt.I.get(),
        _updateEmployeesDataUsecase = GetIt.I.get(),
        super([]) {
    read();
  }

  List<EmployeeEntity> get currentEmp => state
      .where((element) => DateUtils.dateOnly(DateTime.now())
          .subtract(const Duration(days: 1))
          .isBefore(DateUtils.dateOnly(element.endDate)))
      .toList();

  List<EmployeeEntity> get previousEmp => state
      .where((element) => DateUtils.dateOnly(DateTime.now())
          .isAfter(DateUtils.dateOnly(element.endDate)))
      .toList();

  Future<void> create(EmployeeEntity entity) async {
    try {
      final data = [...state];
      await _createEmployeesDataUsecase.create(entity);
      data.add(entity);

      emit(data);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> read() async {
    try {
      final data = await _fetchEmployeesDataUsecase.fetch();

      emit(data);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> update({
    required String id,
    String? name,
    Designation? designation,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final findEntity = state.firstWhere((element) => element.id == id);
      state.remove(findEntity);

      var entity = findEntity.copyWith(
        name: name,
        designation: designation,
        startDate: startDate,
        endDate: endDate,
      );
      final result = [...state];
      await _updateEmployeesDataUsecase.update(id, entity);
      result.add(entity);

      emit(result);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> delete(String id) async {
    try {
      final entity = state.firstWhere((element) => element.id == id);
      final result = [...state];
      await _deleteEmployeesDataUsecase.delete(id);
      result.remove(entity);

      emit(result);
    } catch (e) {
      throw Exception();
    }
  }
}
