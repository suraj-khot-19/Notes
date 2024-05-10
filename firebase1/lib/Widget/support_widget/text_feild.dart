import 'package:flutter/material.dart';

Widget textField(TextEditingController controller, String title,
    bool isRequired, bool isSecure, int maxline) {
  return TextFormField(
    maxLines: maxline,
    controller: controller,
    obscureText: isSecure,
    decoration: InputDecoration(
      border: const OutlineInputBorder(gapPadding: 20.0),
      hintText: title,
      labelText: title,
      focusColor: Colors.white,
    ),
    validator: (value) {
      if (isRequired == true && (value == null || value.isEmpty)) {
        return 'Please enter $title';
      }
      return null;
    },
    textAlign: TextAlign.left,
  );
}

Widget emailTextFeild(TextEditingController controller, String title,
    bool isRequired, bool isSecure, int maxline) {
  return TextFormField(
    maxLines: maxline,
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      border: const OutlineInputBorder(gapPadding: 20.0),
      focusColor: Colors.white,
      labelText: title,
      hintText: "$title@gmail.com",
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $title';
      } else if (!value.contains("@gmail.com")) {
        return 'your email must constain @gmail.com';
      }
      return null;
    },
  );
}
