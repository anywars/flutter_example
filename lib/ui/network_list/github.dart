import 'package:flutter/material.dart';
import 'package:flutter_example/controller/github_controller.dart';
import 'package:flutter_example/common/ui/text.dart';
import 'package:flutter_example/model/item.dart';
import 'package:flutter_example/ui/network_list/github_detail.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GithubPage extends GetView<GithubController> {
  static final routeName = '/github';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: PagedListView<int, Item>(pagingController: controller.pc, builderDelegate: PagedChildBuilderDelegate<Item>(
            itemBuilder: (_, item, index) => ListTile(
              onTap: () => Get.toNamed(GithubDetailPage.routeName, arguments: item),
              title: ExText.bodyMedium(context, item.fullName ?? ''),
              subtitle: ExText.bodySmall(context, item.description ?? ''),
            )
        )),
      ),
    ),
  );

}