import 'package:eventend/classes/favorites.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class FavoriteConcertTile extends StatefulWidget {
  final FavoriteConcert data;
  const FavoriteConcertTile({required this.data, super.key});

  @override
  State<FavoriteConcertTile> createState() => _FavoriteConcertTileState();
}

class _FavoriteConcertTileState extends State<FavoriteConcertTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, SlideRightRoute(page: CardPage(data: widget.data)));
      },
      child: Container(
        color: ThemeApplication.lightTheme.backgroundColor,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Image.network(
                        'https://eventend.pythonanywhere.com${widget.data.concertPicture}',
                        fit: BoxFit.fill,
                        height: 120,
                        width: 200,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: Text('Loading...'));
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Text('Error Loading the image!'),
                      ),
                      // Positioned(
                      //   right: 1,
                      //   top: 2,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: ThemeApplication.lightTheme.backgroundColor,
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(2)),
                      //       border: Border.all(
                      //           width: 0.5,
                      //           color: ThemeApplication.lightTheme.backgroundColor2
                      //               .withOpacity(0.3)),
                      //     ),
                      //     padding: const EdgeInsets.all(2),
                      //     child: widget.data.price.isEmpty
                      //         ? const Text('Free')
                      //         : const Text('Priced'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Sat, March 4',
                      //       style: commonText,
                      //     ),
                      //     const VerticalDivider(
                      //       width: 2,
                      //       thickness: 0.5,
                      //     ),
                      //     Text(
                      //       widget.data.fromHour,
                      //       style: commonText,
                      //     ),
                      //   ],
                      // ),
                      Text(
                        widget.data.title,
                        style: headlineTile,
                      ),
                      Text(
                        widget.data.organizerMediaLink,
                        style: commonText,
                      ),
                      MaterialButton(
                        color: ThemeApplication.lightTheme.backgroundColor2
                            .withOpacity(0.5),
                        onPressed: () {},
                        child: Text(
                          'Delete',
                          style: headline2Profile,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.share,
                        color: ThemeApplication.lightTheme.backgroundColor2,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}