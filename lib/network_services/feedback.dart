import 'package:http/http.dart' as http;

class FeedBack {
  Future<void> sendFeedBack(option, id) async {
    const url = 'https://eventend.pythonanywhere.com/feed_back/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('POST', uri);
    req.fields['option'] = option;
    req.fields['id'] = id.toString();
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 201) {
    } else {}
  }
}
