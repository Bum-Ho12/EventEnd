import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/snack_bar.dart';
import 'verification.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum Category { individual, organization }

enum Customer { yes, no }

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Category? _category;
  Customer? customer;
  int categoryOption = 1;
  bool isCustomer = true;
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
                  ? MediaQuery.of(context).size.height * 0.12
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
                              // color: backgroundColor2,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        'Are you joining as a:',
                        style: headlineForTile,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Customer>(
                              contentPadding: EdgeInsets.zero,
                              value: Customer.yes,
                              dense: true,
                              tileColor: ThemeApplication
                                  .lightTheme.backgroundColor2
                                  .withOpacity(0.5),
                              groupValue: customer,
                              activeColor:
                                  ThemeApplication.lightTheme.backgroundColor2,
                              onChanged: (value) {
                                setState(() {
                                  customer = value;
                                  isCustomer = true;
                                });
                              },
                              title: Text(
                                'Customer',
                                style: headlineForTile,
                              ),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Customer>(
                              contentPadding: EdgeInsets.zero,
                              value: Customer.no,
                              groupValue: customer,
                              activeColor:
                                  ThemeApplication.lightTheme.backgroundColor2,
                              dense: true,
                              onChanged: (value) {
                                setState(() {
                                  customer = value;
                                  isCustomer = false;
                                });
                              },
                              tileColor: ThemeApplication
                                  .lightTheme.backgroundColor2
                                  .withOpacity(0.5),
                              title: Text(
                                'Marketer',
                                style: headlineForTile,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isCustomer
                        ? const SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Text(
                                  'Are you joining as a:',
                                  style: headlineForTile,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
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
                                        activeColor: ThemeApplication
                                            .lightTheme.backgroundColor2,
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
                                        activeColor: ThemeApplication
                                            .lightTheme.backgroundColor2,
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
                            ],
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
    req.fields['email'] = emailController.text.trim();
    req.fields['password'] = passwordController.text.trim();
    req.fields['username'] = nameController.text.trim();
    req.fields['category'] = categoryOption.toString();
    req.fields['isCustomer'] = isCustomer.toString();

    // ignore: prefer_typing_uninitialized_variables
    var jsonResponse;
    final res = await req.send();
    var response = await http.Response.fromStream(res);
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse != null) {
        setState(() {
          if (jsonResponse['token'] != null) {
            sharedPreferences.setString("token", jsonResponse['token']);
          }
          sharedPreferences.setString("email", jsonResponse['email']);
          sharedPreferences.setString("username", jsonResponse['username']);
          sharedPreferences.setInt("category", jsonResponse['category']);
          sharedPreferences.setBool("isCustomer", jsonResponse['isCustomer']);
          if (jsonResponse['weekday_from'] != null) {
            sharedPreferences.setInt(
                "weekday_from", jsonResponse['weekday_from']);
          } else {
            sharedPreferences.setInt("weekday_from", 1);
          }
          if (jsonResponse['weekday_to'] != null) {
            sharedPreferences.setInt("weekday_to", jsonResponse['weekday_to']);
          } else {
            sharedPreferences.setInt("weekday_to", 5);
          }
          if (jsonResponse['location'] != null) {
            sharedPreferences.setString("location", jsonResponse['location']);
          } else {
            sharedPreferences.setString("location", '');
          }
          if (jsonResponse['from_hour'] != null) {
            sharedPreferences.setString("from_hour", jsonResponse['from_hour']);
          } else {
            sharedPreferences.setString("from_hour", '8:00:00');
          }
          if (jsonResponse['to_hour'] != null) {
            sharedPreferences.setString("to_hour", jsonResponse['to_hour']);
          } else {
            sharedPreferences.setString("to_hour", '17:00:00');
          }
          if (jsonResponse['social_media_link'] != null) {
            sharedPreferences.setString(
                "social_media_link", jsonResponse['social_media_link']);
          } else {
            sharedPreferences.setString("social_media_link", '');
          }
          if (jsonResponse['description'] != null) {
            sharedPreferences.setString(
                "description", jsonResponse['description']);
          }
          if (jsonResponse['phone_number'] != null) {
            sharedPreferences.setString(
                "phone_number", jsonResponse['phone_number']);
          } else {
            sharedPreferences.setString("phone_number", '');
          }
          if (jsonResponse['long'] != null) {
            sharedPreferences.setDouble("long", jsonResponse['long']);
          } else {
            sharedPreferences.setDouble("long", 1);
          }
          if (jsonResponse['lat'] != null) {
            sharedPreferences.setDouble("lat", jsonResponse['lat']);
          } else {
            sharedPreferences.setDouble("lat", 1);
          }
          if (jsonResponse['profile_picture'] != null) {
            sharedPreferences.setString(
                'profile_picture', jsonResponse['profile_picture']);
          } else {
            sharedPreferences.setString('profile_picture', '');
          }
          sharedPreferences.setString("password", passwordController.text);

          Navigator.push(context, SlideRightRoute(page: const Verification()));

          SnackNotification.snackCaller(context, 'Wait For verification');
        });
      }
    } else {
      SnackNotification.snackCaller(context, 'Issues with your Registration!');
    }
  }
}
