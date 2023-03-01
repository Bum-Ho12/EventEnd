import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

import 'post.dart';

class PostOptions extends StatefulWidget {
  const PostOptions({super.key});

  @override
  State<PostOptions> createState() => _PostOptionsState();
}

class _PostOptionsState extends State<PostOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Option', style: pageTitle),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.celebration_outlined,
            size: 40,
            color: ThemeApplication.lightTheme.backgroundColor2,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                SlideRightRoute(page: const PostService()),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Container(
                height: 100,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Concert',
                      style: pageTitle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Icon(
            Icons.room_service_outlined,
            size: 40,
            color: ThemeApplication.lightTheme.backgroundColor2,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                SlideRightRoute(page: const PostService()),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Container(
                height: 100,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ThemeApplication.lightTheme.backgroundColor2
                      .withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Service',
                      style: pageTitle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
