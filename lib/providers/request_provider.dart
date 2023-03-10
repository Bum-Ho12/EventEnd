import 'package:flutter/material.dart';
import '../network_services/request_network.dart';

class RequestProvider extends ChangeNotifier {
  String _id = '';
  String _title = '';
  String _description = '';
  bool isLoading = false;
  final _requestSend = RequestSend();
  bool? _isSent;
  String get id => _id;
  String get title => _title;
  String get description => _description;
  bool? get isSent => _isSent;

  Future<void> setToSend(String id, title, description) async {
    _id = id;
    _title = title;
    _description = description;
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  Future<void> sendRequest() async {
    isLoading = true;
    notifyListeners();
    final response = await _requestSend.addRequest(_id, _title, _description);
    _isSent = response;
    isLoading = false;
    notifyListeners();
  }
}
