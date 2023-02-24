import 'package:eventend/list_tile_card.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

import '../card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: backgroundColor,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    'EventEnd',
                    style: pageTitle,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   color: backgroundColor,
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Suggested',
                  //         style: headline1,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 250,
                    child: ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return const SuggestedCard();
                        }),
                  ),
                ],
              ),
              Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent',
                        style: headline1,
                      ),
                      ListView.builder(
                        itemCount: 8,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const HomeTile();
                        },
                      ),
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
