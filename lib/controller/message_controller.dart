import 'package:flutter_example/common/analytics.dart';
import 'package:flutter_example/ui/firebase/firebase_messaging.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {

  late MessageArguments? arguments;

  @override
  void onInit() {
    super.onInit();
    arguments = Get.arguments as MessageArguments?;
    Analytics.instance.logScreen("screen_message");
  }

  @override
  void onClose() {
    super.onClose();
  }
}