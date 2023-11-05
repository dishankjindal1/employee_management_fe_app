import 'dart:isolate';

import 'package:employee_management_fe_app/core/storage/storage_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';

class EmployeeService {
  final AppStorageService _appStorage;

  const EmployeeService(this._appStorage);

  Future<void> createEntity(EmployeeEntity entity) async {
    try {
      if (_appStorage.appStorage.containsKey(runtimeType.toString())) {
        final data =
            _appStorage.appStorage.get(runtimeType.toString()) as List<dynamic>;
        data.add(entity.toJson());
        _appStorage.appStorage.delete(runtimeType.toString());
        _appStorage.appStorage.put(runtimeType.toString(), data);
      } else {
        _appStorage.appStorage.put(runtimeType.toString(), []);
        await createEntity(entity);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EmployeeEntity>> fetchAll() async {
    try {
      if (_appStorage.appStorage.containsKey(runtimeType.toString())) {
        final data =
            _appStorage.appStorage.get(runtimeType.toString()) as List<dynamic>;

        final result = await Isolate.run<List<EmployeeEntity>>(
            () => data.map((e) => EmployeeModel.fromJson(e)).toList());

        return result;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEntity(String id) async {
    try {
      final result = await fetchAll();
      result.removeWhere((element) => element.id == id);
      _appStorage.appStorage.delete(runtimeType.toString());
      _appStorage.appStorage
          .put(runtimeType.toString(), result.map((e) => e.toJson()).toList());
    } catch (e) {
      rethrow;
    }
  }
}
