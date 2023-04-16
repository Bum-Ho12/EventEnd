import 'package:shared_preferences/shared_preferences.dart';

class AuthValidation {
  bool? isLoggedIn;
  Future<bool?> getAuthCheck() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('email') &&
        sharedPreferences.getBool('isActive') == true) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
    return isLoggedIn;
  }
}
