import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/concert_class.dart';

class FavoriteConcertFetch {
  Future<List<Concert>> getAll() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    const url = 'https://eventend.pythonanywhere.com/concert_favorites/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('GET', uri);
    req.headers.addAll(headers);
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final concerts = json.map((e) {
        return Concert(
          id: e['id'],
          title: e['concert']['concert_title'],
          organizer: e['owner']['organizer'],
          organizerId: e['owner']['organizer_id'],
          organizeProfilePicture: e['owner']['organizer_profile_picture'],
          concertPicture: e['concert']['concert_picture'],
          // concertId: e['concert']['concert_id'],
          webLink: e['owner']['organizer_media_link'],
          eventDate: e['concert']['event_date'],
          fromHour: e['concert']['from_hour'],
          toHour: e['concert']['to_hour'],
          location: e['concert']['location'],
          long: e['concert']['long'].toString(),
          lat: e['concert']['lat'].toString(),
          description: e['concert']['description'],
          price: e['concert']['price'].toString(),
          traffic: e['concert']['traffic'],
          tickets: e['concert']['tickets'],
        );
      }).toList();
      return concerts;
    }
    throw 'error fetching data';
  }
}
