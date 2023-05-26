import 'package:eventend/providers/search_service_provider.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:eventend/widgets/loader_for_search.dart';
import 'package:eventend/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cards/card.dart';
import '../cards/concert_search_tile.dart';
import '../providers/network_provider.dart';
import '../providers/search_provider.dart';
import '../widgets/card_shimmer.dart';
import '../widgets/list_card_shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    });
    super.initState();
  }

  Future<void> initializeProviders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ServiceSearchProvider>(context, listen: false)
          .getSearchedServices();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ConcertSearchProvider>(context, listen: false)
          .getSearchedConcerts();
    });
  }

  Future<void> initializeNothing() async {}

  Widget noSearch() {
    return SizedBox(
      height: 80,
      child: Column(
        children: [
          Icon(
            Icons.search_outlined,
            size: 40,
            color:
                ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.7),
          ),
          Text('No searches yet\n click on search Icon',
              style: headline2Detail),
        ],
      ),
    );
  }

  bool? isConnected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            leading: Container(),
            leadingWidth: 0,
            backgroundColor:
                ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.1),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Search', style: pageTitle),
            ),
            floating: true,
            bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 60),
                child: const Row(
                  children: [
                    Spacer(),
                    OnSearchBar(),
                  ],
                )),
          ),
        ],
        body: Consumer<NetworkProvider>(builder: (context, value, child) {
          isConnected = value.isConnected;
          return FutureBuilder(
              future: value.isConnected == true
                  ? initializeProviders()
                  : initializeNothing(),
              builder: (context, _) {
                return ListView(
                  children: [
                    Container(
                      color: ThemeApplication.lightTheme.backgroundColor,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Text(
                                  'Results',
                                  style: headline1,
                                ),
                              ),
                            ],
                          ),
                          Consumer<ServiceSearchProvider>(
                              builder: (context, value, child) {
                            return value.isLoading
                                ? const Center(child: WorldLoader())
                                : Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Text(
                                              'Profiles',
                                              style: headline2Detail,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Consumer<ServiceSearchProvider>(
                                        builder: (context, value, child) {
                                          return value.searched.isEmpty
                                              ? noSearch()
                                              : Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  height: 250,
                                                  child: value.isLoading
                                                      ? const SuggestedCardShimmer()
                                                      : ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemCount: value
                                                              .services.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SuggestedCard(
                                                              data: value
                                                                      .services[
                                                                  index],
                                                            );
                                                          },
                                                        ),
                                                );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Text(
                                              'Events',
                                              style: headline2Detail,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Consumer<ConcertSearchProvider>(
                                        builder: (context, value, child) {
                                          return value.searched.isEmpty
                                              ? noSearch()
                                              : value.isLoading
                                                  ? const HomeTileShimmer()
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          value.concerts.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ConcertSearchTile(
                                                          data: value
                                                              .concerts[index],
                                                        );
                                                      },
                                                    );
                                        },
                                      ),
                                    ],
                                  );
                          }),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }),
      ),
    );
  }
}
