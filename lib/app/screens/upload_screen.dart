import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';

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
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // imagePickerMethod(ImageSource.gallery);
                  },
                  child: Icon(Icons.edit_note),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  ),
                ),
              ],
            )),
            Expanded(
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color.fromARGB(255, 208, 213, 218),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'ACCEPTED',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 19,
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              flex: 0,
              child: ButtonWidget(
                title: 'SCAN',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadScreen()));
                },
                color: const Color.fromARGB(255, 159, 129, 129),
              ),
            )
          ],
        ),
      ),
    );
  }
}
