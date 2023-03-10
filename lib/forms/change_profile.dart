import 'package:eventend/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';

import '../classes/user_class.dart';
import '../utilities/personalization.dart';

class ChangeProfile extends StatefulWidget {
  final Account account;
  const ChangeProfile({required this.account, super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool changeName = false;
  bool changeProfileLink = false;
  bool changeLocation = false;
  bool openDays = false;
  bool changeDescription = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Profile', style: pageTitle),
        backgroundColor: ThemeApplication.lightTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ThemeApplication.lightTheme.backgroundColor2,
          ),
        ),
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
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(369),
                            child: widget.account.profilePicture != ''
                                ? Image.network(
                                    'https://eventend.pythonanywhere.com${widget.account.profilePicture}',
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.fill,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                          child: Text('Loading...'));
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor2,
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    color: ThemeApplication
                                        .lightTheme.backgroundColor,
                                    size: 24,
                                  )),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      widget.account.name,
                      style: headline1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        changeName = !changeName;
                      });
                    },
                    icon: changeName == true
                        ? Icon(
                            Icons.close,
                            color: ThemeApplication.lightTheme.backgroundColor2,
                          )
                        : Icon(
                            Icons.edit_outlined,
                            color: ThemeApplication.lightTheme.backgroundColor2,
                          ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: changeName == false
                    ? const SizedBox()
                    : const FormTextWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        widget.account.socialMediaLink,
                        style: headline2detail,
                        maxLines: 3,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          changeProfileLink = !changeProfileLink;
                        });
                      },
                      icon: changeProfileLink == true
                          ? Icon(
                              Icons.close,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            )
                          : Icon(
                              Icons.edit_outlined,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: changeProfileLink == false
                    ? const SizedBox()
                    : const FormTextWidget(),
              ),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.7),
                ),
                title: Row(
                  children: [
                    Text(
                      'Open Days',
                      style: headline1detail,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          openDays = !openDays;
                        });
                      },
                      icon: openDays == true
                          ? Icon(
                              Icons.close,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            )
                          : Icon(
                              Icons.edit_outlined,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            ),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.account.weekdayFrom.toString()}-'
                      '${widget.account.weekdayTo..toString()}',
                      style: headline2Detail,
                    ),
                    openDays == false
                        ? const SizedBox()
                        : const FormTextWidget(),
                    Text(
                      '${widget.account.fromHour} - ${widget.account.toHour}',
                      style: headline2Detail,
                    ),
                    openDays == false
                        ? const SizedBox()
                        : const FormTextWidget(),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.7),
                ),
                title: Row(
                  children: [
                    Text(
                      'Business Location',
                      style: headline1detail,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          changeLocation = !changeLocation;
                        });
                      },
                      icon: changeLocation == true
                          ? Icon(
                              Icons.close,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            )
                          : Icon(
                              Icons.edit_outlined,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            ),
                    )
                  ],
                ),
                subtitle: Column(
                  children: [
                    Text(
                      widget.account.location,
                      style: headline2Detail,
                    ),
                    changeLocation == false
                        ? const SizedBox()
                        : const FormTextWidget(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      Text(
                        'Brief Description',
                        style: headline1,
                        maxLines: 6,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            changeDescription = !changeDescription;
                          });
                        },
                        icon: changeDescription == true
                            ? Icon(
                                Icons.close,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              )
                            : Icon(
                                Icons.edit_outlined,
                                color: ThemeApplication
                                    .lightTheme.backgroundColor2,
                              ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.account.description,
                  style: commonTextMain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: changeDescription == false
                    ? const SizedBox()
                    : const FormTextWidget(),
              )
            ],
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
