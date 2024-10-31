import 'dart:ui';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final bool isLoading;

  const TextInputWidget({
    super.key,
    required this.textController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 1, 40, 40),
          width: 1.5,
        ),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          if (isLoading)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                color: Colors.teal.withOpacity(0.1),
              ),
            ),
          TextFormField(
            controller: textController,
            expands: true,
            maxLines: null,
            minLines: null,
            decoration: const InputDecoration(
              hintText: 'Enter your text here',
              contentPadding: EdgeInsets.all(15),
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            ),
        ],
      ),
    );
  }
}
