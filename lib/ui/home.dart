import 'package:flutter/material.dart';
import 'package:flutter_example/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  static final routeName = '/home';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [

          ElevatedButton(onPressed: controller.onImage, child: Text('Image Picker')),
          ElevatedButton(onPressed: controller.onAnimatedText, child: Text('Animated Text')),
          ElevatedButton(onPressed: controller.onGeolocator, child: Text('Geolocator')),
          ElevatedButton(onPressed: controller.onGithub, child: Text('Github')),
          ElevatedButton(onPressed: controller.onDialog, child: Text('Dialog')),
          ElevatedButton(onPressed: controller.onDialog, child: Text('Dialog')),

          ElevatedButton(onPressed: controller.onTheme, child: Text('Theme')),

        ],
      ),
    ),
  );

}