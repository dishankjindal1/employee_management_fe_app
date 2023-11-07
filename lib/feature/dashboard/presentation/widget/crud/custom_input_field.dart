import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintLabel;
  final ValueNotifier<String?> valueNotifier;
  final String? Function(String?)? validator;

  const CustomInputField({
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
              Icons.person_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: TextFormField(
              controller: valueNotifier.value != null
                  ? TextEditingController.fromValue(
                      TextEditingValue(text: valueNotifier.value!))
                  : null,
              decoration: InputDecoration.collapsed(
                hintText: hintLabel,
              ),
              validator: validator,
            ),
          );
        });
  }
}
