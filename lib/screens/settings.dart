import 'package:flutter/material.dart';

import '../utilities/personalization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List settingsPage = [
    ['Licenses'],
    ['About Eventend'],
    ['Version 0.0.1'],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: pageTitle),
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
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: settingsPage.length,
              itemBuilder: (context, index) {
                return Container(
                  color: ThemeApplication.lightTheme.backgroundColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              color:
                                  ThemeApplication.lightTheme.backgroundColor,
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.only(top: 20, left: 10),
                              child: Text(settingsPage[index][0],
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
    );
  }
}
