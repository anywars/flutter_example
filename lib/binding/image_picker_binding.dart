import 'package:flutter_example/controller/image_picker_controller.dart';
import 'package:get/get.dart';

class ImagePickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImagePickerController());
  }
}