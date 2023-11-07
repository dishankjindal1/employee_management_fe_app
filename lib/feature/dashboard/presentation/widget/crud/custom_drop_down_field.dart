import 'package:employee_management_fe_app/utility/utlity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class CustomDropDownField extends StatelessWidget {
  final List<Designation> options;
  final ValueNotifier<Designation?> valueNotifier;
  final String? Function(String?)? validator;

  const CustomDropDownField({
    required this.options,
    required this.valueNotifier,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: valueNotifier,
        builder: (context, _) {
          return GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<int>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (context) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TextButton(
                          onPressed: () {
                            context.pop<int>(index);
                          },
                          child: Text(
                            options[index].label,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: options.length,
                    );
                  });

              if (result != null) {
                valueNotifier.value = options[result];
              }
            },
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              minLeadingWidth: 0,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              leading: Icon(
                Icons.work_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: TextFormField(
                readOnly: true,
                controller: valueNotifier.value != null
                    ? TextEditingController.fromValue(
                        TextEditingValue(text: valueNotifier.value!.label))
                    : null,
                decoration: InputDecoration.collapsed(
                  hintText: Designation.none.label,
                ),
                validator: validator,
              ),
              trailing: Icon(
                AntDesign.caretdown,
                color: Theme.of(context).colorScheme.primary,
                size: 12,
              ),
            ),
          );
        });
  }
}
