import 'package:eventend/providers/search_provider.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:eventend/widgets/loader_for_search.dart';
import 'package:eventend/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/list_card_shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;
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
                child: Row(
                  children: const [
                    Spacer(),
                    SearchBar(),
                  ],
                )),
          ),
        ],
        body: ListView(
          children: [
            Container(
              color: ThemeApplication.lightTheme.backgroundColor,
              child: context.watch<SearchProvider>().searched.isNotEmpty
                  ? const Center(child: WorldLoader())
                  : Column(
                      children: [
                        Row(
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
                        FutureBuilder(
                            future:
                                Future.delayed(const Duration(seconds: 2), () {
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
            ),
          ],
        ),
      ),
    );
  }
}
