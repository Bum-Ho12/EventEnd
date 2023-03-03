import 'package:eventend/list_tile_card.dart';
import 'package:eventend/providers/concert_provider.dart';
import 'package:eventend/providers/service_provider.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:eventend/widgets/list_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../card.dart';
import '../widgets/card_shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ConcertProvider>(context, listen: false).getAllConcerts();
      Provider.of<ServiceProvider>(context, listen: false).getAllServices();
    });
    super.initState();
  }

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
              Consumer<ServiceProvider>(builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 250,
                      child: ListView.builder(
                          itemCount: value.services.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return value.isLoading
                                ? const SuggestedCardShimmer()
                                : SuggestedCard(data: value.services[index]);
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
                      Consumer<ConcertProvider>(
                          builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.concerts.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return value.isLoading
                                ? const HomeTileShimmer()
                                : HomeTile(data: value.concerts[index]);
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
