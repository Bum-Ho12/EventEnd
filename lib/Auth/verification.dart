import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../screens/home_page.dart';
import '../widgets/snack_bar.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final TextEditingController codeController = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: ThemeApplication.lightTheme.backgroundColor,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: ThemeApplication.lightTheme.backgroundColor2,
                  )),
              title: Text('Verify', style: pageTitle),
              centerTitle: true,
            ),
          ],
          body: Center(
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Center(
                      child: Text(
                        'Enter code here:',
                        style: headlineTile,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 25),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: ThemeApplication
                                    .lightTheme.backgroundColor)),
                        child: TextField(
                          controller: codeController,
                          obscureText: showPassword == false ? true : false,
                          maxLines: 1,
                          cursorColor:
                              ThemeApplication.lightTheme.backgroundColor2,
                          cursorHeight: 15,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                            label: Center(
                              child: Text(
                                'Code here',
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ThemeApplication.lightTheme.backgroundColor2
                              .withOpacity(0.5),
                        ),
                      ),
                      onPressed: () {
                        verify(codeController.text.trim(), context);
                      },
                      child: Text(
                        'Verify',
                        style: headline2Profile,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          child: Text(
                            'View Code?',
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
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Email not yet arrived?",
                      style: headlineForTile,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Center(
                              child: Text(
                                'check your spam emails.',
                                style: TextStyle(
                                    color: ThemeApplication
                                        .lightTheme.backgroundColor2,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Verify Again',
                        style: TextStyle(
                            color: ThemeApplication.lightTheme.navBar,
                            fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  verify(String code, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? email = preferences.getString('email');
    Map data = {
      'verification_code': code,
      'email': email,
    };
    // ignore: prefer_typing_uninitialized_variables
    var jsonResponse;
    var response = await http.post(
        Uri.parse("https://eventend.pythonanywhere.com/verify/"),
        body: data);
    jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['response'] == 'successfully Activated your Account') {
        setState(() {
          Navigator.push(context, SlideRightRoute(page: const MyHomePage()));
          SnackNotification.snackCaller(context, jsonResponse['response']);
        });
      } else {
        SnackNotification.snackCaller(context, jsonResponse['response']);
      }
    } else {}
  }
}
