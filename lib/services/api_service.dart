import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ApiService {
  // TODO: Add your Pexels API Key here
  static const String apiKey = 'w3wW6fWUhZgDMLOC53bdVAa1FRUVXrV3qiuuO6uSCLZ5jA5nnNvrmP06';
  static const String baseUrl = 'https://api.pexels.com/v1';

  static Future<List<ImageModel>> searchImages(String query, int page, {int perPage = 20}) async {
    if (query.trim().isEmpty) return [];
    
    final response = await http.get(
      Uri.parse('$baseUrl/search?query=$query&page=$page&per_page=$perPage'),
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> photos = data['photos'];
      return photos.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images from Pexels API: ${response.statusCode}');
    }
  }
}
