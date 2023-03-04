import 'package:flutter/material.dart';
import '../network_services/connectivity.dart';

class NetworkProvider extends ChangeNotifier {
  final _networkCheck = NetworkConnectivity();
  bool isLoading = false;
  bool _isConnected = false;
  bool get isDeviceConnected => _isConnected;

  Future<void> checkNetwork() async {
    isLoading = true;
    notifyListeners();
    final bool response = await _networkCheck.checkNetwork();
    if (response == true) {
      _isConnected = response;
    }

    isLoading = false;
    notifyListeners();
  }
}
