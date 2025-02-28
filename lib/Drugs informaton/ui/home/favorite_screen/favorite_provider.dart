import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  // Map to hold the favorite status for each drug (key = drugId, value = isFavorite)
  Map<String, bool> _favorites = {};

  bool isFavorite(String drugId) {
    return _favorites[drugId] ?? false;
  }

  void toggleFavorite(String drugId) {
    _favorites[drugId] = !(_favorites[drugId] ?? false);
    notifyListeners();
  }
}
