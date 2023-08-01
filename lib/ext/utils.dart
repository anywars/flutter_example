
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {

  static Future dialog(String? title, String message, VoidCallback? onPressed) => Get.dialog(AlertDialog(
    title: Text(title ?? ''),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: onPressed?.call ?? () => Get.back(result: true),
        child: Text('확인'),
      )
    ],
  ));

}