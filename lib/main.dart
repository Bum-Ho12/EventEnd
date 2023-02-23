import 'package:eventend/screens/favorites.dart';
import 'package:eventend/screens/homescreen.dart';
import 'package:eventend/screens/profile.dart';
import 'package:eventend/screens/search.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:eventend/utilities/rive_nav_bat.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventEnd',
      theme: ThemeData(
        // primarySwatch: Colors.green,
        fontFamily: "Montserrat",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RiveAsset selectedNav = bottomBarNavs.first;
  int _currentIndex = 0;
  final tabs = const [
    Center(
      child: Home(),
    ),
    Center(
      child: SearchScreen(),
    ),
    Center(
      child: Favorite(),
    ),
    Center(
      child: Profile(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: tabs[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 65,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomBarNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                    bottomBarNavs[index].input!.change(true);
                    if (bottomBarNavs[index] == selectedNav) {
                      setState(() {
                        selectedNav = bottomBarNavs[index];
                      });
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      bottomBarNavs[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedWidgetBar(
                          isActive: bottomBarNavs[index] == selectedNav),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Opacity(
                          opacity:
                              bottomBarNavs[index] == selectedNav ? 1 : 0.5,
                          child: rive.RiveAnimation.asset(
                            bottomBarNavs.first.src,
                            artboard: bottomBarNavs[index].artboard,
                            onInit: (artBoard) {
                              rive.StateMachineController controller =
                                  RiveUtils.getRController(artBoard,
                                      stateMachineName: bottomBarNavs[index]
                                          .stateMachineName);
                              bottomBarNavs[index].input =
                                  controller.findSMI("active") as rive.SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
