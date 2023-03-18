import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/service_class.dart';

class FavoriteServiceFetch {
  Future<List<Service>> getAll() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    const url = 'https://eventend.pythonanywhere.com/service_favorites/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('GET', uri);
    req.headers.addAll(headers);
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final services = json.map((e) {
        return Service(
          id: e['id'],
          title: e['service']['service_title'],
          organizer: e['owner']['organizer'],
          organizerId: e['owner']['organizer_id'],
          email: e['service']['email'],
          organizerProfilePicture: e['service']['service_owner_profile'],
          organizerPhoneNumber: e['service']['phone_number'],
          webLink: e['service']['organizer_media_link'],
          long: e['service']['long'].toString(),
          lat: e['service']['lat'].toString(),
          description: e['service']['description'],
          price: e['service']['price'].toString(),
          permit: e['service']['permit'],
          traffic: e['service']['traffic'],
          socialMediaLink: e['service']['organizer_media_link'],
        );
      }).toList();
      return services;
    }
    throw 'error fetching data';
  }
}
