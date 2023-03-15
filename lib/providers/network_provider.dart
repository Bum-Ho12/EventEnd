import 'package:flutter/material.dart';
import '../network_services/network_call.dart';

class NetworkProvider extends ChangeNotifier {
  final _networkCheck = NetworkCall();
  bool isLoading = false;
  bool? _isConnected;
  bool? get isConnected => _isConnected;

  Future<void> checkNetwork() async {
    isLoading = true;
    notifyListeners();
    final bool? response = await _networkCheck.internetConnection();
    if (response == true) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }

    isLoading = false;
    notifyListeners();
  }
}
