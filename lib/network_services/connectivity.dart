import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnectivity {
  bool isDeviceConnected = false;
  Future<bool> checkNetwork() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        bool response;
        response = await InternetConnectionChecker().hasConnection;
        if (response == true) {
          isDeviceConnected = response;
        }
      }
    });
    return isDeviceConnected;
  }
}
