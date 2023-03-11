import 'package:eventend/providers/concert_create_provider.dart';
import 'package:eventend/providers/concert_provider.dart';
import 'package:eventend/providers/favorites_provider.dart';
import 'package:eventend/providers/network_provider.dart';
import 'package:eventend/providers/request_provider.dart';
import 'package:eventend/providers/search_provider.dart';
import 'package:eventend/providers/search_service_provider.dart';
import 'package:eventend/providers/service_provider.dart';
import 'package:eventend/screens/home_page.dart';
import 'package:eventend/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/service_create_provider.dart';
import 'providers/service_favorites_provider.dart';
import 'screens/profile.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConcertSearchProvider()),
        ChangeNotifierProvider(create: (_) => ConcertProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteConcertProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteServiceProvider()),
        ChangeNotifierProvider(create: (_) => ServiceSearchProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => ConcertCreateProvider()),
        ChangeNotifierProvider(create: (_) => ServiceCreateProvider()),
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
  var isDeviceConnected = false;
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
          isLoggedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EventEnd',
      initialRoute: '/',
      routes: {
        // '/': (context) => const MyHomePage(),
        '/profile': (context) => const Profile(),
        // '/sell': (context) => Sell()
      },
      theme: ThemeData(
        fontFamily: "Montserrat",
      ),
      home: isLoggedIn ? const MyHomePage() : const Onboarding(),
    );
  }
}
