import 'dart:convert';

import 'package:eventend/classes/service_class.dart';
import 'package:http/http.dart' as http;

class ServiceFetch {
  Future<List<Service>> getAll() async {
    const url = 'https://eventend.pythonanywhere.com/category/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('GET', uri);
    req.fields['category'] = 'services';
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final concerts = json.map((e) {
        return Service(
          title: e['title'],
          organizer: e['service']['organizer'],
          organizerId: e['service']['organizer_id'],
          organizerProfilePicture: e['service']['organizer_profile_picture'],
          long: e['long'],
          lat: e['lat'],
          description: e['description'],
          price: e['price'],
          permit: e['permit'],
          webLink: e['web_link'],
          traffic: e['traffic'],
          socialMediaLink: e['service']['organizer_media_link'],
        );
      }).toList();
      return concerts;
    }
    throw 'error fetching data';
  }
}
