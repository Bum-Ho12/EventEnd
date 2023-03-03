import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

import 'verification.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum Category { individual, organization }

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Category? _category;
  int categoryOption = 1;

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
                  ? MediaQuery.of(context).size.height * 0.15
                  : MediaQuery.of(context).size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up with Us',
                style: headline1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'You are required as a customer to sign up to '
                  ' our space for proper tracking of activities.',
                  style: headlineForTile,
                ),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: headlineTile,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset(
                              'assets/icons/user.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset(
                              'assets/icons/password.svg',
                              height: 24,
                              width: 24,
                              // color: backgroundColor2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Category>(
                              contentPadding: EdgeInsets.zero,
                              value: Category.individual,
                              dense: true,
                              tileColor: ThemeApplication
                                  .lightTheme.backgroundColor2
                                  .withOpacity(0.5),
                              groupValue: _category,
                              activeColor:
                                  ThemeApplication.lightTheme.backgroundColor2,
                              onChanged: (value) {
                                setState(() {
                                  _category = value;
                                  categoryOption = 1;
                                });
                              },
                              title: Text(
                                'Individual',
                                style: headlineForTile,
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Category>(
                              contentPadding: EdgeInsets.zero,
                              value: Category.organization,
                              groupValue: _category,
                              activeColor:
                                  ThemeApplication.lightTheme.backgroundColor2,
                              dense: true,
                              onChanged: (value) {
                                setState(() {
                                  _category = value;
                                  categoryOption = 2;
                                });
                              },
                              tileColor: ThemeApplication
                                  .lightTheme.backgroundColor2
                                  .withOpacity(0.5),
                              title: Text(
                                'Organization',
                                style: headlineForTile,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        register(nameController.text, emailController.text,
                            passwordController.text, context);
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
                        "Sign Up",
                        style: headline2Profile,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  register(String name, email, pass, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("https://eventend.pythonanywhere.com/");
    final req = http.MultipartRequest('POST', url);
    req.fields['email'] = emailController.text;
    req.fields['password'] = passwordController.text;
    req.fields['username'] = nameController.text;
    req.fields['category'] = categoryOption.toString();

    // ignore: prefer_typing_uninitialized_variables
    var jsonResponse;
    final res = await req.send();
    var response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse != null) {
        if (jsonResponse['token'] != null) {
          sharedPreferences.setString("token", jsonResponse['token']);
        }
        sharedPreferences.setString("email", jsonResponse['email']);
        sharedPreferences.setString("username", jsonResponse['username']);
        sharedPreferences.setInt("category", jsonResponse['category']);
        sharedPreferences.setInt("weekday_from", jsonResponse['weekday_from']);
        sharedPreferences.setInt("weekday_to", jsonResponse['weekday_to']);
        sharedPreferences.setString("location", jsonResponse['location']);
        sharedPreferences.setString("from_hour", jsonResponse['from_hour']);
        sharedPreferences.setString("to_hour", jsonResponse['to_hour']);
        sharedPreferences.setString(
            "social_media_link", jsonResponse['social_media_link']);
        sharedPreferences.setString("description", jsonResponse['description']);
        sharedPreferences.setString(
            "phone_number", jsonResponse['phone_number']);
        sharedPreferences.setDouble("long", jsonResponse['long']);
        sharedPreferences.setDouble("lat", jsonResponse['lat']);

        sharedPreferences.setString(
            'profile_picture', jsonResponse['profile_picture']);
        sharedPreferences.setString("password", passwordController.text);

        Navigator.push(context, SlideRightRoute(page: const Verification()));
      }
    } else {}
  }
}
