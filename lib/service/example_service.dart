import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_example/common/utils.dart';
import 'package:flutter_example/database/dao/memo_dao.dart';
import 'package:flutter_example/database/database.dart';
import 'package:flutter_example/ui/firebase/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';


class ExampleService extends GetxService {
  late final _storage = GetStorage();
  late MemoDao _memoDao;
  MemoDao get memoDao => _memoDao;

  @override
  void onInit() {
    $FloorExampleDatabase
      .databaseBuilder('example.db')
      .build()
      .then((db) {
        _memoDao = db.memoDao;
    });

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
        title: 'Flutter Example',
        message: message.notification?.body ?? 'Empty Message',
        onPressed: () => Get.toNamed(MessagingPage.routeName, arguments: MessageArguments(message, true))
      );

    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("===== opened app: ${message.messageId}");
      Get.toNamed(MessagingPage.routeName, arguments: MessageArguments(message, true));
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  _saveFcmToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    if (token == null || token.isEmpty == true) return;
    await _storage.write('token', token);

    var isSubscribed = _storage.read("is_subscribed") ?? false;
    if (await FirebaseMessaging.instance.isSupported() && !isSubscribed) {
      FirebaseMessaging.instance.subscribeToTopic("test");
      await _storage.write("is_subscribed", true);
      print("==== subscribed success!!! ====");
    }
  }

  Future saveGoogleAccount(GoogleSignInAccount? account) async {
    if (account == null) return;
    _storage.writeIfNull('id', account.id);
    _storage.writeIfNull('displayName', account.displayName);
    _storage.writeIfNull('email', account.email);
    _storage.writeIfNull('photoUrl', account.photoUrl);
    await _storage.save();
  }
}