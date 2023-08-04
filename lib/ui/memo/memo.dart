import 'package:flutter/material.dart';
import 'package:flutter_example/controller/memo_controller.dart';
import 'package:get/get.dart';


class MemoPage extends GetView<MemoController> {
  static final routeName = '/memo';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Column(
      children: [
        Expanded(child: Obx(() => ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          children: controller.memos.map((memo) => ListTile(
            key: Key('${memo.id}'),
            title: Text('${memo.memo}'),
            trailing: IconButton(
              onPressed: () => controller.onDeleteMemo(memo),
              icon: Icon(Icons.clear, color: Colors.red),
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          )).toList(),

          onReorder: (oldIdx, newIdx) async {
            if (oldIdx == newIdx) return;
            if (oldIdx < newIdx) {
              newIdx -= 1;
            }
            final memos = controller.memos;
            memos.insert(newIdx, memos.removeAt(oldIdx));
            await controller.onUpdateSort(memos);
          },
        ))),

        Divider(),
        Form(
          key: controller.keyForm,
          child: Row(
            children: [
              Expanded(child: TextFormField(
                validator: controller.onValidate,
                onSaved: controller.onSavedMemo,
              )),
              TextButton(onPressed: controller.onSaveMemo, child: Text('save')),
            ],
          ),
        ),
      ],
    )
  );
}