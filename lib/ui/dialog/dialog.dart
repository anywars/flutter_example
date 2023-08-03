import 'package:flutter/material.dart';
import 'package:flutter_example/controller/dialog_controller.dart';
import 'package:get/get.dart';

class DialogPage extends GetView<DialogController> {
  static final routeName = '/dialog';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Column(
      children: [
        ElevatedButton(onPressed: controller.onAlert, child: Text('Alert')),
        ElevatedButton(onPressed: controller.onConfirm, child: Text('Confirm')),
        ElevatedButton(onPressed: controller.onModalProgress, child: Text('Modal Progress')),
        ElevatedButton(onPressed: controller.onModalessProgress, child: Text('Modaless Progress')),
      ],
    ),
  );
}