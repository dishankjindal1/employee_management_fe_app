import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintLabel;
  final String? Function(String?)? validator;

  const CustomInputField({
    required this.hintLabel,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        decoration: InputDecoration.collapsed(
          hintText: hintLabel,
        ),
        validator: validator,
      ),
    );
  }
}
