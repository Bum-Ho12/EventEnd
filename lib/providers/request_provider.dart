import 'package:flutter/material.dart';
import '../network_services/request_network.dart';

class RequestProvider extends ChangeNotifier {
  String _id = '';
  String _description = '';
  String _organizerId = '';
  bool isLoading = false;
  final _requestSend = RequestSend();
  bool? _isSent;
  String get id => _id;
  String get description => _description;
  String get organizerId => _organizerId;
  bool? get isSent => _isSent;

  Future<void> setToSend(String id, organizerId, description) async {
    _id = id;
    _description = description;
    _organizerId = organizerId;
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  Future<void> sendRequest() async {
    isLoading = true;
    notifyListeners();
    final response =
        await _requestSend.addRequest(_id, _organizerId, _description);
    _isSent = response;
    isLoading = false;
    notifyListeners();
  }
}
