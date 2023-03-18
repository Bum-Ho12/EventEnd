import 'package:eventend/classes/user_class.dart';
import 'package:eventend/screens/profile/notification_page.dart';
import 'package:eventend/screens/profile/settings.dart';
import 'package:eventend/widgets/rive_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../forms/change_profile.dart';
import '../providers/network_provider.dart';
import '../utilities/personalization.dart';
import 'profile/list_of_posts.dart';
import 'profile/post_options.dart';

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
  Account account = Account();
  Future<void> getAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('email')) {
      account = Account(
        name: sharedPreferences.getString('username')!,
        token: sharedPreferences.getString('token')!,
        email: sharedPreferences.getString('email')!,
        password: sharedPreferences.getString('password')!,
        category: sharedPreferences.getInt('category')!,
        weekdayFrom: sharedPreferences.getInt("weekday_from")!,
        weekdayTo: sharedPreferences.getInt("weekday_to")!,
        location: sharedPreferences.getString("location")!,
        fromHour: sharedPreferences.getString("from_hour")!,
        toHour: sharedPreferences.getString("to_hour")!,
        socialMediaLink: sharedPreferences.getString("social_media_link")!,
        description: sharedPreferences.getString("description")!,
        phoneNumber: sharedPreferences.getString("phone_number")!,
        long: sharedPreferences.getDouble("long")!,
        lat: sharedPreferences.getDouble("lat")!,
        isCustomer: sharedPreferences.getBool("isCustomer")!,
        profilePicture: sharedPreferences.getString('profile_picture')!,
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    });
  }

  logout(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.remove('email');
      sharedPreferences.remove('password');
      sharedPreferences.remove('username');
      sharedPreferences.remove('profile_picture');
      sharedPreferences.remove('token');
      Navigator.popUntil(
        context,
        ModalRoute.withName(
          Navigator.defaultRouteName,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getAccount(),
          builder: (context, _) {
            return Consumer<NetworkProvider>(builder: (context, value, child) {
              return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    leading: Container(),
                    leadingWidth: 0,
                    title: const SizedBox(
                      height: 10,
                    ),
                    backgroundColor:
                        ThemeApplication.lightTheme.backgroundColor2,
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
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              child: account.profilePicture.toString() != ''
                                  ? value.isConnected == true
                                      ? Image.network(
                                          'https://eventend.pythonanywhere.com${account.profilePicture}',
                                          fit: BoxFit.fill,
                                          height: 100,
                                          errorBuilder: (BuildContext context,
                                              Object object,
                                              StackTrace? trace) {
                                            return Text(object.toString());
                                          },
                                        )
                                      : Icon(
                                          Icons.person,
                                          color: ThemeApplication
                                              .lightTheme.backgroundColor2
                                              .withOpacity(0.6),
                                          size: 100,
                                        )
                                  : Icon(
                                      Icons.person,
                                      color: ThemeApplication
                                          .lightTheme.backgroundColor2
                                          .withOpacity(0.6),
                                      size: 100,
                                    ),
                            ),
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
                                  account.name,
                                  style: headline1Profile,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.25),
                                child: MaterialButton(
                                  height: 25,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  onPressed: value.isConnected == true
                                      ? () async {
                                          Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                page: ChangeProfile(
                                              account: account,
                                            )),
                                          );
                                        }
                                      : () {
                                          Navigator.push(
                                            context,
                                            SlideRightRoute(
                                                page: ChangeProfile(
                                              account: account,
                                            )),
                                          );
                                        },
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor
                                      .withOpacity(0.4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                      .lightTheme
                                                      .backgroundColor,
                                                ),
                                                Text(
                                                  '200',
                                                  style: headline2Profile,
                                                ),
                                              ],
                                            ),
                                          ),
                                          account.category == 2
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Posts',
                                                        style: headline2Profile,
                                                      ),
                                                      Divider(
                                                        color: ThemeApplication
                                                            .lightTheme
                                                            .backgroundColor,
                                                      ),
                                                      Text(
                                                        '12',
                                                        style: headline2Profile,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: value.isConnected == true
                                          ? () {
                                              Navigator.push(
                                                context,
                                                SlideRightRoute(
                                                  page: PostsList(
                                                      account: account),
                                                ),
                                              );
                                            }
                                          : () {},
                                      height: 25,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      color: ThemeApplication
                                          .lightTheme.backgroundColor
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
                            onPressed: value.isConnected == true
                                ? () {
                                    Navigator.push(
                                      context,
                                      SlideRightRoute(
                                          page: PostOptions(
                                        data: account.category,
                                      )),
                                    );
                                  }
                                : () {},
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
                              color:
                                  ThemeApplication.lightTheme.backgroundColor,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: ThemeApplication
                                            .lightTheme.backgroundColor,
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 10),
                                        child: Text(profilePage[index][0],
                                            style: headlineForTile),
                                      ),
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
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: value.isConnected == true
                                ? () {
                                    setState(() {
                                      logout(context);
                                    });
                                  }
                                : () {},
                            height: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            color: ThemeApplication.lightTheme.warningColor
                                .withOpacity(0.8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                    color: ThemeApplication
                                        .lightTheme.backgroundColor,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('SIGN OUT', style: headline2Profile),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
          }),
    );
  }
}
