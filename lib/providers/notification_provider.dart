import 'package:flutter/material.dart';
import '../classes/notification_class.dart';
import '../network_services/notification_service.dart';

class RequestsProvider extends ChangeNotifier {
  final _notificationRequestFetch = RequestNotificationFetch();
  bool isLoading = false;
  List<RequestClass> _requests = [];
  List<RequestClass> get requests => _requests;

  Future<void> getAllConcerts() async {
    isLoading = true;
    notifyListeners();
    final response = await _notificationRequestFetch.getAll();
    _requests = response;
    isLoading = false;
    notifyListeners();
  }
}
