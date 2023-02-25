import 'package:flutter/material.dart';

import '../list_tile_card.dart';
// import '../utilities/personalization.dart';

class Subscribed extends StatefulWidget {
  const Subscribed({super.key});

  @override
  State<Subscribed> createState() => _SubscribedState();
}

class _SubscribedState extends State<Subscribed> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
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
    );
  }
}
