import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsServices {
  final String _apiKey = '4iKgAArSGhcuLcROlBEyeC:46Qvp5dhJKAwGrXKYrFHpP';
  final String _baseUrl = 'https://api.collectapi.com/news/getNews';
  final String _country = 'tr';

  Future<List<dynamic>> fetchNews({required String category}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?country=$_country&tag=$category'),
      headers: {
        'authorization': 'apikey $_apiKey',
        'content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'];
    } else {
      throw Exception('Haberler alınamadı.');
    }
  }
}
