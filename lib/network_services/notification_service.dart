import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/notification_class.dart';

class RequestNotificationFetch {
  Future<List<RequestClass>> getAll() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    const url = 'https://eventend.pythonanywhere.com/view_notifications/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('GET', uri);
    req.headers.addAll(headers);
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final concerts = json.map((e) {
        return RequestClass(
          id: e['id'],
          clientId: e['client']['client_id'].toString(),
          client: e['client']['client'],
          clientProfilePicture: e['client']['client_profile_picture'],
          clientNumber: e['client']['client_number'],
          recipientId: e['recipient']['recipient_id'].toString(),
          recipient: e['recipient']['recipient'],
          recipientProfilePicture: e['recipient']['recipient_profile_picture'],
          recipientNumber: e['recipient']['recipient_number'],
          serviceId: e['service']['service_id'].toString(),
          serviceTitle: e['service']['service_title'],
          serviceDescription: e['service']['description'],
          description: e['description'],
          viewed: e['viewed'],
          price: e['service']['price'].toString(),
          permit: e['service']['permit'],
        );
      }).toList();
      return concerts;
    }
    throw 'error fetching data';
  }
}
