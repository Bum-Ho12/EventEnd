import 'package:eventend/favorite_service_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/network_provider.dart';
import '../../providers/service_favorites_provider.dart';
import '../../utilities/personalization.dart';
import '../../widgets/list_card_shimmer.dart';

class ServiceFavorites extends StatefulWidget {
  const ServiceFavorites({super.key});

  @override
  State<ServiceFavorites> createState() => _ServiceFavoritesState();
}

class _ServiceFavoritesState extends State<ServiceFavorites> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    });
    super.initState();
  }

  Future<void> initializeProviders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FavoriteServiceProvider>(context, listen: false)
          .getAllServices();
    });
  }

  Future<void> initializeNothing() async {}

  bool? isConnected;
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, value, child) {
        isConnected = value.isDeviceConnected;
        return ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Text(
                        'Stored',
                        style: headline1,
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: value.isDeviceConnected
                      ? initializeProviders()
                      : initializeNothing(),
                  builder: (context, _) {
                    return Consumer<FavoriteServiceProvider>(
                      builder: (context, value, child) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: isConnected! ? value.services.length : 6,
                            itemBuilder: (context, index) {
                              return isConnected!
                                  ? value.isLoading
                                      ? const HomeTileShimmer()
                                      : FavoriteServiceTile(
                                          data: value.services[index],
                                        )
                                  : const HomeTileShimmer();
                            });
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
