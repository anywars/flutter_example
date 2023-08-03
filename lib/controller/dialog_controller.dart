import 'package:flutter/material.dart';
import 'package:flutter_example/common/utils.dart';
import 'package:get/get.dart';

class DialogController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onAlert() => Utils.dialog(message: '테스트');
  onConfirm() => Utils.confirm(message: '테스트', onPressed: () => Get.back());
  onModalProgress() => Utils.modalProgress(barrierColor: Colors.black26);
  onModalessProgress() => Utils.isProgressOpen ? Utils.dismissModalessProgress() : Utils.modalessProgress();
}