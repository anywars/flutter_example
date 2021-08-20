import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/ext/analytics.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  static final routeName = "/google_maps";

  @override
  State createState() => _MapsState();

}

class _MapsState extends State<MapsPage> {
  GoogleMapController? _controller;

  @override
  void initState() {
    Analytics.instance.logScreen("screen_maps");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var maps = GoogleMap(
      // liteModeEnabled: true,
      mapToolbarEnabled: true,
      // mapType: MapType.hybrid,
      myLocationButtonEnabled: true,

      initialCameraPosition: const CameraPosition(target: LatLng(37.484208, 126.970882), zoom: 15),
      onMapCreated: (controller) {
        setState(() {
          _controller = controller;
        });
      },
      markers: {
        _createMarker(37.488703, 126.960325),
      },

      onTap: (LatLng pos) {
        setState(() {
          print("===== ${pos}");
        });
      },
    );


    return Scaffold(
        appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: Stack(
        children: [
          Container(child: maps,),
        ],
      )
    );
  }

  Marker _createMarker(double lat, double lng) =>
    Marker(
      markerId: MarkerId("marker_1"),
      position: LatLng(lat, lng),
    );

}