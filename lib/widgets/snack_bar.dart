import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class SnackNotification {
  const SnackNotification._();
  static snackCaller(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ThemeApplication.lightTheme.backgroundColor,
        content: Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: ThemeApplication.lightTheme.backgroundColor2,
          ),
        ),
        action: SnackBarAction(
          textColor: ThemeApplication.lightTheme.backgroundColor2,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          label: 'Dismiss',
        ),
      ),
    );
  }
}
