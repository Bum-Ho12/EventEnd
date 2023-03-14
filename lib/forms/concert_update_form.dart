import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/concert_create_provider.dart';
import '../utilities/personalization.dart';
import '../widgets/put_form_text_widget.dart';
import 'concert_update_form2.dart';

class ConcertUpdateForm extends StatefulWidget {
  final String concertPicture;
  final String id;
  const ConcertUpdateForm(
      {required this.concertPicture, required this.id, super.key});

  @override
  State<ConcertUpdateForm> createState() => _ConcertUpdateFormState();
}

class _ConcertUpdateFormState extends State<ConcertUpdateForm> {
  TextEditingController dateForEvent = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _webLink = TextEditingController();
  @override
  void initState() {
    final ConcertCreateProvider concertProvider =
        Provider.of<ConcertCreateProvider>(context, listen: false);
    super.initState();
    _title = TextEditingController(text: concertProvider.title);
    _price = TextEditingController(text: concertProvider.price.toString());
    _location = TextEditingController(text: concertProvider.location);
    _webLink = TextEditingController(text: concertProvider.webLink);
    dateForEvent = TextEditingController(text: concertProvider.eventDate);
  }

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final ConcertCreateProvider concertAssignProvider =
        Provider.of<ConcertCreateProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Concert', style: pageTitle),
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
                  PutTextFieldForProductWidget(
                    content: 'Title',
                    iconForForm: '',
                    initialValue: _title,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1994),
                              lastDate: DateTime(2101),
                              builder: (BuildContext context, Widget? child) {
                                return child!;
                              },
                            );
                            if (picked != null && picked != date) {
                              setState(() {
                                date = picked;
                                concertAssignProvider.setEventDate(
                                    DateFormat('dd-MM-yyyy').format(date));
                                dateForEvent = TextEditingController(
                                    text: concertAssignProvider.eventDate);
                              });
                            }
                          },
                          child: Container(
                            color: ThemeApplication.lightTheme.backgroundColor2
                                .withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Change Date of Event',
                                style: headline2detail,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          dateForEvent.text,
                          style: headline2Detail,
                        ),
                      ],
                    ),
                  ),
                  PutTextFieldForProductWidget(
                    content: 'Website/portfolio link',
                    iconForForm: '',
                    initialValue: _webLink,
                  ),
                  PutTextFieldForProductWidget(
                    content: 'Location',
                    iconForForm: '',
                    initialValue: _location,
                  ),
                  PutTextFieldForProductWidget(
                    content: 'Ticket Price',
                    iconForForm: '',
                    initialValue: _price,
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
                    SlideRightRoute(
                        page: ConcertUpdateFormSecond(
                      concertPicture: widget.concertPicture,
                      id: widget.id,
                    )),
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
