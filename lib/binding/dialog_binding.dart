import 'package:flutter_example/controller/dialog_controller.dart';
import 'package:get/get.dart';

class DialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DialogController());
  }
}