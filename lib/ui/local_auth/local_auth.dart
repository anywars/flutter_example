import 'package:flutter/cupertino.dart';
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
    Analytics.instance.logEvent("screen_local_auth");

    return Scaffold(
      appBar: AppBar(title: Text('Local Auth'),),
      body: Column(
        children: _authentications(),
      ),
    );
  }


  List<Widget> _authentications() {
    List<Widget> widges = [];
    _availableBiometrics?.forEach((element) {
      widges.add(
        InkWell(
          child: Text('인증'),
            onTap: () {
              _auth.authenticate(
                  localizedReason: 'Let OS determine authentication method',
                  useErrorDialogs: true,
                  stickyAuth: true
              ).then((authenticated) {
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