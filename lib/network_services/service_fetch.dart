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
      final services = json.map((e) {
        return Service(
          id: e['id'],
          title: e['title'],
          organizer: e['service']['organizer'],
          organizerId: e['service']['organizer_id'],
          email: e['service']['email'],
          organizerProfilePicture: e['service']['organizer_profile_picture'],
          organizerPhoneNumber: e['service']['phone_number'],
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
      return services;
    }
    throw 'error fetching data';
  }
}
