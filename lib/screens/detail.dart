import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_preview_generator/link_preview_generator.dart';

import '../classes/concert_class.dart';
import '../utilities/personalization.dart';

class CardPage extends StatefulWidget {
  final Concert data;
  const CardPage({required this.data, super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ThemeApplication.lightTheme.backgroundColor2,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: ThemeApplication.lightTheme.backgroundColor2,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline,
              color: ThemeApplication.lightTheme.backgroundColor2,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              height: 24,
              width: 24,
              theme: SvgTheme(
                  currentColor: ThemeApplication.lightTheme.backgroundColor2),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://eventend.pythonanywhere.com${widget.data.concertPicture}',
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  widget.data.title,
                  style: headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: widget.data.organizeProfilePicture.toString() != ''
                          ? Image.network(
                              'https://eventend.pythonanywhere.com${widget.data.organizeProfilePicture}',
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill)
                          : Icon(
                              Icons.person,
                              color: ThemeApplication
                                  .lightTheme.backgroundColor2
                                  .withOpacity(0.6),
                              size: 100,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          widget.data.organizer,
                          style: headline1detail,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.7),
                ),
                title: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Event Date: ${widget.data.eventDate}',
                    style: headline1detail,
                  ),
                ),
                subtitle: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Start: ${widget.data.fromHour} - ${widget.data.toHour} GMT + 03:00',
                    style: headline2Detail,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.7),
                ),
                title: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Venue: ${widget.data.location}',
                    style: headline1detail,
                  ),
                ),
                subtitle: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    '${widget.data.toHour} - ${widget.data.fromHour} Hours',
                    style: headline2Detail,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.receipt,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.7),
                ),
                title: Text(
                  'Ksh. ${widget.data.price}',
                  style: headline1detail,
                ),
                subtitle: Text(
                  'on Eventend',
                  style: headline2Detail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'About',
                  style: headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.data.description,
                  style: commonText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: LinkPreviewGenerator(
                              link: widget.data.webLink,
                              linkPreviewStyle: LinkPreviewStyle.small,
                              onTap: () {},
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      color: ThemeApplication.lightTheme.backgroundColor2
                          .withOpacity(0.7),
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      onPressed: () {},
                      child: Text(
                        'Visit Website',
                        style: headline2Profile,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Location',
                  style: headline1,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Kshs. ${widget.data.price}',
            style: headline1detail,
          ),
          MaterialButton(
            onPressed: () {},
            color: ThemeApplication.lightTheme.backgroundColor2,
            child: Text('Buy Ticket', style: headline1Profile),
          ),
        ],
      ),
    );
  }
}
