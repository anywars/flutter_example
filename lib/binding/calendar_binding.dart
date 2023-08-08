import 'package:flutter_example/controller/calendar_controller.dart';
import 'package:get/get.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalendarController());
  }
}