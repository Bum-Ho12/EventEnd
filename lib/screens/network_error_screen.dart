import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/network_provider.dart';

class NetworkErrorScreen extends StatefulWidget {
  const NetworkErrorScreen({super.key});

  @override
  State<NetworkErrorScreen> createState() => _NetworkErrorScreenState();
}

class _NetworkErrorScreenState extends State<NetworkErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final NetworkProvider isConnected = Provider.of<NetworkProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/server.png',
              height: 100,
              width: 120,
            ),
            Text(
              'There is a problem with your \n'
              'Internet Connection',
              style: headline1detail,
            ),
            MaterialButton(
              color:
                  ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.7),
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              onPressed: () {
                setState(() {
                  isConnected.checkNetwork();
                });
              },
              child: Text(
                'Reload',
                style: headline2Profile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
