import 'package:eventend/classes/concert_search_class.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../network_services/add_to_favorites.dart';
import '../network_services/feedback.dart';
import '../screens/search/concert_detail.dart';
import '../widgets/snack_bar.dart';

class ConcertSearchTile extends StatefulWidget {
  final ConcertSearch data;
  const ConcertSearchTile({required this.data, super.key});

  @override
  State<ConcertSearchTile> createState() => _ConcertSearchTileState();
}

class _ConcertSearchTileState extends State<ConcertSearchTile> {
  AddFavorite addToFavorite = AddFavorite();
  FeedBack feedBack = FeedBack();
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    double price = double.parse(widget.data.price);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, SlideRightRoute(page: ConcertCardPage(data: widget.data)));
        setState(() {
          feedBack.sendFeedBack('concert', widget.data.id);
        });
      },
      child: Container(
        color: ThemeApplication.lightTheme.backgroundColor,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Image.network(
                    widget.data.concertPicture,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 120,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                          child: SizedBox(
                              height: 100,
                              width: 120,
                              child: Text('Loading...')));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                            height: 100,
                            width: 120,
                            child: Text('Error Loading the image!')),
                  ),
                  Positioned(
                    right: 1,
                    top: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeApplication.lightTheme.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        border: Border.all(
                            width: 0.5,
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.3)),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: price == 0
                          ? const Text('Free')
                          : const Text('Priced'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Sat, March 4',
                        style: commonText,
                      ),
                      const VerticalDivider(
                        width: 2,
                        thickness: 0.5,
                      ),
                      Text(
                        widget.data.fromHour,
                        style: commonText,
                      ),
                    ],
                  ),
                  Text(
                    widget.data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: headlineTile,
                  ),
                  Text(
                    widget.data.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: commonTextMain,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share(widget.data.webLink,
                              subject: widget.data.webLink);
                        },
                        child: Icon(
                          Icons.share,
                          color: ThemeApplication.lightTheme.backgroundColor2,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () async {
                          bool isSent =
                              await addToFavorite.addConcert(widget.data.id);
                          isSent
                              // ignore: use_build_context_synchronously
                              ? SnackNotification.snackCaller(
                                  context, "Added to Favorites")
                              // ignore: use_build_context_synchronously
                              : SnackNotification.snackCaller(
                                  context, "You are not Allowed as the owner");
                          setState(() {
                            isSaved = isSent;
                          });
                        },
                        child: Icon(
                          isSaved ? Icons.favorite : Icons.favorite_outline,
                          color: ThemeApplication.lightTheme.backgroundColor2,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
