import 'package:flutter/material.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../classes/concert_class.dart';
import '../../network_services/add_to_favorites.dart';
import '../../utilities/personalization.dart';
import '../../widgets/snack_bar.dart';

class CardPage extends StatefulWidget {
  final Concert data;
  const CardPage({required this.data, super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  AddFavorite addToFavorite = AddFavorite();
  bool isSaved = false;
  bool? isSent = false;
  Future<void> _launchUrl(url, pathUri) async {
    final Uri uri = Uri(scheme: 'https', host: url, path: pathUri);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    String domain = Uri.parse(widget.data.webLink).host;
    String pathUri = Uri.parse(widget.data.webLink).path;
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
          InkWell(
            onTap: () async {
              bool isSent = await addToFavorite.addConcert(widget.data.id);
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
          IconButton(
            onPressed: () {
              Share.share(widget.data.webLink, subject: widget.data.webLink);
            },
            icon: Icon(
              Icons.share,
              color: ThemeApplication.lightTheme.backgroundColor2,
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
              widget.data.webLink.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              'Link Advert: ',
                              maxLines: 2,
                              style: headline1detail,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: LinkPreviewGenerator(
                                link: widget.data.webLink,
                                linkPreviewStyle: LinkPreviewStyle.small,
                                onTap: () {
                                  _launchUrl(domain, pathUri);
                                },
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
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
            onPressed: () {
              setState(() {
                buyTicket(widget.data.id, context);
              });
            },
            color: ThemeApplication.lightTheme.backgroundColor2,
            child: Text('Buy Ticket', style: headline1Profile),
          ),
        ],
      ),
    );
  }

  Future<void> buyTicket(id, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token')!;
    const url = 'https://eventend.pythonanywhere.com/ticketing/';
    final uri = Uri.parse(url);
    final req = http.MultipartRequest('POST', uri);
    Map<String, String> headers = {"Authorization": "Token $token"};
    req.headers.addAll(headers);
    req.fields['id'] = id.toString();
    final res = await req.send();
    final response = await http.Response.fromStream(res);
    if (response.statusCode == 201) {
      isSent = true;
      if (isSent == true) {
        setState(() {
          SnackNotification.snackCaller(
              context, 'Wait fo Ticket in Your email Address');
        });
      }
    } else {
      isSent = false;
    }
  }
}
