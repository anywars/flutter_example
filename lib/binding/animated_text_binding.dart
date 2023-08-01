import 'package:flutter_example/controller/animated_text_controller.dart';
import 'package:get/get.dart';

class AnimatedTextBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AnimatedTextController());
  }
}