import 'package:flutter_example/common/base_web_controller.dart';
import 'package:flutter_example/common/utils.dart';
import 'package:flutter_example/model/item.dart';
import 'package:get/get.dart';

class GithubDetailController extends BaseWebController {
  late final item = Get.arguments as Item;

  @override
  void onInit() {
    loadRequest(item.htmlUrl!);
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  onPageStarted(String url) {
    Utils.modalessProgress();
  }

  @override
  onPageFinished(String url) {
    Utils.dismissModalessProgress();
  }
}