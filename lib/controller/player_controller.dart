import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends GetxController {
  late VideoPlayerController _playerController;
  VideoPlayerController get playerController => _playerController;

  final _isReady = false.obs;
  bool get isReady => _isReady.value;
  double get aspectRatio => _playerController.value.aspectRatio;


  @override
  void onInit() {
    _playerController = VideoPlayerController.networkUrl(Uri.parse('http://192.168.100.9:8080/test/1691986398458.HD.m3u8'));
    _playerController.initialize().then((value) {
      _isReady.value = true;
    });
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  onPlay() {
    if (_playerController.value.isPlaying) {
      _playerController.pause();
    }
    else {
      _playerController.play();
    }
  }
}