import 'package:flutter_example/common/analytics.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {

  final ImagePicker _picker = ImagePicker();
  final _selectedImages = List<XFile>.of([]).obs;
  List<XFile> get selectedImages => _selectedImages;


  @override
  void onInit() {
    Analytics.instance.logScreen("screen_image_picker");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }


  onOpenCamera() async {
    final file = await _picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      _selectedImages.add(file);
    }
  }

  onOpenImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _selectedImages.add(file);
    }
  }

  onOpenMultiImage() async {
    final list = await _picker.pickMultiImage();
    if (list.isNotEmpty) {
      _selectedImages.clear();
      _selectedImages.addAll(
          list.where((f) => !_selectedImages.contains(f)).toList());
    }
  }

}