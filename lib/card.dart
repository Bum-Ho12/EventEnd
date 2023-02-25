import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

import 'screens/check_profile.dart';

class SuggestedCard extends StatefulWidget {
  const SuggestedCard({super.key});

  @override
  State<SuggestedCard> createState() => _SuggestedCardState();
}

class _SuggestedCardState extends State<SuggestedCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, SlideRightRoute(page: const ProfileViewPage()));
      },
      child: Container(
          height: 220,
          width: 180,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: ThemeApplication.lightTheme.backgroundColor,
              border: Border.all(
                  width: 0.5, color: ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 0.1,
                    spreadRadius: 0.15,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/band.jpg',
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Title Here',
                style: headlineTile,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '546 Followers',
                style: commonText,
              ),
              const SizedBox(
                height: 7,
              ),
              MaterialButton(
                color: ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.3),
                elevation: 0.0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                onPressed: () {},
                child: Text(
                  'Subscribe',
                  style: headline2Detail,
                ),
              )
            ],
          )),
    );
  }
}
