import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

import 'screens/detail.dart';

class HomeTile extends StatefulWidget {
  const HomeTile({super.key});

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, SlideRightRoute(page: const CardPage()));
      },
      child: Container(
        color: backgroundColor,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Image.asset('assets/images/lp_image.png',
                      fit: BoxFit.fill, width: 200),
                  Positioned(
                      right: 1,
                      top: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                          border: Border.all(
                              width: 0.5,
                              color: backgroundColor2.withOpacity(0.3)),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: const Text('Free'),
                      ))
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Sat, March 4',
                        style: commonText,
                      ),
                      const VerticalDivider(
                        width: 2,
                        thickness: 0.5,
                      ),
                      Text(
                        '14.00 GMT + 3:00',
                        style: commonText,
                      ),
                    ],
                  ),
                  Text(
                    'Title of the list tile',
                    style: headlineTile,
                  ),
                  Text(
                    'Extra information of the tile',
                    style: commonTextMain,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.share,
                          color: backgroundColor2,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.favorite_outline,
                          color: backgroundColor2,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
