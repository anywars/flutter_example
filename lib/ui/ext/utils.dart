
import 'package:flutter/material.dart';

class Utils {

  static dialog(String? title, String message, VoidCallback? onPressed) {
    return AlertDialog(
      title: Text(title ?? ''),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            onPressed?.call();
          },
          child: Text('확인'),
        )
      ],
    );
  }

}