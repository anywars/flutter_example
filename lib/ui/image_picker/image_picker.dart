import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/controller/image_picker_controller.dart';
import 'package:get/get.dart';


class ImagePickerPage extends GetView<ImagePickerController> {
  ImagePickerPage({Key? key, VoidCallback? openContainer}): super(key: key);
  static final routeName = "/image_picker";

  @override
  Widget build(BuildContext context) =>
    Scaffold(
        appBar: AppBar(
        title: Text("ImagePicker"),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Row(children: attachButtons(),),

            Text("-------------------"),

            selectedImage(),

            Text("-------------------"),

          ],
        ),
      ),
    );


  List<Widget> attachButtons() {
    List<Widget> buttons = [];
    if (!kIsWeb) {
      buttons.add(Expanded(child: ElevatedButton(
        child: Text("Camera"),
        onPressed: controller.onOpenCamera,
      )));
    }
    buttons.add(Expanded(child: ElevatedButton(
      child: Text("Image"),
      onPressed: controller.onOpenImage,
    )));
    return buttons;
  }


  Widget selectedImage() {
    return Container(
      height: 100,
      child: Obx(() => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        scrollDirection: Axis.horizontal,
        itemCount: controller.selectedImages.length,
        itemBuilder: (context, position) {
          return getRow(position);
        }
      ),
    ));
  }


  Widget getRow(int position) {
    var item = controller.selectedImages[position];
    return  Container(
      width: 100,
      // padding: EdgeInsets.all(7),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: kIsWeb
                    ? Image.network(item.path, fit: BoxFit.fitWidth, )
                    : Image.file(File(item.path), fit: BoxFit.fitWidth, )
            ),
          ),


          Container(
            alignment: Alignment.topRight,
            transform: Matrix4.translationValues(14, -14, 0),
            child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () => controller.selectedImages.removeAt(position),
                icon: Image(image: AssetImage('assets/ic_close.png'), width: 20, height: 20,)
            ),
          ),

        ],
      ),
    );
  }



}


