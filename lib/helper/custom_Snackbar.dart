import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void custom_Snackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
