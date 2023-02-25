import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String _searched = '';
  String get searched => _searched;
  setSearched(String newSearch) {
    _searched = newSearch;
    notifyListeners();
  }
}
