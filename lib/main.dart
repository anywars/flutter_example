import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/binding/animated_text_binding.dart';
import 'package:flutter_example/binding/geolocator_binding.dart';
import 'package:flutter_example/binding/github_binding.dart';
import 'package:flutter_example/binding/home_binding.dart';
import 'package:flutter_example/binding/image_picker_binding.dart';
import 'package:flutter_example/binding/init_binding.dart';
import 'package:flutter_example/binding/message_binding.dart';
import 'package:flutter_example/ext/analytics.dart';
import 'package:flutter_example/ui/animated_text/animated_text.dart';
import 'package:flutter_example/ui/firebase/firebase_messaging.dart';
import 'package:flutter_example/ui/geolocator/geolocator.dart';
import 'package:flutter_example/ui/github.dart';
import 'package:flutter_example/ui/google/google_sign_in.dart';
import 'package:flutter_example/ui/home.dart';
import 'package:flutter_example/ui/image_picker/image_picker.dart';
import 'package:flutter_example/ui/theme.dart';
import 'package:get/get.dart';


Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("handling a background message: ${message.messageId}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (error) => FirebaseCrashlytics.instance.recordFlutterFatalError(error);
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);
  Analytics.instance.logAppOpen();
  
  runApp(MainPage());
}


class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Flutter Demo',

    locale: Get.deviceLocale,
    fallbackLocale: const Locale('ko', 'KR'),

    // theme: ThemeData.light(),
    theme: ExTheme.light(),
    darkTheme: ExTheme.dark(),

    // debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(name: HomePage.routeName, page: () => HomePage(), binding: HomeBinding()),
      GetPage(name: ImagePickerPage.routeName, page: () => ImagePickerPage(), binding: ImagePickerBinding()),
      GetPage(name: SignInPage.routeName, page: () => SignInPage()),
      GetPage(name: MessagingPage.routeName, page: () => MessagingPage()),
      
      GetPage(name: AnimatedTextPage.routeName, page: () => AnimatedTextPage(), binding: AnimatedTextBinding()),
      GetPage(name: GeolocatorPage.routeName, page: () => GeolocatorPage(), binding: GeolocatorBinding()),
      GetPage(name: MessagingPage.routeName, page: () => MessagingPage(), binding: MessageBinding()),
      GetPage(name: GithubPage.routeName, page: () => GithubPage(), binding: GithubBinding()),
    ],

    initialRoute: HomePage.routeName,
    initialBinding: InitBinding(),
    navigatorObservers: [Analytics.instance.observer],
  );
}