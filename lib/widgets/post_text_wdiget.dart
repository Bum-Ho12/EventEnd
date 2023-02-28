import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utilities/personalization.dart';

class TextFieldForProduct extends StatefulWidget {
  final String? content;
  final String iconForForm;
  const TextFieldForProduct(
      {required this.content, required this.iconForForm, super.key});

  @override
  State<TextFieldForProduct> createState() => _TextFieldForProductState();
}

class _TextFieldForProductState extends State<TextFieldForProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.content}',
          style: headlineTile,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              prefixIcon: widget.iconForForm.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset(
                        widget.iconForForm,
                        height: 20,
                        width: 20,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
