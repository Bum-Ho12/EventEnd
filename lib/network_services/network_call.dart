import 'package:http/http.dart' as http;

class NetworkCall {
  String url = 'https://eventend.pythonanywhere.com/check_network/';
  Future<bool> internetConnection() async {
    bool connection = false;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      connection = true;
    }
    return connection;
  }
}
