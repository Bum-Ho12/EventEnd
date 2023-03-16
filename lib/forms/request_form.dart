import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/service_class.dart';
import '../providers/request_provider.dart';
import '../utilities/personalization.dart';
import '../widgets/snack_bar.dart';

class RequestForm extends StatefulWidget {
  final Service data;
  const RequestForm({required this.data, super.key});

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  bool showSearchBar = false;
  TextEditingController _description = TextEditingController();
  int wordCount = 0;
  @override
  void initState() {
    final RequestProvider requestProvider =
        Provider.of<RequestProvider>(context, listen: false);
    super.initState();
    _description = TextEditingController(text: requestProvider.description);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RequestProvider requestAssignProvider =
        Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Request', style: pageTitle),
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
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.data.title,
                        style: headline1detail,
                      ),
                      Text(
                        'Title',
                        style: headline2Detail,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Description:',
                              style: headline1detail,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Write a brief description of your\n request.\n'
                              'The words limit is 400 words.',
                              style: headline2Detail,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 200,
                    child: TextFormField(
                      controller: _description,
                      onChanged: (value) {
                        setState(() {
                          wordCount = value.length;
                        });
                      },
                      onSaved: (value) {
                        requestAssignProvider.setToSend(
                            widget.data.id.toString(),
                            widget.data.organizerId.toString(),
                            value);
                      },
                      maxLines: 7,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: ThemeApplication.lightTheme.backgroundColor2
                            .withOpacity(0.07),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${wordCount.toString()}/400',
                              style: headline2Detail,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: ThemeApplication.lightTheme.backgroundColor2
                            .withOpacity(0.3),
                        elevation: 0.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          requestAssignProvider.sendRequest();
                          if (requestAssignProvider.isSent == true) {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(Navigator.defaultRouteName),
                            );
                            SnackNotification.snackCaller(
                                context, 'Request sent');
                          }
                        },
                        child: Text(
                          'Request',
                          style: headline2Detail,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
