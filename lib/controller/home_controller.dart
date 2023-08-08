import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/common/analytics.dart';
import 'package:flutter_example/ui/animated_text/animated_text.dart';
import 'package:flutter_example/ui/cached_network_image/cached_network_image.dart';
import 'package:flutter_example/ui/dialog/dialog.dart';
import 'package:flutter_example/ui/geolocator/geolocator.dart';
import 'package:flutter_example/ui/image_picker/image_picker.dart';
import 'package:flutter_example/ui/memo/calendar.dart';
import 'package:flutter_example/ui/memo/memo.dart';
import 'package:flutter_example/ui/network_list/github.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Analytics.instance.logScreen("screen_home");
    _init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  _init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(<String, dynamic>{
      'client_id': 'v1',
      'client_secret': 'v2',
    });
    RemoteConfigValue(null, ValueSource.valueStatic);

    try {
      remoteConfig.fetchAndActivate();
    } on PlatformException catch (exception) {
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be used');
      print(exception);
    }

    print("== client_id: ${remoteConfig.getString("client_id")} ==");
    print("== client_secret: ${remoteConfig.getString("client_secret")} ==");
  }


  onImage() => Get.toNamed(ImagePickerPage.routeName);
  onAnimatedText() => Get.toNamed(AnimatedTextPage.routeName);
  onGeolocator() => Get.toNamed(GeolocatorPage.routeName);
  onGithub() => Get.toNamed(GithubPage.routeName);
  onDialog() => Get.toNamed(DialogPage.routeName);
  onMemo() => Get.toNamed(MemoPage.routeName);
  onCalendar() => Get.toNamed(CalendarPage.routeName);
  onCachedImage() => Get.toNamed(CachedNetworkImagePage.routeName);

  onTheme() => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);

}