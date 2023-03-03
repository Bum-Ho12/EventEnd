import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApp {
  signIn(String email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {
      'email': email,
      'password': password,
    };

    // ignore: prefer_typing_uninitialized_variables
    var jsonResponse;
    var response = await http.post(
        Uri.parse("https://eventend.pythonanywhere.com/login/"),
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse != null) {
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("email", jsonResponse['email']);
        sharedPreferences.setString("username", jsonResponse['username']);
        sharedPreferences.setString('profile_pic', jsonResponse['profile_pic']);
        sharedPreferences.setBool('isLoggedIn', true);
        sharedPreferences.setString("password", password);
        // print(sharedPreferences.getKeys());
        // SnackNotification.cnackCaller(
        //     context, 'You are Signed In as ${jsonResponse['username']}');
      }
    } else {
      // final snackBar = SnackBar(
      //   content: AutoSizeText('Unable to Log In or wrong credentials'),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
