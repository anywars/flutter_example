import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/ext/analytics.dart';
import 'package:flutter_example/ext/utils.dart';
import 'package:flutter_example/ui/animated_text/animated_text.dart';
import 'package:flutter_example/ui/firebase/firebase_messaging.dart';
import 'package:flutter_example/ui/geolocator/geolocator.dart';
import 'package:flutter_example/ui/github.dart';
import 'package:flutter_example/ui/image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Analytics.instance.logScreen("screen_home");
    _saveFcmToken();

    FirebaseMessaging.instance.getInitialMessage()
        .then((message) {
      if (message != null) {
        print("===== message: ${message.messageId}");
        Get.toNamed(MessagingPage.routeName, arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      print("===== onMessage: ${message.notification?.body} ");


      Utils.dialog(
          'Flutter Example',
          message.notification?.body ?? 'Empty Message', () {
        Get.toNamed(MessagingPage.routeName, arguments: MessageArguments(message, true));
      });

    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("===== opened app: ${message.messageId}");
      Get.toNamed(MessagingPage.routeName, arguments: MessageArguments(message, true));
    });

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

  _saveFcmToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    if (token == null || token.isEmpty == true) return;

    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);

    var isSubscribed = prefs.getBool("is_subscribed") ?? false;
    if (await FirebaseMessaging.instance.isSupported() && !isSubscribed) {
      FirebaseMessaging.instance.subscribeToTopic("test");
      await prefs.setBool("is_subscribed", true);
      print("==== subscribed success!!! ====");
    }
  }


  onImage() => Get.toNamed(ImagePickerPage.routeName);
  onAnimatedText() => Get.toNamed(AnimatedTextPage.routeName);
  onGeolocator() => Get.toNamed(GeolocatorPage.routeName);
  onGithub() => Get.toNamed(GithubPage.routeName);

  onTheme() => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);

}