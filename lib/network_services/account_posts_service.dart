import 'dart:convert';
import 'package:eventend/classes/service_class.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/concert_class.dart';

class PostsFetch {
  Future<List<Concert>> getAllConcerts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String url = 'https://eventend.pythonanywhere.com/user_posts/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('GET', uri);
    req.headers.addAll(headers);
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['concerts'] as List;
      final concerts = data.map((e) {
        return Concert(
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

class ServicePostsFetch {
  Future<List<Service>> getAllServices() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String url = 'https://eventend.pythonanywhere.com/user_posts/';
    final uri = Uri.parse(url);
    Map<String, String> headers = {"Authorization": "Token $token"};
    final req = http.MultipartRequest('GET', uri);
    req.headers.addAll(headers);
    final res = await req.send();
    final response = await http.Response.fromStream(res);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['services'] as List;
      final services = data.map((e) {
        return Service(
          id: e['id'],
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
      return services;
    }
    throw 'error fetching data';
  }
}
