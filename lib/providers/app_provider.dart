import 'package:flutter/material.dart';
import '../models/image_model.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class AppProvider with ChangeNotifier {
  // Search and Pagination State
  List<ImageModel> _currentImages = [];
  bool _isLoading = false;
  int _currentPage = 1;
  String _currentQuery = '';

  List<ImageModel> get currentImages => _currentImages;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  String get currentQuery => _currentQuery;

  // Favourites State
  List<ImageModel> _favourites = [];
  List<ImageModel> get favourites => _favourites;

  AppProvider() {
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    _favourites = await DatabaseHelper.instance.getFavourites();
    notifyListeners();
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) return;
    _currentQuery = query;
    _currentPage = 1;
    await _fetchImages();
  }

  Future<void> nextPage() async {
    _currentPage++;
    await _fetchImages();
  }

  Future<void> previousPage() async {
    if (_currentPage > 1) {
      _currentPage--;
      await _fetchImages();
    }
  }

  Future<void> _fetchImages() async {
    if (_currentQuery.trim().isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentImages = await ApiService.searchImages(_currentQuery, _currentPage);
    } catch (e) {
      print("Error fetching images: $e");
      _currentImages = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isFavourite(int id) {
    return _favourites.any((img) => img.id == id);
  }

  Future<void> toggleFavourite(ImageModel image) async {
    if (isFavourite(image.id)) {
      await DatabaseHelper.instance.removeFavourite(image.id);
      _favourites.removeWhere((img) => img.id == image.id);
    } else {
      await DatabaseHelper.instance.addFavourite(image);
      _favourites.insert(0, image);
    }
    notifyListeners();
  }
}
