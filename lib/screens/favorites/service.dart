import 'package:eventend/cards/favorite_service_card.dart';
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
  bool? _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (context, value, child) {
        isConnected = value.isConnected;
        return Center(
          child: FutureBuilder(
            future: value.isConnected == true
                ? initializeProviders()
                : initializeNothing(),
            builder: (context, _) {
              return Consumer<FavoriteServiceProvider>(
                builder: (context, value, child) {
                  return value.services.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                future: Future.delayed(
                                    const Duration(seconds: 2), () {
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
                                      : Text('No Saved services present',
                                          style: headline2Detail);
                                }),
                          ],
                        )
                      : ListView(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    isConnected! ? value.services.length : 6,
                                itemBuilder: (context, index) {
                                  return isConnected!
                                      ? value.isLoading
                                          ? const HomeTileShimmer()
                                          : FavoriteServiceTile(
                                              data: value.services[index],
                                              index: index,
                                            )
                                      : const HomeTileShimmer();
                                }),
                          ],
                        );
                },
              );
            },
          ),
        );
      },
    );
  }
}
