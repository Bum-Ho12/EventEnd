import 'package:flutter/material.dart';

class ConcertCreateProvider extends ChangeNotifier {
  bool isLoading = false;
  String _title = '';
  String _description = '';
  String _eventDate = '';
  String _fromHour = '';
  String _toHour = '';
  String _location = '';
  int _price = 0;
  String _webLink = '';

  bool? _isSent;
  String get webLink => _webLink;
  String get title => _title;
  String get description => _description;
  String get eventDate => _eventDate;
  String get fromHour => _fromHour;
  String get toHour => _toHour;
  String get location => _location;
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

  Future<void> setEventDate(String value) async {
    _eventDate = value;
    notifyListeners();
  }

  Future<void> setFromHour(String value) async {
    _fromHour = value;
    notifyListeners();
  }

  Future<void> setToHour(String value) async {
    _toHour = value;
    notifyListeners();
  }

  Future<void> setLocation(String value) async {
    _location = value;
    notifyListeners();
  }

  Future<void> setPrice(int value) async {
    _price = value;
    notifyListeners();
  }
}
