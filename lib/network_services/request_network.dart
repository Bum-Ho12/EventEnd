import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RequestSend {
  Future<bool> addRequest(id, title, description) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String url = 'https://eventend.pythonanywhere.com/request_send/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('POST', uri);
    req.headers.addAll(headers);
    req.fields['description'] = description;
    req.fields['service_title'] = title;
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
