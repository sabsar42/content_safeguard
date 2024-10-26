import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/action_button_widget.dart';
import '../widgets/button_widget.dart';


class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _textController = TextEditingController();
  bool isUploadMode = false;
  String _resultText = 'ACCEPTED';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 239, 225),
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
                    color: Color.fromARGB(255, 12, 57, 93),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height * 0.04),

                Center(
                  child: Container(
                    width: screenSize.width * 0.6,
                    height: screenSize.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 208, 213, 218),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _resultText=='ACCEPTED'?Colors.grey.withOpacity(0.3):Colors.red,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _resultText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionButtonWidget(
                      icon: Icons.photo,
                      onPressed: () {
                        setState(() {
                          isUploadMode = true;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    ActionButtonWidget(
                      icon: Icons.edit_note,
                      onPressed: () {
                        setState(() {
                          isUploadMode = false;
                        });
                      },
                    )
                  ],
                ),

                SizedBox(height: screenSize.height * 0.04),
                isUploadMode
                    ? Container(
                  height: screenSize.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color.fromARGB(255, 12, 57, 93),
                      width: 1.5,
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Upload Files'),
                    ),
                  ),
                )
                    : Container(
                  height: screenSize.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color.fromARGB(255, 12, 57, 93),
                      width: 1.5,
                    ),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _textController, // Use the controller
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter your text here',
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                SizedBox(height: screenSize.height * 0.06),

                ButtonWidget(
                  title: 'SCAN',
                  onTap: () async {
                    String inputText = _textController.text.trim();
                    if (inputText.isNotEmpty) {

                      try {
                        final response = await _apiService.detectHateSpeech(inputText);
                        setState(() {
                          _resultText = response['label'] == 'offensive' ? 'OFFENSIVE' : 'ACCEPTED';
                        });
                      } catch (e) {
                        print('Error: $e');

                      }
                    } else {
                      setState(() {
                        _resultText = 'No Entries';
                      });
                    }
                  },
                  color: const Color.fromARGB(255, 159, 129, 129),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
