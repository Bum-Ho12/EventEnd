import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class FormTextWidget extends StatefulWidget {
  const FormTextWidget({super.key});

  @override
  State<FormTextWidget> createState() => _FormTextWidgetState();
}

class _FormTextWidgetState extends State<FormTextWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
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
