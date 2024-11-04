import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../models/hate_speech_response_model.dart';

class ApiService {
  // final String textBaseUrl = 'http://localhost:8000';
  // final String imageBaseUrl = 'http://localhost:3000';
  final String baseUrl = 'https://89a6-27-147-224-141.ngrok-free.app';  // for ngrok public api, changes after every ngrok deployment
  Future<Map<String, dynamic>> getStatus() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load status: ${response.reasonPhrase}');
    }
  }

  Future<HateSpeechResponse> detectHateSpeech(String text) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/predict-text'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'inputs': text}),
      );

      if (response.statusCode == 200) {
        return HateSpeechResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to detect hate speech: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return HateSpeechResponse(label: 'unknown');
    }
  }

  Future<Map<String, dynamic>> classifyImage(XFile imageFile) async {
    final url = Uri.parse('$baseUrl/predict-image');

    try {
      final request = http.MultipartRequest('POST', url);

      final imageBytes = await imageFile.readAsBytes();

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: basename(imageFile.path),
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to classify image: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      return {'label': 'error', 'confidence': 0.0};
    }
  }

}
