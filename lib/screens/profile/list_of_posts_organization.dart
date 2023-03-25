import 'package:eventend/widgets/past_expansion_tile_widget.dart';
import 'package:eventend/widgets/service_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/user_class.dart';
import '../../providers/get_concert_posts_provider.dart';
import '../../providers/get_service_posts_provider.dart';
import '../../utilities/personalization.dart';
import '../../widgets/expansion_tile_widget.dart';
import '../../widgets/update_expansion_shimmer.dart';

class PostsListOrganization extends StatefulWidget {
  final Account account;
  const PostsListOrganization({required this.account, super.key});

  @override
  State<PostsListOrganization> createState() => _PostsListOrganizationState();
}

class _PostsListOrganizationState extends State<PostsListOrganization> {
  Future<void> initializeProviders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetPostsProvider>(context, listen: false).getAllConcerts();
      Provider.of<GetPastPostsProvider>(context, listen: false)
          .getAllConcerts();
      Provider.of<GetServicePostsProvider>(context, listen: false)
          .getAllServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.account.name} Posts', style: pageTitle),
          backgroundColor:
              ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.1),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ThemeApplication.lightTheme.backgroundColor2,
            ),
          ),
          bottom: TabBar(
            indicatorColor: ThemeApplication.lightTheme.backgroundColor2,
            indicatorWeight: 1.5,
            indicator: BoxDecoration(
              color: ThemeApplication.lightTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
            labelStyle: headline2Profile,
            labelColor: ThemeApplication.lightTheme.backgroundColor2,
            tabs: const [
              Tab(text: 'Events'),
              Tab(text: 'Services'),
              Tab(text: 'Past')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: initializeProviders(),
              builder: (context, _) {
                return ListView(
                  children: [
                    Consumer<GetPostsProvider>(
                        builder: (context, value, child) {
                      return value.concerts.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Current Concerts',
                                    style: headline1detail,
                                  ),
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: value.isLoading == false
                                        ? value.concerts.length
                                        : 2,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return value.isLoading == true
                                          ? const UpdateShimmer()
                                          : ExpansionWidget(
                                              data: value.concerts[index],
                                              index: index);
                                    }),
                              ],
                            )
                          : const SizedBox();
                    }),
                  ],
                );
              },
            ),
            FutureBuilder(
              future: initializeProviders(),
              builder: (context, _) {
                return ListView(
                  children: [
                    Consumer<GetServicePostsProvider>(
                      builder: (context, value, child) {
                        return value.services.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Current Services',
                                      style: headline1detail,
                                    ),
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: value.isLoading == false
                                        ? value.services.length
                                        : 2,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return value.isLoading
                                          ? const UpdateShimmer()
                                          : ServiceExpansionWidget(
                                              data: value.services[index],
                                              index: index);
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox();
                      },
                    ),
                  ],
                );
              },
            ),
            FutureBuilder(
              future: initializeProviders(),
              builder: (context, _) {
                return ListView(
                  children: [
                    Consumer<GetPastPostsProvider>(
                        builder: (context, value, child) {
                      return value.concerts.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Past Concerts',
                                    style: headline1detail,
                                  ),
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: value.isLoading == false
                                        ? value.concerts.length
                                        : 2,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return value.isLoading == true
                                          ? const UpdateShimmer()
                                          : PastExpansionWidget(
                                              data: value.concerts[index],
                                              index: index);
                                    }),
                              ],
                            )
                          : const SizedBox();
                    }),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
