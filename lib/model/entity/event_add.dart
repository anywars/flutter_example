import 'package:flutter/material.dart';
import 'package:flutter_example/controller/calendar_controller.dart';
import 'package:get/get.dart';

class EventAddPage extends GetView<CalendarController> {
  static final routeName = '/eventAdd';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Column(
      children: [
        Expanded(child: SingleChildScrollView(
          child: Form(
            key: controller.keyForm,
            child: Column(
              children: [

                TextFormField(
                  validator: controller.validator,
                  onSaved: controller.onSaved,
                ),

              ],
            ),
          ),
        )),

        ElevatedButton(onPressed: controller.onSaveEvent, child: Text('Save')),
      ],
    ),
  );
}