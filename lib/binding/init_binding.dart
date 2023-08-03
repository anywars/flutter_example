import 'package:flutter_example/service/example_service.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExampleService(), permanent: true);
  }
}