import 'package:flutter/material.dart';
import 'package:flutter_example/ext/analytics.dart';
import 'package:local_auth/local_auth.dart';


class LocalAuthPage extends StatefulWidget {
  static final routeName = "/local_auth";

  @override
  State createState() => _LocalAuthState();

}

class _LocalAuthState extends State<LocalAuthPage> {
  final _auth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;

  @override
  void initState() {
    super.initState();
    Analytics.instance.logScreen("screen_local_auth");

    _auth.isDeviceSupported().then((isSupported) =>
      setState(() {
        if (isSupported) {
          _auth.getAvailableBiometrics()
              .then((availableBiometrics) {
                setState(() { _availableBiometrics = availableBiometrics; });
              });
        }
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local Auth'),),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: _authentications(),),
      ),
    );
  }


  List<Widget> _authentications() {
    List<Widget> widges = [];
    _availableBiometrics?.forEach((type) {
      widges.add(
        ElevatedButton(
          child: Text( type == BiometricType.fingerprint ? "지문인증" : "페이스아이디"),
            onPressed: () {
              Analytics.instance.logEvent(name: "click_local_auth", params: {"type": type.toString()});
              _auth.authenticate(
                  localizedReason: 'Let OS determine authentication method',
              ).then((authenticated) {
                Analytics.instance.logEvent(name: "result_local_auth", params: {"success": authenticated});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text((authenticated) ? '인증되었습니다.' : '인증실패했습니다.')));
              });
            },
          ),
      );
    });
    return widges;
  }
}