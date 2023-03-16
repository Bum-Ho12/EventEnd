import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widgets/snack_bar.dart';

class Delete {
  Future<void> deleteItem(id, category, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String url = 'https://eventend.pythonanywhere.com/delete/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('DELETE', uri);
    req.headers.addAll(headers);
    req.fields['choice'] = category;
    req.fields['id'] = id.toString();
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.body == 'deleted successfully') {
      Navigator.popUntil(
        context,
        ModalRoute.withName(Navigator.defaultRouteName),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackNotification.snackCaller(context, 'Deleted Successfully'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackNotification.snackCaller(context, 'Error Deleting'));
    }
  }
}
