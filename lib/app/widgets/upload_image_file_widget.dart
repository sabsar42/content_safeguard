import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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
  final TextEditingController _urlController = TextEditingController();
  File? _urlImageFile;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        _fileName = pickedFile.name;
        _urlImageFile = null;
      });
      widget.onFileSelected(_imageFile!);
    } else {
      setState(() {
        _fileName = "No file selected";
      });
    }
  }

  Future<void> _loadImageFromUrl() async {
    final imageUrl = _urlController.text.trim();
    if (imageUrl.isEmpty) return;

    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${Random().nextInt(100)}.png');
      final response = await http.get(Uri.parse(imageUrl));
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        _urlImageFile = file;
        _fileName = file.path.split('/').last;
        _imageFile = null;
      });
      widget.onFileSelected(XFile(_urlImageFile!.path));
    } catch (e) {
      print("Failed to load image from URL: $e");
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
          SizedBox(height: 10),
          TextField(
            controller: _urlController,
            decoration: InputDecoration(
              labelText: 'Enter Image URL',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _loadImageFromUrl,
            child: Text("Load Image from URL"),
          ),
          SizedBox(height: 20),
          if (_imageFile != null || _urlImageFile != null)
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: _imageFile != null
                  ? Image.file(File(_imageFile!.path))
                  : Image.file(_urlImageFile!),
            ),
        ],
      ),
    );
  }
}
