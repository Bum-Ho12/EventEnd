import 'package:eventend/widgets/service_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../classes/user_class.dart';
import '../../providers/get_concert_posts_provider.dart';
import '../../providers/get_service_posts_provider.dart';
import '../../utilities/personalization.dart';
import '../../widgets/card_shimmer.dart';
import '../../widgets/expansion_tile_widget.dart';

class PostsList extends StatefulWidget {
  final Account account;
  const PostsList({required this.account, super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  Future<void> initializeProviders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetPostsProvider>(context, listen: false).getAllConcerts();
      Provider.of<GetServicePostsProvider>(context, listen: false)
          .getAllServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.account.name} Posts', style: pageTitle),
        backgroundColor: ThemeApplication.lightTheme.backgroundColor,
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
      ),
      body: FutureBuilder(
          future: initializeProviders(),
          builder: (context, _) {
            return ListView(
              children: [
                Consumer<GetPostsProvider>(builder: (context, value, child) {
                  // print(value.concerts.length);
                  return value.concerts.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Concerts',
                                style: headline1detail,
                              ),
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.isLoading == false
                                    ? value.concerts.length
                                    : 2,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return value.isLoading == true
                                      ? const SuggestedCardShimmer()
                                      : ExpansionWidget(
                                          data: value.concerts[index]);
                                }),
                          ],
                        )
                      : const SizedBox();
                }),
                Consumer<GetServicePostsProvider>(
                  builder: (context, value, child) {
                    return value.services.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Services',
                                  style: headline1detail,
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.isLoading == false
                                    ? value.services.length
                                    : 2,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return value.isLoading
                                      ? const SuggestedCardShimmer()
                                      : ServiceExpansionWidget(
                                          data: value.services[index]);
                                },
                              ),
                            ],
                          )
                        : const SizedBox();
                  },
                ),
              ],
            );
          }),
    );
  }
}
