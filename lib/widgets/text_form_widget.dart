import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/day_selector.dart';

class FormTextWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final String fromType;
  const FormTextWidget({required this.data, required this.fromType, super.key});

  @override
  State<FormTextWidget> createState() => _FormTextWidgetState();
}

class _FormTextWidgetState extends State<FormTextWidget> {
  DayIdentifier dayIdentifier = DayIdentifier();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        keyboardType: widget.fromType == 'phone_number'
            ? TextInputType.number
            : widget.fromType == 'email'
                ? TextInputType.emailAddress
                : widget.fromType == 'hour' || widget.fromType == 'hour_to'
                    ? TextInputType.datetime
                    : TextInputType.text,
        onChanged: (value) async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          if (widget.fromType == 'name') {
            setState(() {
              sharedPreferences.setString('username', value.trim());
            });
          } else if (widget.fromType == 'email') {
            setState(() {
              sharedPreferences.setString('email', value.trim());
            });
          } else if (widget.fromType == 'weekday') {
            int valueInt = dayIdentifier.getDayInNumber(value.trim());
            setState(() {
              sharedPreferences.setInt("weekday_from", valueInt);
            });
          } else if (widget.fromType == 'weekdayTo') {
            int valueInt = dayIdentifier.getDayInNumber(value.trim());
            setState(() {
              sharedPreferences.setInt("weekday_to", valueInt);
            });
          } else if (widget.fromType == 'location') {
            setState(() {
              sharedPreferences.setString("location", value.trim());
            });
          } else if (widget.fromType == 'hour') {
            setState(() {
              sharedPreferences.setString("from_hour", value.trim());
            });
          } else if (widget.fromType == 'hour_to') {
            setState(() {
              sharedPreferences.setString("to_hour", value.trim());
            });
          } else if (widget.fromType == 'media_link') {
            setState(() {
              sharedPreferences.setString("social_media_link", value.trim());
            });
          } else if (widget.fromType == 'phone_number') {
            setState(() {
              sharedPreferences.setString("phone_number", value.trim());
            });
          } else if (widget.fromType == 'long') {
            setState(() {
              sharedPreferences.setDouble("long", double.parse(value.trim()));
            });
          } else if (widget.fromType == 'lat') {
            setState(() {
              sharedPreferences.setDouble("lat", double.parse(value.trim()));
            });
          }
        },
        initialValue: '${widget.data}',
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor:
              ThemeApplication.lightTheme.backgroundColor2.withOpacity(0.07),
        ),
      ),
    );
  }
}
