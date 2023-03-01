import 'package:flutter/material.dart';

import '../utilities/personalization.dart';
import '../widgets/post_text_widget.dart';

class PostServicePageTwo extends StatefulWidget {
  const PostServicePageTwo({super.key});

  @override
  State<PostServicePageTwo> createState() => _PostServicePageTwoState();
}

class _PostServicePageTwoState extends State<PostServicePageTwo> {
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
                      content: 'Description',
                      iconForForm: '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Paybill',
                          style: headlineTile,
                        ),
                        Icon(
                          Icons.receipt,
                          color: ThemeApplication.lightTheme.backgroundColor2,
                        )
                      ],
                    ),
                    const TextFieldForProduct(
                      content: '',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {},
                color: ThemeApplication.lightTheme.backgroundColor2,
                child: Text('Post', style: headline2Profile),
              )
            ],
          ),
        ),
      ),
    );
  }
}
