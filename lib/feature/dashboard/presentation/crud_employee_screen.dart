import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/custom_datetime_field.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/custom_drop_down_field.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/custom_input_field.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CrudEmployeeScreen extends StatefulWidget {
  final CrudOperation operation;

  const CrudEmployeeScreen({
    required this.operation,
    super.key,
  });

  @override
  State<CrudEmployeeScreen> createState() => _CrudEmployeeScreenState();
}

class _CrudEmployeeScreenState extends State<CrudEmployeeScreen> {
  late final GlobalKey<FormState> _form;

  late final ValueNotifier<String?> _name;
  late final ValueNotifier<Designation?> _designation;
  late final ValueNotifier<DateTime?> _to;
  late final ValueNotifier<DateTime?> _from;

  @override
  void initState() {
    _form = GlobalKey<FormState>();

    _name = ValueNotifier(null);
    _designation = ValueNotifier(null);
    _to = ValueNotifier(null);
    _from = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    _form.currentState?.dispose();
    _name.dispose();
    _designation.dispose();
    _to.dispose();
    _from.dispose();

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
        ),
        body: Form(
          key: _form,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ListView(
              children: [
                CustomInputField(
                  hintLabel: 'Employee Name',
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
                    if (value != null && !value.contains('none')) {
                      return null;
                    }

                    return 'Important!';
                  },
                ),
                const SizedBox.square(dimension: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomDatetimeField(
                        hintLabel: 'No date',
                        valueNotifier: _from,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }

                          return 'Important!';
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomDatetimeField(
                        hintLabel: 'No date',
                        valueNotifier: _to,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return null;
                          }

                          return 'Important!';
                        },
                      ),
                    ),
                  ],
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
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    final entity = EmployeeEntity.uuid(
                      name: _name.value!,
                      designation: _designation.value!,
                      from: _from.value!,
                      to: _to.value!,
                    );
                    context.read<EmployeeCubit>().create(entity);
                    context.pop();
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
