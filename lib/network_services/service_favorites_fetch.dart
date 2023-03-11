import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/favorites.dart';

class FavoriteServiceFetch {
  Future<List<FavoriteService>> getAll() async {
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
      final concerts = json.map((e) {
        return FavoriteService(
          id: e['id'],
          title: e['service']['service_title'],
          organizer: e['owner']['organizer'],
          organizerId: e['owner']['organizer_id'],
          organizerProfilePicture: e['service']['service_owner_profile'],
          serviceId: e['service']['service_id'],
          organizerMediaLink: e['owner']['organizer_media_link'],
        );
      }).toList();
      return concerts;
    }
    throw 'error fetching data';
  }
}
