import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ContentController extends GetxController {
  var texts = <String>[].obs;
  var images = <XFile>[].obs;
  var isImageSafe = false.obs;
  var classificationResult = ''.obs;

  void addText(String text) {
    if (text.isNotEmpty) {
      texts.add(text);
      update();
    }
  }
  void addImage(XFile image) {
    images.add(image);
    update();
  }

  List<String> get allTexts => texts.toList();
  String get classification => classificationResult.value;
}
