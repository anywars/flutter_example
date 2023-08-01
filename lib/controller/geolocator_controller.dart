import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocatorController extends GetxController {

  final _geolocator = GeolocatorPlatform.instance;

  final _threeMin = 1000 * 60 * 3;
  Rx<String> _currentLocation = ''.obs;
  String get currentLocation => _currentLocation.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Position> onCurrentPosition() async {
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
        position = await _geolocator.getCurrentPosition(locationSettings: LocationSettings(
          accuracy: LocationAccuracy.best,
        ));
      }

      _currentLocation.value = "${position.toJson()}";
      return position;
    }
    else {
      return Future.error("...");
    }
  }
}