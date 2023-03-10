import 'package:eventend/classes/service_class.dart';
import 'package:flutter/material.dart';
import '../network_services/search_service.dart';

class ServiceSearchProvider extends ChangeNotifier {
  String _searched = '';
  final _serviceFetch = ServiceSearchFetch();
  bool isLoading = false;
  List<Service> _services = [];
  String get searched => _searched;
  List<Service> get services => _services;

  Future<void> setSearched(String newSearch) async {
    _searched = newSearch;
    notifyListeners();
    final response = await _serviceFetch.getAllSearched(_searched);
    _services = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSearchedServices() async {
    isLoading = true;
    notifyListeners();
    final response = await _serviceFetch.getAllSearched(_searched);
    _services = response;
    isLoading = false;
    notifyListeners();
  }
}
