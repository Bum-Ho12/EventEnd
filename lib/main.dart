import 'package:eventend/providers/concert_provider.dart';
import 'package:eventend/providers/search_provider.dart';
import 'package:eventend/providers/service_provider.dart';
import 'package:eventend/screens/home_page.dart';
import 'package:eventend/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ConcertProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // function that checks if user is logged in or not
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  late bool isLoggedIn = false;

  Future<void> getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.containsKey('email')) {
        setState(() {
          isLoggedIn = !isLoggedIn;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EventEnd',
      theme: ThemeData(
        fontFamily: "Montserrat",
      ),
      home: isLoggedIn ? const MyHomePage() : const Onboarding(),
    );
  }
}
