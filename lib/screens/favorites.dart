import 'package:flutter/material.dart';

import '../list_tile_card.dart';
import '../utilities/personalization.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            leading: Container(),
            leadingWidth: 0,
            backgroundColor: backgroundColor,
            scrolledUnderElevation: 0,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('My Favorite', style: pageTitle),
            ),
            floating: true,
          ),
        ],
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Text(
                        'Stored',
                        style: headline1,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const HomeTile();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
