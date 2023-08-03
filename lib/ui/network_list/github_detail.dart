import 'package:flutter/material.dart';
import 'package:flutter_example/controller/github_detail_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithubDetailPage extends GetView<GithubDetailController> {
  static final routeName = '/detail';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('${controller.item.name}')),
    body: WebViewWidget(controller: controller.wc),
  );
}