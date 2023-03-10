import 'package:eventend/classes/favorites.dart';
import 'package:eventend/network_services/concert_favorites_fetch.dart';
import 'package:flutter/material.dart';

class FavoriteConcertProvider extends ChangeNotifier {
  final _favoriteConcertFetch = FavoriteConcertFetch();
  bool isLoading = false;
  List<FavoriteConcert> _concerts = [];
  List<FavoriteConcert> get concerts => _concerts;

  Future<void> getAllConcerts() async {
    isLoading = true;
    notifyListeners();
    final response = await _favoriteConcertFetch.getAll();
    _concerts = response;
    isLoading = false;
    notifyListeners();
  }
}

