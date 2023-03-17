import 'package:eventend/classes/service_class.dart';
import 'package:eventend/network_services/delete.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../network_services/update_list_provider.dart';
import '../providers/service_favorites_provider.dart';
import '../screens/homescreen/check_profile.dart';

class FavoriteServiceTile extends StatefulWidget {
  final Service data;
  final int index;
  const FavoriteServiceTile(
      {required this.data, required this.index, super.key});

  @override
  State<FavoriteServiceTile> createState() => _FavoriteServiceTileState();
}

class _FavoriteServiceTileState extends State<FavoriteServiceTile> {
  Delete delete = Delete();
  @override
  Widget build(BuildContext context) {
    final FavoriteServiceProvider concertAssignProvider =
        Provider.of<FavoriteServiceProvider>(context);
    return Consumer<UpdateListProvider>(builder: (context, value, child) {
      return InkWell(
        onTap: () {
          Navigator.push(context,
              SlideRightRoute(page: ProfileViewPage(data: widget.data)));
        },
        child: Container(
          color: ThemeApplication.lightTheme.backgroundColor,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipOval(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(360)),
                      child: Image.network(
                        'https://eventend.pythonanywhere.com${widget.data.organizerProfilePicture}',
                        fit: BoxFit.fill,
                        height: 70,
                        width: 70,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: Text('Loading...'));
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Text('Error Loading the image!'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: headlineTile,
                        ),
                        Text(
                          widget.data.organizer,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: commonText,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      MaterialButton(
                        onPressed: () async {
                          await value.deleteItem(
                              widget.data.id, 'favorite_service', context);
                          if (value.isDeleted == true) {
                            setState(() {
                              concertAssignProvider.updateList(widget.index);
                            });
                          }
                        },
                        color: ThemeApplication.lightTheme.backgroundColor2
                            .withOpacity(0.01),
                        child: Text(
                          'Remove',
                          style: headline2Profile,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 2,
              )
            ],
          ),
        ),
      );
    });
  }
}
