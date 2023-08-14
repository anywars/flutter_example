import 'package:flutter/material.dart';
import 'package:flutter_example/controller/player_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends GetView<PlayerController> {
  static const routeName = '/player';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Obx(() => controller.isReady ? AspectRatio(aspectRatio: controller.aspectRatio, child: VideoPlayer(controller.playerController)) : Container()),

    floatingActionButton: FloatingActionButton(
      onPressed: controller.onPlay,
    ),
  );
}