import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../classes/concert_class.dart';
import '../network_services/add_to_favorites.dart';
import '../network_services/feedback.dart';
import '../screens/homescreen/detail.dart';

class HomeTile extends StatefulWidget {
  final Concert data;
  const HomeTile({required this.data, super.key});

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  AddFavorite addToFavorite = AddFavorite();
  FeedBack feedBack = FeedBack();
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    double price = double.parse(widget.data.price);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, SlideRightRoute(page: CardPage(data: widget.data)));
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
                    'https://eventend.pythonanywhere.com${widget.data.concertPicture}',
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
                  Text(
                    widget.data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: headlineTile,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.data.eventDate,
                        style: commonText,
                      ),
                      const VerticalDivider(
                        width: 2,
                        thickness: 0.5,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.data.fromHour,
                        style: commonText,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.data.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: commonTextMain,
                        ),
                      ],
                    ),
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
