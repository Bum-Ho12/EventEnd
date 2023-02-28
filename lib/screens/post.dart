import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utilities/personalization.dart';
import '../widgets/post_text_wdiget.dart';

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
      body: ListView(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                TextFieldForProduct(
                  content: 'Title',
                  iconForForm: '',
                ),
                TextFieldForProduct(
                  content: 'Description',
                  iconForForm: '',
                ),
                TextFieldForProduct(
                  content: 'Date',
                  iconForForm: '',
                ),
                TextFieldForProduct(
                  content: 'Website/portfolio link',
                  iconForForm: '',
                ),
                TextFieldForProduct(
                  content: 'Location',
                  iconForForm: '',
                ),
                TextFieldForProduct(
                  content: 'Venue',
                  iconForForm: '',
                ),
              ])
        ],
      ),
    );
  }
}
