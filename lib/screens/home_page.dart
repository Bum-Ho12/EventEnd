import 'package:eventend/screens/profile.dart';
import 'package:eventend/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import '../utilities/personalization.dart';
import '../utilities/rive_nav_bat.dart';
import 'favorites.dart';
import 'homescreen.dart';

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
            color: backgroundColor2,
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
                    if (bottomBarNavs[index] != selectedNav) {
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
                          opacity: bottomBarNavs[index].artboard ==
                                  selectedNav.artboard
                              ? 1
                              : 0.5,
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
