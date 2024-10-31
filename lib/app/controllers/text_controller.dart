import 'package:get/get.dart';

class TextController extends GetxController {
  var texts = <String>[].obs;

  void addText(String text) {
    if (text.isNotEmpty) {
      texts.add(text);
      update();
    }
  }


  List<String> get allTexts => texts.toList();
}
