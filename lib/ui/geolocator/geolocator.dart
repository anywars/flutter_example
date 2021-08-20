import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class GeolocatorPage extends StatefulWidget {
  static final routeName = "/geolocator";

  @override
  State createState() => _GeolocatorState();
}

class _GeolocatorState extends State<GeolocatorPage> {

  final _geolocator = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();
  }

  final _threeMin = 1000 * 60 * 3;
  String currentLocation = "";

  @override
  Widget build(BuildContext context) {
    // Icon(Icons.highlight_off_outlined,);
    return Scaffold(
      appBar: AppBar(title: Text('Geolocator'),),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [


            ElevatedButton(onPressed: () {

              _getCurrentPosition()
                  .then((position) =>
                    setState(() => currentLocation = "${position.toJson()}")
                  );

            }, child: Text('현우치')),

            Text(currentLocation),

          ],
        ),
      )
    );
  }


  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await _geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    var permission = await _geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied, we cannot request permissions");
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      var position = await _geolocator.getLastKnownPosition();

      final now = DateTime.now().millisecondsSinceEpoch;
      if (position == null || (position.timestamp?.millisecondsSinceEpoch ?? 0) <= now - _threeMin) {
        position = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      }
      return position;
    }
    else {
      return Future.error("...");
    }
  }



}