import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatefulWidget {
  const HomeTile({super.key});

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Image.asset('assets/images/lp_image.png',
                    fit: BoxFit.fill, width: 200),
                Positioned(
                    right: 1,
                    top: 2,
                    child: Container(
                      color: backgroundColor,
                      padding: const EdgeInsets.all(2),
                      child: const Text('Free'),
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: const [
                    Text('Sat, March 4'),
                    VerticalDivider(
                      width: 2,
                      thickness: 0.5,
                    ),
                    Text('14.00 GMT + 3:00'),
                  ],
                ),
                Text(
                  'Title of the list tile',
                  style: headlineTile,
                ),
                Text(
                  'Extra information of the tile',
                  style: commonText,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            ],
          )
        ],
      ),
    );
  }
}
