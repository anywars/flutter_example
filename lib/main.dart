import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/ext/analytics.dart';
import 'package:flutter_example/ext/utils.dart';
import 'package:flutter_example/ui/animated_text/animated_text.dart';
import 'package:flutter_example/ui/cached_network_image/cached_network_image.dart';
import 'package:flutter_example/ui/firebase/firebase_messaging.dart';
import 'package:flutter_example/ui/geolocator/geolocator.dart';
import 'package:flutter_example/ui/google/google_maps.dart';
import 'package:flutter_example/ui/google/google_sign_in.dart';
import 'package:flutter_example/ui/image_picker/image_picker.dart';
import 'package:flutter_example/ui/local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("handling a background message: ${message.messageId}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);
  Analytics.instance.logAppOpen();

  runZonedGuarded(() {
    runApp(MainPage());
  }, FirebaseCrashlytics.instance.recordError);
}

class MainPage extends StatefulWidget {

  @override
  State createState() => _MainState();

}

class _MainState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),

      // debugShowCheckedModeBanner: false,
      routes: {
        ImagePickerPage.routeName: (context) => ImagePickerPage(),
        SignInPage.routeName: (context) => SignInPage(),
        MessagingPage.routeName: (context) => MessagingPage(),
      },

      navigatorObservers: [Analytics.instance.observer],
      home: FutureBuilder(
        future: _initIntro(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                print("Error: ${snapshot.error}");
              }
              return MyHomePage(title: 'Flutter Demo Home Page');

            default:
              return IntroPage();
          }
        },
      ),
    );
  }


  Future<void> _initIntro() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    final originalOnError = FlutterError.onError;
    FlutterError.onError = (errors) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errors);
      originalOnError!(errors);
    };

    final remoteConfig = RemoteConfig.instance;
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
    Future.delayed(Duration(seconds: 2));
  }

}



class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Analytics.instance.logScreen("screen_intro");
    return Scaffold(
      body: Center(child: Text('Intro'),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _examples = [
    ImagePickerPage.routeName,
    SignInPage.routeName,
    MapsPage.routeName,
    LocalAuthPage.routeName,
    GeolocatorPage.routeName,
    CachedNetworkImagePage.routeName,
    AnimatedTextPage.routeName,
  ];

  @override
  void initState() {
    super.initState();
    Analytics.instance.logScreen("screen_home");
    _saveFcmToken();

    FirebaseMessaging.instance.getInitialMessage()
        .then((message) {
      if (message != null) {
        print("===== message: ${message.messageId}");
        Navigator.pushNamed(context, MessagingPage.routeName, arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      print("===== onMessage: ${message.notification?.body} ");

      showDialog(context: context, builder: (context) {
        return Utils.dialog(
            'Flutter Example',
            message.notification?.body ?? 'Empty Message', () {
          Navigator.popAndPushNamed(context, MessagingPage.routeName, arguments: MessageArguments(message, true));
        });
      });

    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("===== opened app: ${message.messageId}");
      Navigator.pushNamed(context, MessagingPage.routeName, arguments: MessageArguments(message, true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _examples.length,
        itemBuilder: (context, position) {
          return OpenContainer(
            transitionType: ContainerTransitionType.fade,
            closedBuilder: (_, open) {
              return Card(child: getView(position),);
            },
            openBuilder: (_, open) {
              var example = _examples[position];
              if (example == ImagePickerPage.routeName) {
                return ImagePickerPage();
              }

              else if (example == MapsPage.routeName) {
                return MapsPage();
              }

              else if (example == LocalAuthPage.routeName) {
                return LocalAuthPage();
              }

              else if (example == GeolocatorPage.routeName) {
                return GeolocatorPage();
              }

              else if (example == CachedNetworkImagePage.routeName) {
                return CachedNetworkImagePage();
              }

              else if (example == AnimatedTextPage.routeName) {
                return AnimatedTextPage();
              }

              else {
                return SignInPage();
              }
            });
        },
      ),


    );
  }

  Widget getView(int i) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Text(_examples[i]),
      ),
    );
  }

  _saveFcmToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    if (token == null || token.isEmpty == true) return;

    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);

    var isSubscribed = prefs.getBool("is_subscribed") ?? false;
    if (FirebaseMessaging.instance.isSupported() && !isSubscribed) {
      FirebaseMessaging.instance.subscribeToTopic("test");
      await prefs.setBool("is_subscribed", true);
      print("==== subscribed success!!! ====");
    }
  }

}
