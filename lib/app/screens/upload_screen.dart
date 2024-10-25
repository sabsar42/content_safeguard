import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 239, 225),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text('Check Content Validity')),
            SizedBox(
              height: 19,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // imagePickerMethod(ImageSource.gallery);
                  },
                  child: Icon(Icons.photo),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 12.0), // Button padding
                  ),
                ),
              ],
            )),
            Expanded(
              flex: 2,
              child: Container(
                width: 400,
                height: 100,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 12, 57, 93),
                  ),
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter your text here',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
