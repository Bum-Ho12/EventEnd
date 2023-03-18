import 'package:eventend/Auth/sign_up_page.dart';
import 'package:eventend/screens/home_page.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApplication.lightTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: ThemeApplication.lightTheme.backgroundColor,
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 20
                  : MediaQuery.of(context).size.width * 0.2,
              right: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 20
                  : MediaQuery.of(context).size.width * 0.2,
              top: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.2
                  : MediaQuery.of(context).size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: headline1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'You are required as a customer to sign in'
                  ' our space for proper tracking of activities.',
                  style: headlineForTile,
                ),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: headlineTile,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset(
                              'assets/icons/email.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Password',
                      style: headlineTile,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: showPassword == false ? true : false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset(
                              'assets/icons/password.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          child: Text(
                            'View Password?',
                            style: headlineForTile,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Checkbox(
                            checkColor:
                                ThemeApplication.lightTheme.backgroundColor,
                            activeColor: ThemeApplication
                                .lightTheme.backgroundColor2
                                .withOpacity(0.7),
                            value: showPassword,
                            onChanged: (value) {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          signIn(
                            context,
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeApplication
                              .lightTheme.backgroundColor2
                              .withOpacity(0.8),
                          minimumSize: const Size(double.infinity, 56),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                          ),
                        ),
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(
                          "Sign In",
                          style: headline2Profile,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: headlineForTile,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Text(
                  'Sign Up with Email or Google',
                  style: headlineForTile,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: const SignUpPage()));
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/email.svg',
                      height: 64,
                      width: 64,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/icons/google.svg',
                      height: 64,
                      width: 64,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  signIn(context, String email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // ignore: prefer_typing_uninitialized_variables
    var jsonResponse;
    var url = Uri.parse("https://eventend.pythonanywhere.com/login/");
    final req = http.MultipartRequest('POST', url);
    req.fields['email'] = email;
    req.fields['password'] = password;
    try {
      final res = await req.send();
      var response = await http.Response.fromStream(res);
      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse != null) {
          setState(() {
            sharedPreferences.setString("token", jsonResponse['token']);
            sharedPreferences.setString("email", jsonResponse['email']);
            sharedPreferences.setString("username", jsonResponse['username']);
            sharedPreferences.setInt("category", jsonResponse['category']);
            sharedPreferences.setBool("isCustomer", jsonResponse['isCustomer']);
            if (jsonResponse['weekday_from'].toString().isNotEmpty) {
              sharedPreferences.setInt(
                  "weekday_from", jsonResponse['weekday_from']);
            } else {
              sharedPreferences.setInt("weekday_from", 1);
            }
            if (jsonResponse['weekday_to'].toString().isNotEmpty) {
              sharedPreferences.setInt(
                  "weekday_to", jsonResponse['weekday_to']);
            } else {
              sharedPreferences.setInt("weekday_to", 5);
            }
            if (jsonResponse['location'].toString().isNotEmpty) {
              sharedPreferences.setString("location", jsonResponse['location']);
            } else {
              sharedPreferences.setString("location", '');
            }
            if (jsonResponse['from_hour'].toString().isNotEmpty) {
              sharedPreferences.setString(
                  "from_hour", jsonResponse['from_hour']);
            } else {
              sharedPreferences.setString("from_hour", '8:00:00');
            }
            if (jsonResponse['to_hour'].toString().isNotEmpty) {
              sharedPreferences.setString("to_hour", jsonResponse['to_hour']);
            } else {
              sharedPreferences.setString("to_hour", '17:00:00');
            }
            if (jsonResponse['social_media_link'].toString().isNotEmpty) {
              sharedPreferences.setString(
                  "social_media_link", jsonResponse['social_media_link']);
            } else {
              sharedPreferences.setString("social_media_link", '');
            }
            if (jsonResponse['description'].toString().isNotEmpty) {
              sharedPreferences.setString(
                  "description", jsonResponse['description']);
            }
            if (jsonResponse['phone_number'].toString().isNotEmpty) {
              sharedPreferences.setString(
                  "phone_number", jsonResponse['phone_number']);
            } else {
              sharedPreferences.setString("phone_number", '');
            }
            if (jsonResponse['long'].toString().isNotEmpty) {
              sharedPreferences.setDouble("long", jsonResponse['long']);
            } else {
              sharedPreferences.setDouble("long", 1);
            }
            if (jsonResponse['lat'].toString().isNotEmpty) {
              sharedPreferences.setDouble("lat", jsonResponse['lat']);
            } else {
              sharedPreferences.setDouble("lat", 1);
            }
            if (jsonResponse['profile_picture'].toString().isNotEmpty) {
              sharedPreferences.setString(
                  'profile_picture', jsonResponse['profile_picture']);
            } else {
              sharedPreferences.setString('profile_picture', '');
            }
            sharedPreferences.setString("password", passwordController.text);
            Navigator.push(context, SlideRightRoute(page: const MyHomePage()));

            SnackNotification.snackCaller(context, 'You have been Signed In');
          });
        }
      } else {}
    } catch (e) {
      SnackNotification.snackCaller(context, e.toString());
      throw e.toString();
    }
  }
}
