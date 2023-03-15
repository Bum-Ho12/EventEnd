import 'package:eventend/cards/list_tile_card.dart';
import 'package:eventend/providers/concert_provider.dart';
import 'package:eventend/providers/service_provider.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:eventend/widgets/list_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cards/card.dart';
import '../providers/network_provider.dart';
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
      Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    });
    super.initState();
  }

  Future<void> initializeProviders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ConcertProvider>(context, listen: false).getAllConcerts();
      Provider.of<ServiceProvider>(context, listen: false).getAllServices();
    });
  }

  Future<void> initializeNothing() async {}

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
    });
    return SafeArea(
      child: Scaffold(
        body: Consumer<NetworkProvider>(builder: (context, value, child) {
          bool? isConnected = value.isConnected;
          return FutureBuilder(
              future: value.isConnected == true
                  ? initializeProviders()
                  : initializeNothing(),
              builder: (context, _) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: ThemeApplication.lightTheme.backgroundColor2
                            .withOpacity(0.1),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Text(
                            'Eventend',
                            style: pageTitle,
                          ),
                        ),
                      ),
                      Consumer<ServiceProvider>(
                          builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 250,
                              child: ListView.builder(
                                  itemCount: isConnected == true
                                      ? value.services.length
                                      : 3,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return isConnected == true
                                        ? value.isLoading
                                            ? const SuggestedCardShimmer()
                                            : SuggestedCard(
                                                data: value.services[index])
                                        : const SuggestedCardShimmer();
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
                                  itemCount: isConnected == true
                                      ? value.concerts.length
                                      : 3,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return isConnected == true
                                        ? value.isLoading
                                            ? const HomeTileShimmer()
                                            : HomeTile(
                                                data: value.concerts[index])
                                        : const HomeTileShimmer();
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
