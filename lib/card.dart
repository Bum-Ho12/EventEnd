import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class SuggestedCard extends StatefulWidget {
  const SuggestedCard({super.key});

  @override
  State<SuggestedCard> createState() => _SuggestedCardState();
}

class _SuggestedCardState extends State<SuggestedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: Image.asset(
                'assets/images/lp_image.png',
                height: 100,
                width: 100,
                fit: BoxFit.fill,
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
              color: backgroundColor2,
              onPressed: () {},
              child: Icon(
                Icons.favorite_outline,
                color: backgroundColor,
              ),
            )
          ],
        ));
  }
}
