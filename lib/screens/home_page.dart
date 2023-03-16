import 'package:eventend/providers/network_provider.dart';
import 'package:eventend/screens/network_error_screen.dart';
import 'package:eventend/screens/profile.dart';
import 'package:eventend/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  Future<void> getConnection() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    });
  }

  RiveAsset selectedNav = bottomBarNavs.first;
  int _currentIndex = 0;
  bool? _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getConnection(),
        builder: (context, _) {
          return Scaffold(
            backgroundColor: ThemeApplication.lightTheme.backgroundColor,
            body: Consumer<NetworkProvider>(builder: (context, value, child) {
              List tabs = [
                Center(
                  child: value.isConnected == true
                      ? const Home()
                      : FutureBuilder(
                          future:
                              Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              _isLoading = false;
                            });
                          }),
                          builder: (context, _) {
                            return _isLoading == true
                                ? CircularProgressIndicator(
                                    color: ThemeApplication
                                        .lightTheme.backgroundColor2,
                                  )
                                : value.isConnected == true
                                    ? const SizedBox()
                                    : const NetworkErrorScreen();
                          }),
                ),
                Center(
                  child: value.isConnected == true
                      ? const SearchScreen()
                      : FutureBuilder(
                          future:
                              Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              _isLoading = false;
                            });
                          }),
                          builder: (context, _) {
                            return _isLoading == true
                                ? CircularProgressIndicator(
                                    color: ThemeApplication
                                        .lightTheme.backgroundColor2,
                                  )
                                : const NetworkErrorScreen();
                          }),
                ),
                Center(
                  child: value.isConnected == true
                      ? const Favorite()
                      : FutureBuilder(
                          future:
                              Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              _isLoading = false;
                            });
                          }),
                          builder: (context, _) {
                            return _isLoading == true
                                ? CircularProgressIndicator(
                                    color: ThemeApplication
                                        .lightTheme.backgroundColor2,
                                  )
                                : const NetworkErrorScreen();
                          }),
                ),
                const Center(
                  child: Profile(),
                ),
              ];
              return tabs[_currentIndex];
            }),
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 65,
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ThemeApplication.lightTheme.backgroundColor2,
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
                                            stateMachineName:
                                                bottomBarNavs[index]
                                                    .stateMachineName);
                                    bottomBarNavs[index].input = controller
                                        .findSMI("active") as rive.SMIBool;
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
        });
  }
}
