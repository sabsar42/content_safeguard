import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UploadFileWidget extends StatefulWidget {
  final Function(XFile) onFileSelected;

  UploadFileWidget({required this.onFileSelected});

  @override
  _UploadFileWidgetState createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  XFile? _imageFile;
  String _fileName = "No file selected";
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    print("Picking an image...");
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_fileName),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text("Upload Image"),
        ),
      ],
    );
  }
}
