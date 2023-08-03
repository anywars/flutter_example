import 'package:flutter_example/common/analytics.dart';
import 'package:flutter_example/service/example_service.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final _googleSignIn = GoogleSignIn(scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  final _service = Get.find<ExampleService>();

  @override
  void onInit() {
    Analytics.instance.logScreen("screen_sign_in");
    _googleSignIn.onCurrentUserChanged.listen((account) async {
      if (account != null) {
        print( "logined: ${account.displayName}" );
        await _service.saveGoogleAccount(account);
      }
      Analytics.instance.logLogin("google", account!.id);
    });
    _googleSignIn.signInSilently();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onSignIn() => _googleSignIn.signIn();
}