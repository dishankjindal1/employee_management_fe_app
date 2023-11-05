import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/create_employee_data.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/delete_employees_data.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/usecase/fetch_employees_data.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EmployeeCubit extends Cubit<List<EmployeeEntity>> {
  final FetchEmployeesDataUsecase _fetchEmployeesDataUsecase;
  final CreateEmployeesDataUsecase _createEmployeesDataUsecase;
  final DeleteEmployeesDataUsecase _deleteEmployeesDataUsecase;

  EmployeeCubit()
      : _fetchEmployeesDataUsecase = GetIt.I.get(),
        _createEmployeesDataUsecase = GetIt.I.get(),
        _deleteEmployeesDataUsecase = GetIt.I.get(),
        super([]) {
    read();
  }

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

  Future<EmployeeEntity> update(
    String id,
    String? name,
    Designation? designation,
    DateTime? to,
  ) async {
    try {
      final findEntity = state.firstWhere((element) => element.id == id);
      state.remove(findEntity);

      var data = findEntity.copyWith(
        name: name,
        designation: designation,
        to: to,
      );

      state.add(data);
      emit(state);
      return data;
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
