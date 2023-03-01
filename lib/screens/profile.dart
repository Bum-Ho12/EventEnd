import 'package:eventend/screens/change_profile.dart';
import 'package:eventend/screens/notification_page.dart';
import 'package:eventend/screens/settings.dart';
import 'package:eventend/widgets/rive_icons.dart';
import 'package:flutter/material.dart';

import '../utilities/personalization.dart';
import 'list_of_posts.dart';
import 'post_options.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

List profilePage = [
  ['General Settings', const SettingsPage()],
  ['Notifications', const NotificationsPage()],
];

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: Container(),
            leadingWidth: 0,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Followers: 456',
                    style: headline2Profile,
                  ),
                  Text(
                    'Presence: 8/10',
                    style: headline2Profile,
                  )
                ]),
            backgroundColor: ThemeApplication.lightTheme.backgroundColor2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor:
                        ThemeApplication.lightTheme.backgroundColor,
                    child: Image.asset('assets/images/lp_image.png',
                        fit: BoxFit.fill),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Text(
                          'Owner Name Here',
                          style: headline1Profile,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.25),
                        child: MaterialButton(
                          height: 25,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlideRightRoute(page: const ChangeProfile()),
                            );
                          },
                          color: ThemeApplication.lightTheme.backgroundColor
                              .withOpacity(0.4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Edit Profile',
                                style: headline2Profile,
                              ),
                              const PenEdit(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeApplication.lightTheme.backgroundColor2,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Traffic',
                                          style: headline2Profile,
                                        ),
                                        Divider(
                                          color: ThemeApplication
                                              .lightTheme.backgroundColor,
                                        ),
                                        Text(
                                          '200',
                                          style: headline2Profile,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Views',
                                          style: headline2Profile,
                                        ),
                                        Divider(
                                          color: ThemeApplication
                                              .lightTheme.backgroundColor,
                                        ),
                                        Text(
                                          '200',
                                          style: headline2Profile,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Posts',
                                          style: headline2Profile,
                                        ),
                                        Divider(
                                          color: ThemeApplication
                                              .lightTheme.backgroundColor,
                                        ),
                                        Text(
                                          '12',
                                          style: headline2Profile,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SlideRightRoute(page: const PostsList()),
                                );
                              },
                              height: 25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                              color: ThemeApplication.lightTheme.backgroundColor
                                  .withOpacity(0.4),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'View Posts',
                                  style: headline2Profile,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        SlideRightRoute(page: const PostOptions()),
                      );
                    },
                    height: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    color: ThemeApplication.lightTheme.backgroundColor2
                        .withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('POST', style: headline2Profile),
                    ),
                  )
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profilePage.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          SlideRightRoute(page: profilePage[index][1]),
                        );
                      },
                      child: Container(
                        color: ThemeApplication.lightTheme.backgroundColor,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    color: ThemeApplication
                                        .lightTheme.backgroundColor,
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 10),
                                    child: Text(profilePage[index][0],
                                        style: headlineForTile)),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor2,
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
