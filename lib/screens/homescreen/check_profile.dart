import 'package:eventend/classes/service_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../forms/request_form.dart';
import '../../utilities/personalization.dart';

class ProfileViewPage extends StatefulWidget {
  final Service data;
  const ProfileViewPage({required this.data, super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  bool? isShowBottomSheet = false;

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
              Container(
                height: 300,
                color: ThemeApplication.lightTheme.backgroundColor2
                    .withOpacity(0.2),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/band.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: MediaQuery.of(context).size.width * 0.5 - 75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(369),
                        child: widget.data.organizerProfilePicture.toString() !=
                                ''
                            ? Image.network(
                                'https://eventend.pythonanywhere.com${widget.data.organizerProfilePicture}',
                                height: 150,
                                width: 150,
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                      child: Text('Loading...'));
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.person,
                                  size: 100,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2
                                    .withOpacity(0.6),
                                size: 100,
                              ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    widget.data.organizer,
                    style: headline1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Portfolio: ',
                      style: headline1detail,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: domain == "www.instagram.com"
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/instagram.svg',
                                height: 64,
                                width: 64,
                              ),
                            )
                          : domain == 'www.linkedin.com'
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/icons/linkedin.svg',
                                    height: 64,
                                    width: 64,
                                  ),
                                )
                              : domain == 'www.twitter.com'
                                  ? IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/icons/twitter.svg',
                                        height: 64,
                                        width: 64,
                                      ),
                                    )
                                  : Text(
                                      domain,
                                      style: commonText,
                                    ),
                    ),
                    const Spacer(),
                    MaterialButton(
                      color: ThemeApplication.lightTheme.backgroundColor2
                          .withOpacity(0.7),
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      onPressed: () async {
                        _launchUrl(domain, pathUri);
                      },
                      child: Text(
                        'Check Out',
                        style: headline2Profile,
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.7),
                ),
                title: Text(
                  'Service Price',
                  style: headline1detail,
                ),
                subtitle: Text(
                  'Kshs. ${widget.data.price}',
                  style: headline2Detail,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.7),
                ),
                title: Text(
                  'Business Location',
                  style: headline1detail,
                ),
                subtitle: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    widget.data.long,
                    style: headline2Detail,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Brief Description',
                    style: headline1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.data.description,
                    style: commonTextMain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
      bottomSheet: isShowBottomSheet == false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      isShowBottomSheet = true;
                    });
                  },
                  color: ThemeApplication.lightTheme.backgroundColor2,
                  child: Text('Connect', style: headline1Profile),
                ),
              ],
            )
          : SizedBox(
              height: 200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isShowBottomSheet = false;
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: ThemeApplication.lightTheme.backgroundColor2,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              String email =
                                  Uri.encodeComponent(widget.data.email);
                              String subject = Uri.encodeComponent(
                                  '${widget.data.title} Request');
                              String body = Uri.encodeComponent("");
                              // print(subject); //output: Hello%20Flutter
                              Uri mail = Uri.parse(
                                  "mailto:$email?subject=$subject&body=$body");
                              if (await launchUrl(mail)) {
                                //email app opened
                              } else {
                                // SnackNotification.snackCaller(context, 'An error Occurred,try again!');
                              }
                            },
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.1),
                            elevation: 0.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: SvgPicture.asset(
                                'assets/icons/email.svg',
                                height: 50,
                                width: 60,
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              Uri sms = Uri.parse(
                                  'sms:+254 ${widget.data.organizerPhoneNumber} ?body=');
                              if (await launchUrl(sms)) {
                                //app opened
                              } else {
                                //app is not opened
                              }
                            },
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.1),
                            elevation: 0.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: Image.asset(
                                'assets/icons/sms.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          // const Spacer(),
                          MaterialButton(
                            onPressed: () async {
                              Uri phoneNo = Uri.parse(
                                  'tel:${widget.data.organizerPhoneNumber}');
                              if (await launchUrl(phoneNo)) {
                                //dialer opened
                              } else {
                                //dialer is not opened
                              }
                            },
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.1),
                            elevation: 0.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.phone,
                                size: 50,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: ThemeApplication.lightTheme.backgroundColor2
                            .withOpacity(0.3),
                        elevation: 0.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              SlideRightRoute(
                                  page: RequestForm(data: widget.data)));
                        },
                        child: Text(
                          'Send Request',
                          style: headline2Detail,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
