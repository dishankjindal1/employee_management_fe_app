import 'package:employee_management_fe_app/core/router/router_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/dashboard/data_state.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/dashboard/empty_state.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTextConstant.dashboardtext1,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: context.watch<EmployeeCubit>().read,
        child: switch (context.watch<EmployeeCubit>().state.isEmpty) {
          true => const EmptyState(),
          false => const DataState(),
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.add),
        onPressed: () {
          CrudEmployeeRoute(CrudOperation.create.name).push(context);
        },
      ),
    );
  }
}
