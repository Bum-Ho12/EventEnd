import 'package:eventend/list_tile_card.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:eventend/widgets/list_card_shimmer.dart';
import 'package:flutter/material.dart';

import '../card.dart';
import '../widgets/card_shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      isLoading = false;
    });
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ThemeApplication.lightTheme.backgroundColor2
                    .withOpacity(0.1),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    'Eventend',
                    style: pageTitle,
                  ),
                ),
              ),
              FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 2), () {
                    isLoading = false;
                  }),
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 250,
                          child: ListView.builder(
                              itemCount: 4,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return isLoading
                                    ? const SuggestedCardShimmer()
                                    : const SuggestedCard();
                              }),
                        ),
                      ],
                    );
                  }),
              Container(
                color: ThemeApplication.lightTheme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent',
                        style: headline1,
                      ),
                      FutureBuilder(
                          future:
                              Future.delayed(const Duration(seconds: 2), () {
                            isLoading = false;
                          }),
                          builder: (context, _) {
                            return ListView.builder(
                              itemCount: 8,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return isLoading
                                    ? const HomeTileShimmer()
                                    : const HomeTile();
                              },
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
