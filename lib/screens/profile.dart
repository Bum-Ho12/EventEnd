import 'package:flutter/material.dart';

import '../utilities/personalization.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

List profilePage = [
  ['General Settings'],
  ['Notifications'],
  ['Licenses'],
  ['About Eventend'],
  ['Version 0.0.1'],
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
                    backgroundColor: ThemeApplication.lightTheme.backgroundColor,
                    child: Image.asset('assets/images/lp_image.png',
                        fit: BoxFit.fill),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Text(
                          'Owner Name Here',
                          style: headline1Profile,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.edit_outlined,
                          color: ThemeApplication.lightTheme.backgroundColor,
                        ),
                      ),
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
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profilePage.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: ThemeApplication.lightTheme.backgroundColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  color: ThemeApplication.lightTheme.backgroundColor,
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 10),
                                  child: Text(profilePage[index][0],
                                      style: headlineForTile)),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: ThemeApplication.lightTheme.backgroundColor2,
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          )
                        ],
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
