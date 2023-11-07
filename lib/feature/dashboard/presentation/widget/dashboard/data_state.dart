import 'package:employee_management_fe_app/feature/dashboard/domain/entity/employee_entity.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/bloc/employee/employee_cubit.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/dashboard/employee_card.dart';
import 'package:employee_management_fe_app/feature/dashboard/presentation/widget/dashboard/pinned_persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataState extends StatelessWidget {
  const DataState({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<EmployeeCubit>();
    final List<EmployeeEntity> currentEmp = data.currentEmp;
    final List<EmployeeEntity> previousEmp = data.previousEmp;

    return CustomScrollView(
      slivers: [
        if (currentEmp.isNotEmpty)
          SliverMainAxisGroup(slivers: [
            const SliverPersistentHeader(
              pinned: true,
              delegate: PinnedPersistentHeader(
                title: 'Current Employee',
              ),
            ),
            SliverList.list(
              children: [
                for (var i = 0; i < currentEmp.length; i++) ...[
                  EmployeeCard(emp: currentEmp[i]),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Theme.of(context).dividerColor,
                  ),
                ],
              ],
            ),
          ]),
        if (previousEmp.isNotEmpty)
          SliverMainAxisGroup(slivers: [
            const SliverPersistentHeader(
              pinned: true,
              delegate: PinnedPersistentHeader(
                title: 'Previous Employee',
              ),
            ),
            SliverList.list(
              children: [
                for (var i = 0; i < previousEmp.length; i++) ...[
                  EmployeeCard(emp: previousEmp[i]),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Theme.of(context).dividerColor,
                  ),
                ],
              ],
            ),
          ]),
        if (currentEmp.isNotEmpty || previousEmp.isNotEmpty)
          SliverMainAxisGroup(slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: kBottomNavigationBarHeight,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: Colors.grey.shade200,
                child: Text(
                  'Swipe left to delete',
                  style: DefaultTextStyle.of(context).style.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                ),
              ),
            )
          ]),
      ],
    );
  }
}
