import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/text_controller.dart';
import '../models/hate_speech_response_model.dart';
import '../services/api_services.dart';
import '../widgets/action_button_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/result_show_widget.dart';
import '../widgets/text_input_widget.dart';
import '../widgets/upload_file_widget.dart';
import '../utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _textController = TextEditingController();
  bool isUploadMode = false;
  bool isLoading = false;
  String _resultText = 'ACCEPTED';
  Color _resultColor = Colors.grey;
  bool showUploadButton = false;
  XFile? _selectedImageFile;

  void _updateResult(String label) {
    setState(() {
      _resultText = label.replaceAll('-', ' ').toUpperCase();
      _resultColor = labelColorMap[label] ?? Colors.grey;
      showUploadButton = label == 'non-hate' || label == 'non-offensive';
    });
  }

  void _onImageSelected(XFile image) async {
    setState(() {
      _selectedImageFile = image;
    });

    try {

      final classificationResult = await _apiService.classifyImage(image);


      if (classificationResult.containsKey('label')) {
        _updateResult(classificationResult['label']);
      } else {
        _updateResult('unknown');
      }
    } catch (e) {
      print('Error during image classification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'CHECK CONTENT VALIDITY',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 1, 40, 40),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height * 0.04),
                Center(
                  child: ResultShowWidget(
                    resultText: _resultText,
                    resultColor: _resultColor,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionButtonWidget(
                      icon: Icons.photo,
                      onPressed: () => setState(() => isUploadMode = true),
                    ),
                    const SizedBox(width: 20),
                    ActionButtonWidget(
                      icon: Icons.edit_note,
                      onPressed: () => setState(() => isUploadMode = false),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.04),
                isUploadMode
                    ? UploadFileWidget(
                  onFileSelected: _onImageSelected,
                )
                    : TextInputWidget(
                  textController: _textController,
                  isLoading: isLoading,
                ),
                SizedBox(height: screenSize.height * 0.06),
                showUploadButton
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionButtonWidget(
                      icon: Icons.upload,
                      onPressed: () {
                        String inputText = _textController.text.trim();
                        _uploadContent(inputText, context);
                      },
                    ),
                    const SizedBox(width: 20),
                    ActionButtonWidget(
                      icon: Icons.cancel_rounded,
                      onPressed: () =>
                          setState(() => showUploadButton = false),
                    ),
                  ],
                )
                    : ButtonWidget(
                  title: 'SCAN',
                  onTap: () async {
                    if (_selectedImageFile != null) {
                      setState(() => isLoading = true);
                      try {
                        final classificationResult =
                        await _apiService.classifyImage(_selectedImageFile!);
                        _updateResult(classificationResult['label']);
                      } catch (e) {
                        print('Error: $e');
                      } finally {
                        setState(() => isLoading = false);
                      }
                    } else {
                      String inputText = _textController.text.trim();
                      if (inputText.isNotEmpty) {
                        setState(() => isLoading = true);
                        try {
                          HateSpeechResponse response =
                          await _apiService.detectHateSpeech(inputText);
                          _updateResult(response.label);
                        } catch (e) {
                          print('Error: $e');
                        } finally {
                          setState(() => isLoading = false);
                        }
                      } else {
                        _updateResult('unknown');
                      }
                    }
                  },
                  color: const Color.fromARGB(255, 6, 63, 63),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _uploadContent(String text, BuildContext context) {
    final textController = Get.find<TextController>();
    if (text.isNotEmpty) {
      textController.addText(text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uploaded'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Text in the box')),
      );
    }
  }
}
