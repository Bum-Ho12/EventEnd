import 'package:flutter/material.dart';

import '../list_tile_card.dart';
import '../widgets/list_card_shimmer.dart';
// import '../utilities/personalization.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                  }),
              builder: (context,_) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return isLoading
                                    ? const HomeTileShimmer()
                                    :const HomeTile();
                    });
              }
            )
          ],
        ),
      ],
    );
  }
}
