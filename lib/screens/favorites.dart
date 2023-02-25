import 'package:eventend/screens/events.dart';
import 'package:eventend/screens/service.dart';
import 'package:eventend/screens/subscribed.dart';
import 'package:flutter/material.dart';
import '../utilities/personalization.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ThemeApplication.lightTheme.backgroundColor,
        body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    leading: Container(),
                    leadingWidth: 0,
                    backgroundColor: ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.1),
                    scrolledUnderElevation: 0,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('My Favorite', style: pageTitle),
                    ),
                    floating: true,
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
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelStyle: headline2Profile,
                        labelColor: ThemeApplication.lightTheme.backgroundColor2,
                        tabs: const [
                          Tab(text: 'Service'),
                          Tab(text: 'Subscription'),
                          Tab(text: 'Events')
                        ]),
                  ),
                ],
            body: const TabBarView(
              children: [
                Service(),
                Subscribed(),
                Events(),
              ],
            )),
      ),
    );
  }
}
