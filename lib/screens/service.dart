import 'package:flutter/material.dart';

import '../list_tile_card.dart';
import '../utilities/personalization.dart';
import '../widgets/list_card_shimmer.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    'Stored',
                    style: headline1,
                  ),
                ),
              ],
            ),
            FutureBuilder(
                future: Future.delayed(const Duration(seconds: 2), () {
                  isLoading = false;
                }),
                builder: (context, _) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return isLoading
                            ? const HomeTileShimmer()
                            : const HomeTile();
                      });
                })
          ],
        ),
      ],
    );
  }
}
