import 'package:eventend/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cards/favorite_concert_card.dart';
import '../../providers/network_provider.dart';
import '../../utilities/personalization.dart';
import '../../widgets/list_card_shimmer.dart';
// import '../utilities/personalization.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<void> initializeProviders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FavoriteConcertProvider>(context, listen: false)
          .getAllConcerts();
    });
  }

  Future<void> initializeNothing() async {}

  bool? isConnected;
  bool? _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(builder: (context, value, child) {
      isConnected = value.isConnected;
      return FutureBuilder(
          future: value.isConnected == true
              ? initializeProviders()
              : initializeNothing(),
          builder: (context, _) {
            return Consumer<FavoriteConcertProvider>(
                builder: (context, value, child) {
              return value.concerts.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder(
                            future:
                                Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                _isLoading = false;
                              });
                            }),
                            builder: (context, _) {
                              return _isLoading == true
                                  ? CircularProgressIndicator(
                                      color: ThemeApplication
                                          .lightTheme.backgroundColor2,
                                    )
                                  : Text('No Saved Concerts present',
                                      style: headline2Detail);
                            }),
                      ],
                    )
                  : ListView(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: isConnected! ? value.concerts.length : 6,
                            itemBuilder: (context, index) {
                              return isConnected!
                                  ? value.isLoading
                                      ? const HomeTileShimmer()
                                      : FavoriteConcertTile(
                                          data: value.concerts[index],
                                          index: index,
                                        )
                                  : const HomeTileShimmer();
                            }),
                      ],
                    );
            });
          });
    });
  }
}
