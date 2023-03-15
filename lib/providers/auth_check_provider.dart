import 'package:flutter/material.dart';
import '../network_services/account_auth.dart';

class AuthProvider extends ChangeNotifier {
  final _authValidation = AuthValidation();
  bool isLoading = false;
  bool? _isConnected;
  bool? get isDeviceConnected => _isConnected;

  Future<void> checkNetwork() async {
    isLoading = true;
    notifyListeners();
    final bool? response = await _authValidation.getAuthCheck();
    if (response == true) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }

    isLoading = false;
    notifyListeners();
  }
}
