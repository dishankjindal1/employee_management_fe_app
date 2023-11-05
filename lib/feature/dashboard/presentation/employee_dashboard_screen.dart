import 'package:employee_management_fe_app/core/router/router_service.dart';
import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<EmployeeCubit>();
    final List<EmployeeEntity> currentEmp = data.state
        .where((element) => DateUtils.dateOnly(DateTime.now())
            .isBefore(DateUtils.dateOnly(element.to)))
        .toList();

    final List<EmployeeEntity> previousEmp = data.state
        .where((element) => DateUtils.dateOnly(DateTime.now())
            .isAfter(DateUtils.dateOnly(element.to)))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            context.read<EmployeeCubit>().create(EmployeeEntity.uuid(
                name: 'Dishank Jindal',
                designation: Designation.flutterDeveloper,
                from: DateUtils.dateOnly(
                    DateTime.now().subtract(const Duration(days: 3))),
                to: DateUtils.dateOnly(
                    DateTime.now().add(const Duration(days: 3)))));
          },
          child: Text(
            AppTextConstant.dashboardtext1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: context.watch<EmployeeCubit>().read,
        child: switch (context.watch<EmployeeCubit>().state.isEmpty) {
          true => const EmptyState(),
          false => DataState(
              currentEmp: currentEmp,
              previousEmp: previousEmp,
            ),
        },
      ),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight,
        padding: const EdgeInsets.all(8),
        color: Colors.grey.shade200,
        child: Text(
          'Swipe left to delete',
          style: DefaultTextStyle.of(context).style.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
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

class DataState extends StatelessWidget {
  final List<EmployeeEntity> currentEmp;
  final List<EmployeeEntity> previousEmp;
  const DataState({
    required this.currentEmp,
    required this.previousEmp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverMainAxisGroup(slivers: [
          const SliverPersistentHeader(
            pinned: true,
            delegate: CurrentEmployeePersistentHeader(
              title: 'Current Employee',
            ),
          ),
          SliverList.list(
            children: [
              for (var i = 0; i < currentEmp.length; i++) ...[
                LayoutBuilder(builder: (context, constraints) {
                  return Dismissible(
                    key: Key(currentEmp[i].id),
                    dismissThresholds: const {
                      DismissDirection.horizontal: 0.2,
                    },
                    confirmDismiss: (dismissDirection) async {
                      if (dismissDirection == DismissDirection.endToStart) {
                        return await showAdaptiveDialog(
                            context: context,
                            builder: (context) {
                              // set up the buttons
                              Widget cancelButton = TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  context.pop(false);
                                },
                              );
                              Widget continueButton = TextButton(
                                child: const Text("Continue"),
                                onPressed: () {
                                  context.pop(true);
                                },
                              );
                              // set up the AlertDialog
                              return AlertDialog(
                                title: const Text("Are you sure?"),
                                content: const Text(
                                    "This will permanently delete the item."),
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
                      context.read<EmployeeCubit>().delete(currentEmp[i].id);
                    },
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        currentEmp[i].name,
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(currentEmp[i].designation.label),
                          const SizedBox(height: 8),
                          Text(currentEmp[i].formatFrom),
                        ],
                      ),
                    ),
                  );
                }),
                const Divider(),
              ],
            ],
          ),
        ]),
        SliverMainAxisGroup(slivers: [
          const SliverPersistentHeader(
            pinned: true,
            delegate: CurrentEmployeePersistentHeader(
              title: 'Previous Employee',
            ),
          ),
          SliverList.list(
            children: [
              for (var i = 0; i < previousEmp.length; i++) ...[
                LayoutBuilder(builder: (context, constraints) {
                  return Dismissible(
                    key: Key(previousEmp[i].id),
                    dismissThresholds: const {
                      DismissDirection.horizontal: 0.8,
                    },
                    confirmDismiss: (dismissDirection) async {
                      return await showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            // set up the buttons
                            Widget cancelButton = TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                context.pop(false);
                              },
                            );
                            Widget continueButton = TextButton(
                              child: const Text("Continue"),
                              onPressed: () {
                                context.pop(true);
                              },
                            );
                            // set up the AlertDialog
                            return AlertDialog(
                              title: const Text("Are you sure?"),
                              content: const Text(
                                  "This will permanently delete the item."),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );
                          });
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
                      context.read<EmployeeCubit>().delete(previousEmp[i].id);
                    },
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        previousEmp[i].name,
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(previousEmp[i].designation.label),
                          const SizedBox(height: 8),
                          Text(
                            previousEmp[i].formatToFrom,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const Divider(),
              ],
            ],
          ),
        ]),
      ],
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset('asset/empty_page.svg'),
              Align(
                child: Text(
                  AppTextConstant.dashboardtext2,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class CurrentEmployeePersistentHeader extends SliverPersistentHeaderDelegate {
  final String title;

  const CurrentEmployeePersistentHeader({
    required this.title,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: ListTile(
        dense: false,
        visualDensity: VisualDensity.compact,
        title: Text(
          title,
          style: DefaultTextStyle.of(context).style.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
