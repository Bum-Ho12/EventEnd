import 'package:flutter/material.dart';

class ServiceCreateProvider extends ChangeNotifier {
  bool isLoading = false;
  String _title = '';
  String _description = '';
  int _price = 0;
  String _webLink = '';

  bool? _isSent;
  String get webLink => _webLink;
  String get title => _title;
  String get description => _description;
  int get price => _price;
  bool? get isSent => _isSent;

  Future<void> setTitle(String value) async {
    _title = value;
    notifyListeners();
  }

  Future<void> setDescription(String value) async {
    _description = value;
    notifyListeners();
  }

  Future<void> setWebLink(String value) async {
    _webLink = value;
    notifyListeners();
  }

  Future<void> setPrice(int value) async {
    _price = value;
    notifyListeners();
  }
}
