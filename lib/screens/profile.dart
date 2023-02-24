import 'package:flutter/material.dart';

import '../utilities/personalization.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

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
            backgroundColor: backgroundColor2,
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
                    backgroundColor: backgroundColor,
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
                          color: backgroundColor,
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
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      color: backgroundColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  height: 60,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child:
                                      Text('Settings', style: headlineForTile)),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                                color: backgroundColor2,
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
