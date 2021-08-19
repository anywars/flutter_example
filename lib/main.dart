import 'dart:async';

import 'package:animations/animations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/ui/ext/utils.dart';
import 'package:flutter_example/ui/firebase/firebase_messaging.dart';
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

    var originalOnError = FlutterError.onError;
    FlutterError.onError = (errors) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errors);
      originalOnError!(errors);
    };
    return Future.delayed(Duration(seconds: 2));
  }
}



class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

  final _examples = [ImagePickerPage.routeName, SignInPage.routeName, MapsPage.routeName, LocalAuthPage.routeName, ];

  @override
  void initState() {
    super.initState();
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
      ),
      body: ListView.builder(
        itemCount: _examples.length,
        itemBuilder: (context, position) {
          return OpenContainer(
            transitionType: ContainerTransitionType.fade,
            closedBuilder: (_, open) {
              return Card(child: getRow(position),);
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

              else {
                return SignInPage();
              }
            });
        },
      ),


    );
  }

  Widget getRow(int i) {
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

    var isSubscribed = (await prefs.getBool("is_subscribed") ?? false);
    if (FirebaseMessaging.instance.isSupported() && !isSubscribed) {
      FirebaseMessaging.instance.subscribeToTopic("test");
      await prefs.setBool("is_subscribed", true);
      print("==== subscribed success!!! ====");
    }
  }

}
