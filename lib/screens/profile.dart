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
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(150),
            bottomRight: Radius.circular(70),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: backgroundColor,
                child: Image.asset('assets/images/lp_image.png',
                    fit: BoxFit.fill, height: 70, width: 70),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      'Owner Name',
                      style: headline1,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.edit_outlined,
                      color: backgroundColor2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child:
                                    Text('Settings', style: headlineForTile)),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
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
    );
  }
}
