import 'package:eventend/classes/service_class.dart';
import 'package:eventend/network_services/add_to_favorites.dart';
import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

import '../forms/request_form.dart';
import '../screens/homescreen/check_profile.dart';

class SuggestedCard extends StatefulWidget {
  final Service data;
  const SuggestedCard({required this.data, super.key});

  @override
  State<SuggestedCard> createState() => _SuggestedCardState();
}

class _SuggestedCardState extends State<SuggestedCard> {
  AddFavorite addToFavorite = AddFavorite();
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, SlideRightRoute(page: ProfileViewPage(data: widget.data)));
      },
      child: Container(
          height: 220,
          width: 180,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: ThemeApplication.lightTheme.backgroundColor,
              border: Border.all(
                  width: 0.5,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 0.1,
                    spreadRadius: 0.15,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.network(
                    'https://eventend.pythonanywhere.com${widget.data.organizerProfilePicture}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                          child:
                              SizedBox(height: 100, child: Text('Loading...')));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Error Loading the image!'),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.data.title,
                style: headlineTile,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.data.organizer,
                style: headlineTile,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Ksh.${widget.data.price}',
                style: commonTextMain,
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: ThemeApplication.lightTheme.backgroundColor2
                          .withOpacity(0.3),
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            SlideRightRoute(
                                page: RequestForm(data: widget.data)));
                      },
                      child: Text(
                        'Request',
                        style: headline2Detail,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        bool isSent =
                            await addToFavorite.addService(widget.data.id);
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
                  ],
                ),
              )
            ],
          )),
    );
  }
}
