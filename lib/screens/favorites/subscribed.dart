import 'package:eventend/widgets/list_card_shimmer.dart';
import 'package:flutter/material.dart';
// import '../utilities/personalization.dart';

class Subscribed extends StatefulWidget {
  const Subscribed({super.key});

  @override
  State<Subscribed> createState() => _SubscribedState();
}

class _SubscribedState extends State<Subscribed> {
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
                builder: (context, _) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return isLoading
                            ? const HomeTileShimmer()
                            : const HomeTileShimmer(); //const HomeTile();
                      });
                })
          ],
        ),
      ],
    );
  }
}
