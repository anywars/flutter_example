import 'package:flutter_example/controller/geolocator_controller.dart';
import 'package:get/get.dart';

class GeolocatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GeolocatorController());
  }
}