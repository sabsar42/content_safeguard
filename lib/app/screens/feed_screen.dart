import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/text_controller.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextController textController = Get.put(TextController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Screen'),
      ),
      body: GetBuilder<TextController>(
          init: textController,
          builder: (textController) {
            return ListView.builder(
              itemCount: textController.texts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      textController.texts[index],

                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
