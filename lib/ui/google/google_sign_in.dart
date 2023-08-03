
import 'package:flutter/material.dart';
import 'package:flutter_example/controller/signin_controller.dart';
import 'package:get/get.dart';


class SignInPage extends GetView<SignInController> {
  static final routeName = "/google_sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("You are not currently signed in."),
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: controller.onSignIn,
            )
          ],
        ),
      ),
    );
  }


}