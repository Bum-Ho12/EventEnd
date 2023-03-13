import 'package:eventend/classes/service_class.dart';
import 'package:flutter/material.dart';
import '../network_services/service_favorites_fetch.dart';

class FavoriteServiceProvider extends ChangeNotifier {
  final _favoriteServiceFetch = FavoriteServiceFetch();
  bool isLoading = false;
  List<Service> _services = [];
  List<Service> get services => _services;

  Future<void> getAllServices() async {
    isLoading = true;
    notifyListeners();
    final response = await _favoriteServiceFetch.getAll();
    _services = response;
    isLoading = false;
    notifyListeners();
  }
}
