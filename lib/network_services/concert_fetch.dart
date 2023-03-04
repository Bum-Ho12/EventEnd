import 'dart:convert';

import 'package:eventend/classes/concert_class.dart';
import 'package:http/http.dart' as http;

class ConcertFetch {
  Future<List<Concert>> getAll() async {
    const url = 'https://eventend.pythonanywhere.com/category/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('GET', uri);
    req.fields['category'] = 'concerts';
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final concerts = json.map((e) {
        return Concert(
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
