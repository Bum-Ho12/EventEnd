import 'package:flutter/material.dart';
import '../classes/concert_search_class.dart';
import '../network_services/search_concert.dart';

class ConcertSearchProvider extends ChangeNotifier {
  String _searched = '';
  final _concertFetch = ConcertSearchFetch();
  bool isLoading = false;
  List<ConcertSearch> _concerts = [];
  String get searched => _searched;
  List<ConcertSearch> get concerts => _concerts;

  Future<void> setSearched(String newSearch) async {
    _searched = newSearch;
    notifyListeners();
    final response = await _concertFetch.getAllSearched(_searched);
    _concerts = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSearchedConcerts() async {
    isLoading = true;
    notifyListeners();
    final response = await _concertFetch.getAllSearched(_searched);
    _concerts = response;
    isLoading = false;
    notifyListeners();
  }
}
