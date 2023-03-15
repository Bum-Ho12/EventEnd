import 'package:eventend/classes/concert_class.dart';
import 'package:eventend/network_services/delete.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

import '../screens/homescreen/detail.dart';

class FavoriteConcertTile extends StatefulWidget {
  final Concert data;
  const FavoriteConcertTile({required this.data, super.key});

  @override
  State<FavoriteConcertTile> createState() => _FavoriteConcertTileState();
}

class _FavoriteConcertTileState extends State<FavoriteConcertTile> {
  Delete delete = Delete();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, SlideRightRoute(page: CardPage(data: widget.data)));
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
                        style: headlineTile,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.data.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: commonText,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                delete.deleteItem(widget.data.id,
                                    'favorite_service', context);
                              });
                            },
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.01),
                            child: Text(
                              'Remove',
                              style: headline2Profile,
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.share,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
