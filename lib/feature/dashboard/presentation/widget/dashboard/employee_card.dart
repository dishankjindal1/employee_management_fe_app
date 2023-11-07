import 'package:employee_management_fe_app/core/router/router_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:employee_management_fe_app/utility/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeEntity emp;

  const EmployeeCard({
    super.key,
    required this.emp,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(emp.id),
      dismissThresholds: const {
        DismissDirection.horizontal: 0.2,
      },
      confirmDismiss: (dismissDirection) async {
        if (dismissDirection == DismissDirection.endToStart) {
          return await showAdaptiveDialog(
              context: context,
              builder: (context) {
                Widget cancelButton = TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    context.pop(false);
                  },
                );

                Widget continueButton = TextButton(
                  child: const Text("Continue"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Employee data has been deleted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () async => rootNavKey.currentContext!
                              .read<EmployeeCubit>()
                              .create(emp),
                        ),
                      ),
                    );
                    context.pop(true);
                  },
                );

                return AlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("This will permanently delete the item."),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );
              });
        }
        return null;
      },
      secondaryBackground: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: const Alignment(0.9, 0),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: const Alignment(-0.9, 0),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      onDismissed: (direction) {
        context.read<EmployeeCubit>().delete(emp.id);
      },
      child: ListTile(
        minVerticalPadding: 0,
        onTap: () {
          CrudEmployeeRoute(CrudOperation.update.name, id: emp.id)
              .push(context);
        },
        isThreeLine: true,
        title: Text(
          emp.name,
          style: DefaultTextStyle.of(context).style.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emp.designation.label),
            const SizedBox(height: 8),
            Text(emp.formatFrom),
          ],
        ),
      ),
    );
  }
}
