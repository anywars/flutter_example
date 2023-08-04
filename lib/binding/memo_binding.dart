import 'package:flutter_example/controller/memo_controller.dart';
import 'package:get/get.dart';

class MemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MemoController());
  }
}