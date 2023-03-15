import 'package:eventend/providers/auth_check_provider.dart';
import 'package:eventend/providers/concert_create_provider.dart';
import 'package:eventend/providers/concert_provider.dart';
import 'package:eventend/providers/favorites_provider.dart';
import 'package:eventend/providers/get_concert_posts_provider.dart';
import 'package:eventend/providers/get_service_posts_provider.dart';
import 'package:eventend/providers/network_provider.dart';
import 'package:eventend/providers/request_provider.dart';
import 'package:eventend/providers/search_provider.dart';
import 'package:eventend/providers/search_service_provider.dart';
import 'package:eventend/providers/service_provider.dart';
import 'package:eventend/screens/home_page.dart';
import 'package:eventend/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(create: (_) => GetPostsProvider()),
        ChangeNotifierProvider(create: (_) => GetServicePostsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
  Future<void> getAuth() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AuthProvider>(context, listen: false).checkNetwork();
      Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EventEnd',
      initialRoute: '/',
      routes: {
        '/profile': (context) => const Profile(),
      },
      theme: ThemeData(
        fontFamily: "Montserrat",
      ),
      home: FutureBuilder(
          future: getAuth(),
          builder: (context, _) {
            return Consumer<AuthProvider>(builder: (context, value, child) {
              return value.isDeviceConnected == true
                  ? const MyHomePage()
                  : const Onboarding();
            });
          }),
    );
  }
}
