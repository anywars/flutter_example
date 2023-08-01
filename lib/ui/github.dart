import 'package:flutter/material.dart';
import 'package:flutter_example/controller/github_controller.dart';
import 'package:flutter_example/ext/ui/text.dart';
import 'package:get/get.dart';

class GithubPage extends GetView<GithubController> {
  static final routeName = '/github';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [

        ElevatedButton(onPressed: controller.test, child: Text('======')),
        
        Expanded(
          child: Obx(() => ListView.separated(
            separatorBuilder: (_, idx) => Divider(),
            itemBuilder: (context, idx) {
              final item = controller.items[idx];
              return ListTile(
                onTap: () => print("=== $item"),
                title: ExText.bodyMedium(context, '${item.fullName}'),
                subtitle: ExText.bodySmall(context, '${item.description}'),
              );
            },
            itemCount: controller.items.length,
          )),
        ),

      ],
    ),
  );
}