import 'dart:convert';
import 'package:http/http.dart' as http;

class ApodModel {
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  ApodModel({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      date: json['date'] ?? '',
      explanation: json['explanation'] ?? '',
      hdurl: json['hdurl'] ?? json['url'] ?? '',
      mediaType: json['media_type'] ?? '',
      serviceVersion: json['service_version'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class NasaService {
  static const String _baseUrl = 'https://api.nasa.gov/planetary/apod';
  static const String _apiKey = 'DEMO_KEY'; // Recommend user to get their own key at api.nasa.gov

  Future<ApodModel?> getAstronomyPictureOfTheDay() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey'));

      if (response.statusCode == 200) {
        return ApodModel.fromJson(json.decode(response.statusCode == 200 ? response.body : ''));
      } else {
        print('Failed to load APOD: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching APOD: $e');
      return null;
    }
  }
}
