import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class DescriptionFormTextWidget extends StatefulWidget {
  const DescriptionFormTextWidget({super.key});

  @override
  State<DescriptionFormTextWidget> createState() => _DescriptionFormTextWidgetState();
}

class _DescriptionFormTextWidgetState extends State<DescriptionFormTextWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 200,
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
