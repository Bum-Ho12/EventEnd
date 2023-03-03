import 'package:eventend/classes/service_class.dart';
import 'package:eventend/network_services/service_fetch.dart';
import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier {
  final _serviceFetch = ServiceFetch();
  bool isLoading = false;
  List<Service> _services = [];
  List<Service> get services => _services;

  Future<void> getAllServices() async {
    isLoading = true;
    notifyListeners();
    final response = await _serviceFetch.getAll();
    _services = response;
    isLoading = false;
    notifyListeners();
  }
}
