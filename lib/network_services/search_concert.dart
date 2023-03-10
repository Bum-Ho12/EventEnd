import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/concert_search_class.dart';

class ConcertSearchFetch {
  Future<List<ConcertSearch>> getAllSearched(element) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String url =
        'https://eventend.pythonanywhere.com/search_concert?search=$element';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('GET', uri);
    req.headers.addAll(headers);
    final res = await req.send();
    final response = await http.Response.fromStream(res);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json["results"] as List;
      final concerts = data.map((e) {
        return ConcertSearch(
          id: e['id'],
          title: e['title'],
          organizer: e['concert']['organizer'],
          organizerId: e['concert']['organizer_id'],
          organizeProfilePicture: e['concert']['organizer_profile_picture'],
          concertPicture: e['concert_picture'],
          eventDate: e['event_date'],
          fromHour: e['from_hour'],
          toHour: e['to_hour'],
          location: e['location'],
          long: e['long'],
          lat: e['lat'],
          description: e['description'],
          price: e['price'],
          webLink: e['web_link'],
          traffic: e['traffic'],
          tickets: e['tickets'],
        );
      }).toList();
      return concerts;
    }
    throw 'error fetching data';
  }
}
