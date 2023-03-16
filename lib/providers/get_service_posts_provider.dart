import 'package:eventend/classes/service_class.dart';
import 'package:flutter/material.dart';
import '../network_services/account_posts_service.dart';

class GetServicePostsProvider extends ChangeNotifier {
  final _postFetch = ServicePostsFetch();
  // for services
  bool isLoading = false;
  List<Service> _services = [];
  List<Service> get services => _services;

  Future<void> getAllServices() async {
    isLoading = true;
    notifyListeners();
    final response = await _postFetch.getAllServices();
    _services = response;
    isLoading = false;
    notifyListeners();
  }

  void updateList(int index) {
    _services.removeAt(index);
    notifyListeners();
  }
}
