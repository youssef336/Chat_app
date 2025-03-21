// ignore_for_file: file_names, camel_case_types

import 'package:chat_app/constant_file.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class custom_Buttom extends StatelessWidget {
  const custom_Buttom({
    super.key,
    required this.text,
    this.onTAP,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback? onTAP;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTAP,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 6, 52, 90),
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        height: 50,
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
        ),
      ),
    );
  }
}
