import 'package:flutter/material.dart';

import '../utilities/personalization.dart';
import '../widgets/post_add_text_widget.dart';
import 'concert_post_form2.dart';

class ConcertPostForm extends StatefulWidget {
  const ConcertPostForm({super.key});

  @override
  State<ConcertPostForm> createState() => _ConcertPostFormState();
}

class _ConcertPostFormState extends State<ConcertPostForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Concert', style: pageTitle),
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
      body: Padding(
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
                          ? MediaQuery.of(context).size.height * 0.01
                          : 10),
                  const TextFieldForProductWidget(
                    content: 'Title',
                    iconForForm: '',
                  ),
                  const TextFieldForProductWidget(
                    content: 'Date of Event',
                    iconForForm: '',
                  ),
                  const TextFieldForProductWidget(
                    content: 'Website/portfolio link',
                    iconForForm: '',
                  ),
                  const TextFieldForProductWidget(
                    content: 'Location',
                    iconForForm: '',
                  ),
                  const TextFieldForProductWidget(
                    content: 'Ticket Price',
                    iconForForm: '',
                  ),
                ]),
            const SizedBox(
              height: 70,
            )
          ],
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
                    SlideRightRoute(page: const ConcertPostFormSecond()),
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
