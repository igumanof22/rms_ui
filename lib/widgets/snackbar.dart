import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackbar(String text, {bool isError = false}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: isError ? Colors.red.shade400 : Colors.green.shade400,
    ),
  );
}
