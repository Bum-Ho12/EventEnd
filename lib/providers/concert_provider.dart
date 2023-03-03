import 'package:flutter/material.dart';

import '../classes/concert_class.dart';
import '../network_services/concert_fetch.dart';

class ConcertProvider extends ChangeNotifier {
  final _concertFetch = ConcertFetch();
  bool isLoading = false;
  List<Concert> _concerts = [];
  List<Concert> get concerts => _concerts;

  Future<void> getAllConcerts() async {
    isLoading = true;
    notifyListeners();
    final response = await _concertFetch.getAll();
    _concerts = response;
    isLoading = false;
    notifyListeners();
  }
}
