class HateSpeechResponse {
  final String label;

  HateSpeechResponse({required this.label});

  factory HateSpeechResponse.fromJson(Map<String, dynamic> json) {
    return HateSpeechResponse(
      label: json['label']?.toLowerCase() ?? 'unknown', 
    );
  }
}
