import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddFavorite {
  Future<bool> addConcert(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String url = 'https://eventend.pythonanywhere.com/favorite_create/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('POST', uri);
    req.headers.addAll(headers);
    req.fields['category'] = 'concert';
    req.fields['id'] = id.toString();
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      if (json.isNotEmpty) {
        return true;
      }
    }
    throw 'error fetching data';
  }

  Future<bool> addService(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String url = 'https://eventend.pythonanywhere.com/favorite_create/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('POST', uri);
    req.headers.addAll(headers);
    req.fields['category'] = 'service';
    req.fields['id'] = id.toString();
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    try {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        if (json.isNotEmpty) {
          // print(json);
          return true;
        } else {
          // print(json);
          return false;
        }
      }
    } catch (e) {
      // print(e);
    }
    // throw 'error fetching data';
    return false;
  }
}
