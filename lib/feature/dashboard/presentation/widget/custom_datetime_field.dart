import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatetimeField extends StatelessWidget {
  final String hintLabel;
  final ValueNotifier<DateTime?> valueNotifier;
  final String? Function(String?)? validator;

  const CustomDatetimeField({
    required this.hintLabel,
    required this.valueNotifier,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: valueNotifier,
        builder: (context, _) {
          return ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            minLeadingWidth: 0,
            leading: Icon(
              Icons.event,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: TextFormField(
              readOnly: true,
              controller: valueNotifier.value != null
                  ? TextEditingController.fromValue(TextEditingValue(
                      text: DateFormat('dd MMM yyyy')
                          .format(valueNotifier.value!)))
                  : null,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration.collapsed(
                hintText: hintLabel,
              ),
              onTap: () async {
                final result = await showDatePicker(
                    context: context,
                    initialDate: valueNotifier.value ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDatePickerModeChange: (value) {
                      debugPrint(value.toString());
                    });

                if (result != null) {
                  valueNotifier.value = result;
                }
              },
              validator: validator,
            ),
          );
        });
  }
}
