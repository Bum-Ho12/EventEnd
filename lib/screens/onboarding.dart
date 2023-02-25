import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

import '../Auth/login_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: ThemeApplication.lightTheme.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(15 / 360),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          'assets/images/band.jpg',
                          fit: BoxFit.fill,
                          height: 150,
                          width: 250,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 1,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(60 / 360),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/images/concert.jpg',
                            fit: BoxFit.fill,
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/catering.jpg',
                fit: BoxFit.fill,
                height: 150,
                width: 220,
              ),
              Column(
                children: [
                  Text(
                    'Welcome to Eventend',
                    style: headline1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Let\'s use new ways to celebrate and work',
                    style: headlineForTile,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => const LoginPage()),
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 700),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          animation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeIn,
                          );
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginPage()),
                  );
                },
                color: ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.8),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Get Started',
                        style: headline2Profile,
                      ),
                      Icon(Icons.arrow_forward_ios, color: ThemeApplication.lightTheme.backgroundColor)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
