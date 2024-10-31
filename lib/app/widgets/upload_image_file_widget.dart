import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UploadImageFileWidget extends StatefulWidget {
  final Function(XFile) onFileSelected;

  UploadImageFileWidget({required this.onFileSelected});

  @override
  _UploadImageFileWidgetState createState() => _UploadImageFileWidgetState();
}

class _UploadImageFileWidgetState extends State<UploadImageFileWidget> {
  XFile? _imageFile;
  String _fileName = "No file selected";
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    log("Picking an image...");
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    print("Image picked: $pickedFile");

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        _fileName = pickedFile.name;
      });
      widget.onFileSelected(_imageFile!);
    } else {
      setState(() {
        _fileName = "No file selected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_fileName),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text("Upload Image"),
          ),
        ],
      ),
    );
  }
}
