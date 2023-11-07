import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/crud/custom_datetime_field.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/crud/custom_drop_down_field.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/crud/custom_input_field.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CrudEmployeeScreen extends StatefulWidget {
  final CrudOperation operation;
  final String? id;

  const CrudEmployeeScreen({
    required this.operation,
    this.id,
    super.key,
  });

  @override
  State<CrudEmployeeScreen> createState() => _CrudEmployeeScreenState();
}

class _CrudEmployeeScreenState extends State<CrudEmployeeScreen> {
  late final GlobalKey<FormState> _form;

  late final ValueNotifier<String?> _name;
  late final ValueNotifier<Designation?> _designation;
  late final ValueNotifier<DateTime?> _start;
  late final ValueNotifier<DateTime?> _end;

  @override
  void initState() {
    _form = GlobalKey<FormState>();
    _name = ValueNotifier(null);
    _designation = ValueNotifier(null);
    _start = ValueNotifier(null);
    _end = ValueNotifier(null);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.operation == CrudOperation.update) {
        final entity = context
            .read<EmployeeCubit>()
            .state
            .firstWhere((element) => element.id == widget.id);
        _name.value = entity.name;
        _designation.value = entity.designation;
        _start.value = entity.startDate;
        _end.value = entity.endDate;
        setState(() {
          ///
        });
      }
    });
  }

  @override
  void dispose() {
    _form.currentState?.dispose();
    _name.dispose();
    _designation.dispose();
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            AppTextConstant.employeeedittext1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          actions: [
            if (widget.operation == CrudOperation.update)
              IconButton(
                onPressed: () => context
                    .read<EmployeeCubit>()
                    .delete(widget.id!)
                    .then((_) => context.pop()),
                icon: const Icon(Icons.delete),
              )
          ],
        ),
        body: Form(
          key: _form,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                CustomInputField(
                  hintLabel: 'Employee Name',
                  valueNotifier: _name,
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length > 3) {
                      _name.value = value;
                      return null;
                    }
                    return 'Important!';
                  },
                ),
                const SizedBox.square(dimension: 16),
                CustomDropDownField(
                  options: const [
                    Designation.flutterDeveloper,
                    Designation.productDesigner,
                    Designation.qaTester,
                    Designation.productOwner,
                  ],
                  valueNotifier: _designation,
                  validator: (value) {
                    if (value != null) {
                      return null;
                    }

                    return 'Important!';
                  },
                ),
                const SizedBox.square(dimension: 16),
                CustomDatetimeField(
                  startDate: _start,
                  endDate: _end,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    }

                    return 'Important!';
                  },
                ),
                const SizedBox.square(dimension: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () async {
                  if (_form.currentState!.validate()) {
                    final entity = EmployeeEntity.uuid(
                      name: _name.value!,
                      designation: _designation.value!,
                      startDate: _start.value!,
                      endDate: _end.value!,
                    );
                    if (widget.operation == CrudOperation.update) {
                      await context.read<EmployeeCubit>().update(
                            id: widget.id!,
                            name: entity.name,
                            designation: entity.designation,
                            startDate: entity.startDate,
                            endDate: entity.endDate,
                          );
                    } else {
                      await context.read<EmployeeCubit>().create(entity);
                    }
                    if (mounted) {
                      context.pop();
                    }
                  }
                },
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
