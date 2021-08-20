
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/ext/analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignInPage extends StatefulWidget {
  static final routeName = "/google_sign_in";
  final _googleSignIn = GoogleSignIn(scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  @override
  State<StatefulWidget> createState() => SignInState();
}

class SignInState extends State<SignInPage> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    Analytics.instance.logScreen("screen_sign_in");

    widget._googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        if (account != null) {
          print( "logined: ${account.displayName}" );
        }
      });

      Analytics.instance.logLogin("google", account!.id);
    });
    widget._googleSignIn.signInSilently();
  }

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
              onPressed: () async {
                try {
                  await widget._googleSignIn.signIn();
                } catch (error) {
                  print(error);
                }
              },
            )
          ],
        ),
      ),
    );
  }


}