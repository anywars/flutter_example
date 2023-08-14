import 'package:flutter/material.dart';
import 'package:flutter_example/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  static final routeName = '/home';

  late final _list = [
    {'title': 'Image Picker', 'action': controller.onImage},
    {'title': 'Animated Text', 'action': controller.onAnimatedText},
    {'title': 'Geolocator', 'action': controller.onGeolocator},
    {'title': 'Github', 'action': controller.onGithub},
    {'title': 'Dialog', 'action': controller.onDialog},
    {'title': 'Calendar', 'action': controller.onCalendar},
    {'title': 'Database', 'action': controller.onMemo},
    {'title': 'Cached Network Image', 'action': controller.onCachedImage},
    {'title': 'Player', 'action': controller.onPlayer},
    {'title': 'Theme', 'action': controller.onTheme},
  ];


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: ListView.separated(
      itemBuilder: (_, index) => ListTile(
        title: Text(_list[index]['title'].toString()),
        onTap: _list[index]['action'] as Function(),
        trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),
      separatorBuilder: (_, index) => Divider(),
      itemCount: _list.length,
    ),
  );

}