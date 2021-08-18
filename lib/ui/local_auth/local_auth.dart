import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('Local Auth'),),
      body: Column(
        children: [

          
          Text("${_availableBiometrics}")
        ],
      ),
    );
  }


}