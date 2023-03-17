import 'package:eventend/classes/service_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilities/personalization.dart';

class ProfileViewPage extends StatefulWidget {
  final Service data;
  const ProfileViewPage({required this.data, super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  @override
  Widget build(BuildContext context) {
    String domain = Uri.parse(widget.data.webLink).host;
    // String domainName = domain.split('.')[domain.split('.').length - 2];
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
                        if (await canLaunchUrl(
                            Uri.parse(widget.data.webLink))) {
                          await launchUrl(Uri.parse(widget.data.webLink));
                        }
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         'website: ',
              //         style: headline1detail,
              //       ),
              //       SizedBox(
              //         height: 70,
              //         width: MediaQuery.of(context).size.width * 0.65,
              //         child: LinkPreviewGenerator(
              //           link: widget.data.webLink,
              //           linkPreviewStyle: LinkPreviewStyle.small,
              //           boxShadow: const [
              //             BoxShadow(
              //               blurRadius: 0.0,
              //               spreadRadius: 0.0,
              //             ),
              //           ],
              //           onTap: () {},
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {},
            color: ThemeApplication.lightTheme.backgroundColor2,
            child: Text('Connect', style: headline1Profile),
          ),
        ],
      ),
    );
  }
}
