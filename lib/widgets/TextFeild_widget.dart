// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, camel_case_types

import 'package:chat_app/constant_file.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFeild_widget extends StatelessWidget {
  TextFormFeild_widget(
      {super.key, this.labelText, this.onChange, this.obscureText = false});
  String? labelText;

  Function(String)? onChange;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
        return null;
      },
      onChanged: onChange,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: KWhiteColor),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: KWhiteColor),
        ),
        hintText: "Typing....",
        hintStyle: const TextStyle(
          color: KWhiteColor,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: KWhiteColor),
      ),
    );
  }
}
