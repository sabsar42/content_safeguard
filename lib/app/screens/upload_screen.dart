import 'dart:developer';
import 'package:content_safeguard/app/widgets/option_button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/content_controller.dart';
import '../models/hate_speech_response_model.dart';
import '../services/api_services.dart';
import '../widgets/action_button_widget.dart';
import '../widgets/result_display_widget.dart';
import '../widgets/text_input_widget.dart';
import '../widgets/upload_image_file_widget.dart';
import '../utils/constants.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _textController = TextEditingController();
  final ContentController _contentController = Get.find<ContentController>();
  bool isUploadMode = false;
  bool isLoading = false;
  bool showUploadButton = false;
  String _resultText = 'No Entries';
  Color _resultColor = Colors.grey;
  XFile? _selectedImageFile;



  void _updateResult(String label) {
    setState(() {
      _resultText = label.replaceAll('-', ' ').toUpperCase();
      _resultColor = labelColorMap[label] ?? Colors.grey;
      if (kDebugMode) {
       log("Classification label: $label");
      }
      showUploadButton = label == 'non-hate' || label == 'non-offensive' || label == 'SAFE';
    });
  }

  void _onImageSelected(XFile image) async {
    setState(() => _selectedImageFile = image);
    try {
      final classificationResult = await _apiService.classifyImage(image);
      _updateResult(classificationResult['label'] ?? 'unknown');
    } catch (e) {
      log('Error during image classification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create Post',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05,
                          vertical: screenSize.height * 0.01),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Content Validator',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenSize.height * 0.03),

                if (_resultText.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(bottom: screenSize.height * 0.03),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _resultColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _resultColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: ResultDisplayWidget(
                      resultText: _resultText,
                      resultColor: _resultColor,
                    ),
                  ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Post your content',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666),
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        children: [
                          OptionButtonWidget(
                            icon: Icons.photo,
                            label: 'Photo',
                            isSelected: isUploadMode,
                            onTap: () => setState(() {

                              isUploadMode = true;
                              if(isUploadMode){
                                _resultText = 'No Entries';
                              }
                            }),
                          ),
                          const SizedBox(width: 16),
                          OptionButtonWidget(
                            icon: Icons.edit_note,
                            label: 'Text',
                            isSelected: !isUploadMode,
                            onTap: () => setState(() {

                              isUploadMode = false;
                              if(!isUploadMode){
                                _resultText = 'No Entries';
                                _resultColor = Colors.grey;
                              }
                            }),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        child: isUploadMode
                            ? UploadImageFileWidget(onFileSelected: _onImageSelected)
                            : Padding(
                          padding: EdgeInsets.all(2),
                          child: TextInputWidget(
                            textController: _textController,
                            isLoading: isLoading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenSize.height * 0.04),

                if (showUploadButton)
                  Row(
                    children: [
                      Expanded(
                        child: ActionButtonWidget(
                          icon: Icons.upload,
                          label: 'Upload',
                          onPressed: () {
                            String inputText = _textController.text.trim();
                            if (inputText.isNotEmpty) _uploadTextContent(inputText, context);
                            if (_selectedImageFile != null) {
                              _uploadImageContent(_selectedImageFile!, context);
                            }
                          },
                          color: Color(0xFF064F60),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ActionButtonWidget(
                          icon: Icons.close,
                          label: 'Cancel',
                          onPressed: () => setState(() => showUploadButton = false),
                          color: Colors.grey[700]!,
                        ),
                      ),
                    ],
                  )
                else
                  ActionButtonWidget(
                    icon: Icons.search,
                    label: 'Scan Content',
                    onPressed: () async {
                      if (_selectedImageFile != null) {
                        setState(() => isLoading = true);
                        try {
                          final classificationResult = await _apiService.classifyImage(_selectedImageFile!);
                          _updateResult(classificationResult['label']);
                        } catch (e) {
                          log('Error: $e');
                        } finally {
                          setState(() => isLoading = false);
                        }
                      } else {
                        String inputText = _textController.text.trim();
                        if (inputText.isNotEmpty) {
                          setState(() => isLoading = true);
                          try {
                            HateSpeechResponse response = await _apiService.detectHateSpeech(inputText);
                            _updateResult(response.label);
                          } catch (e) {
                            log('Error: $e');
                          } finally {
                            setState(() => isLoading = false);
                          }
                        } else {
                          _updateResult('unknown');
                        }
                      }
                    },
                    color: Color(0xFF064F60),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _uploadTextContent(String text, BuildContext context) {
    if (text.isNotEmpty) {
      _contentController.addText(text);
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
  void _uploadImageContent(XFile image, BuildContext context) {
    _contentController.addImage(image);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image Uploaded'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
