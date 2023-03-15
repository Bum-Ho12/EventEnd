import 'package:http/http.dart' as http;

class NetworkCall {
  bool? isConnected;

  Future<bool?> internetConnection() async {
    String url = 'https://eventend.pythonanywhere.com/check_network/';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    return isConnected;
  }
}
