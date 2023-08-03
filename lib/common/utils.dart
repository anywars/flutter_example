import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {

  static Future<T?>? dialog<T>({String? title, required String message, VoidCallback? onPressed}) => Get.dialog(AlertDialog(
    title: Text(title ?? ''),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: onPressed?.call ?? () => Get.back(result: true),
        child: Text('확인'),
      )
    ],
  ));

  static Future<T?>? confirm<T>({
    String? title,
    required String message,
    VoidCallback? onPressed,
  }) => Get.dialog(AlertDialog(
    title: Text(title ?? ''),
    content: Text(message),
    actions: [
      TextButton(onPressed: Get.back, child: Text('Cancel')),
      TextButton(onPressed: onPressed, child: Text('OK')),
    ],
  ));

  static Future modalProgress({bool barrierDismissible = true, Color? barrierColor}) =>
      Get.dialog(Center(
          child: CircularProgressIndicator()
      ), barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
    );

  static dismissModalProgress() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static OverlayEntry? _entry;
  static bool get isProgressOpen => _entry != null;
  static Future modalessProgress() async {
    dismissModalessProgress();
    _entry = OverlayEntry(builder: (context) =>
        Center(child: CircularProgressIndicator())
    );
    Overlay.of(Get.overlayContext!).insert(_entry!);
  }

  static dismissModalessProgress() {
    if (_entry != null) {
      _entry?.remove();
      _entry = null;
    }
  }

}