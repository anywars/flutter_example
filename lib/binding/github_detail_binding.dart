import 'package:flutter_example/controller/github_controller.dart';
import 'package:flutter_example/controller/github_detail_controller.dart';
import 'package:flutter_example/provider/github_provider.dart';
import 'package:get/get.dart';

class GithubDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GithubDetailController());
  }
}