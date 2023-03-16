import 'package:flutter/material.dart';
import '../classes/concert_class.dart';
import '../network_services/account_posts_service.dart';

class GetPostsProvider extends ChangeNotifier {
  final _postFetch = PostsFetch();
  bool isLoading = false;
  // for concerts
  List<Concert> _concerts = [];
  List<Concert> get concerts => _concerts;

  Future<void> getAllConcerts() async {
    isLoading = true;
    notifyListeners();
    final response = await _postFetch.getAllConcerts();
    _concerts = response;
    isLoading = false;
    notifyListeners();
  }

  void updateList(int index) {
    _concerts.removeAt(index);
    notifyListeners();
  }
}
