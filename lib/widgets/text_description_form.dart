import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DescriptionFormTextWidget extends StatefulWidget {
  final String data;
  const DescriptionFormTextWidget({required this.data, super.key});

  @override
  State<DescriptionFormTextWidget> createState() =>
      _DescriptionFormTextWidgetState();
}

class _DescriptionFormTextWidgetState extends State<DescriptionFormTextWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      child: TextFormField(
        maxLines: 7,
        initialValue: widget.data,
        onChanged: (value) async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("description", value);
        },
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
