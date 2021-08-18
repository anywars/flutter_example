import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class ImagePickerPage extends StatefulWidget {
  static final routeName = "/image_picker";
  ImagePickerPage({Key? key, VoidCallback? openContainer}): super(key: key);

  @override
  _ImagePickerWidget createState() => _ImagePickerWidget();
}

class _ImagePickerWidget extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  var _selectedImages = List<XFile>.of([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }


  List<Widget> attachButtons() {
    List<Widget> buttons = [];
    if (!kIsWeb) {
      buttons.add(MaterialButton(
        child: Text("Camera"),
        onPressed: () async {
          final file = await _picker.pickImage(source: ImageSource.camera);
          print("===== ${file?.path}");
          setState(() {
            _selectedImages.add(file!);
          });
        },
      ));
    }
    buttons.add(MaterialButton(
      child: Text("Image"),
      onPressed: () async {
        final list = await _picker.pickMultiImage();
        setState(() {
          _selectedImages.addAll(list!.where((f) => !_selectedImages.contains(f) ).toList());
        });
      },
    ));
    return buttons;
  }


  Widget selectedImage() {
    return Container(
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length,
        itemBuilder: (context, position) {
          return getRow(position);
        }
      ),
    );
  }


  Widget getRow(int position) {
    var item = _selectedImages[position];
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
                onPressed: () {
                  setState(() {
                    _selectedImages.removeAt(position);
                  });
                },
                icon: Image(image: AssetImage('assets/ic_close.png'), width: 20, height: 20,)
            ),
          ),

        ],
      ),
    );
  }



}


