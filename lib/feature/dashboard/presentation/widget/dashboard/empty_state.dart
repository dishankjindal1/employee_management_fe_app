import 'package:employee_management_fe_app/utility/app_text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
