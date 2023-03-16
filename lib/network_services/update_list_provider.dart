import 'package:eventend/network_services/delete.dart';
import 'package:flutter/material.dart';

class UpdateListProvider extends ChangeNotifier {
  final Delete _delete = Delete();
  bool? _isDeleted;
  bool? get isDeleted => _isDeleted;

  Future<bool?> deleteItem(id, category, context) async {
    _isDeleted = false;
    notifyListeners();
    final bool? response = await _delete.deleteItem(id, category, context);

    _isDeleted = response;
    notifyListeners();
    return _isDeleted;
  }
}
