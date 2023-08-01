import 'package:flutter/material.dart';
import 'package:flutter_example/controller/geolocator_controller.dart';
import 'package:get/get.dart';


class GeolocatorPage extends GetView<GeolocatorController> {
  static final routeName = "/geolocator";

  @override
  Widget build(BuildContext context) {
    // Icon(Icons.highlight_off_outlined,);
    return Scaffold(
      appBar: AppBar(title: Text('Geolocator'),),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            ElevatedButton(onPressed: controller.onCurrentPosition, child: Text('현우치')),
            Obx(() => Text(controller.currentLocation)),

          ],
        ),
      )
    );
  }






}