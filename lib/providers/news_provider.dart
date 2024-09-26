import 'package:flutter/material.dart';
import 'package:haberuygulamasi/services/news_services.dart';
class NewsProvider with ChangeNotifier {
  List<dynamic> _news = [];
  bool _isLoading = false;
  String _selectedCategory = 'general';

  List<dynamic> get news => _news;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    fetchNews();
  }

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners(); // Durumun değiştiğini haber veriyoruz

    try {
      final newsData = await NewsServices().fetchNews(category: _selectedCategory);
      _news = newsData;
    } catch (error) {
      print('Haberler alınamadı: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
