import 'package:flutter_example/controller/github_controller.dart';
import 'package:flutter_example/provider/github_provider.dart';
import 'package:get/get.dart';

class GithubBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GithubProvider());
    Get.put(GithubController());
  }
}