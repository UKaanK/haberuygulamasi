import 'package:flutter/material.dart';
import 'package:haberuygulamasi/models/news_model.dart';
import 'package:haberuygulamasi/services/news_services.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> _news = []; // News modeli kullandık
  bool _isLoading = false;
  String _selectedCategory = 'general';
  String? _error; // Hata durumu ekledik

  List<NewsModel> get news => _news;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String? get error => _error; // Hata getter'ı ekledik

  void setCategory(String category) {
    _selectedCategory = category;
    fetchNews();
  }

  Future<void> fetchNews() async {
    _isLoading = true;
    _error = null; // Her fetch işleminde hatayı sıfırlıyoruz
    notifyListeners(); // Durumun değiştiğini haber veriyoruz

    try {
      final newsData = await NewsServices().fetchNews(category: _selectedCategory);
      _news = newsData.map((item) => NewsModel.fromJson(item)).toList(); // Model dönüşümü
    } catch (error) {
      _error = 'Haberler alınamadı: $error'; // Hata mesajını kaydediyoruz
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
