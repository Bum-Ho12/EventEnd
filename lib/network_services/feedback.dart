import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FeedBack {
  Future<void> sendFeedBack(option, id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? email = sharedPreferences.getString('email');
    const url = 'https://eventend.pythonanywhere.com/feed_back/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('POST', uri);
    req.fields['option'] = option;
    req.fields['id'] = id.toString();
    req.fields['email'] = email!;
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 201) {
    } else {}
  }
}

class Complaint {
  Future<bool> sendFeedBack(option, id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    const url = 'https://eventend.pythonanywhere.com/complaint_send/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('POST', uri);
    req.headers.addAll(headers);
    req.fields['category'] = option;
    req.fields['id'] = id.toString();
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
