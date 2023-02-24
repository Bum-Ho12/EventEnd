import 'package:eventend/screens/home_page.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              style: headline1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'You are required as a customer to sign in'
                ' our space for proper tracking of activities.',
                style: headlineForTile,
              ),
            ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: headlineTile,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: TextFormField(
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
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context, SlideRightRoute(page: const MyHomePage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor2.withOpacity(0.8),
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
                        "Sign In",
                        style: headline2Profile,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OR',
                    style: headlineForTile,
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                'Sign Up with Email or Google',
                style: headlineForTile,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/email.svg',
                    height: 64,
                    width: 64,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    'assets/icons/google.svg',
                    height: 64,
                    width: 64,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
