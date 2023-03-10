import 'package:flutter/material.dart';

import '../utilities/personalization.dart';
import '../widgets/post_text_widget.dart';
import 'post_second.dart';

class PostService extends StatefulWidget {
  const PostService({super.key});

  @override
  State<PostService> createState() => _PostServiceState();
}

class _PostServiceState extends State<PostService> {
  late final String name;
  late final String about;
  late final double price;
  late final String portfolio;
  late final String location;
  // final openDays = Time(start: TimeOfDay(hour: 8, minute: 0), end: end);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Service', style: pageTitle),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: ListView(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.05
                            : 20),
                    const TextFieldForProduct(
                      content: 'Title',
                      iconForForm: '',
                    ),
                    const TextFieldForProduct(
                      content: 'Date',
                      iconForForm: '',
                    ),
                    const TextFieldForProduct(
                      content: 'Website/portfolio link',
                      iconForForm: '',
                    ),
                    const TextFieldForProduct(
                      content: 'Location',
                      iconForForm: '',
                    ),
                    const TextFieldForProduct(
                      content: 'Venue',
                      iconForForm: '',
                    ),
                  ])
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: ThemeApplication.lightTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(page: const PostServicePageTwo()),
                  );
                },
                color: ThemeApplication.lightTheme.backgroundColor2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Next', style: headline2Profile),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ThemeApplication.lightTheme.backgroundColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
