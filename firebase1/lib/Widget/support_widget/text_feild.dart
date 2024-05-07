import 'package:flutter/material.dart';

Widget textField(TextEditingController controller, String title,
    bool isRequired, bool isSecure) {
  return TextFormField(
    controller: controller,
    obscureText: isSecure,
    decoration: InputDecoration(
      hintText: title,
    ),
    validator: (value) {
      if (isRequired && (value == null || value.isEmpty)) {
        return 'Please enter $title';
      }
      return null;
    },
  );
}
