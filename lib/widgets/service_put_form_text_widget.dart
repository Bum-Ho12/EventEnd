import 'package:eventend/providers/service_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../utilities/personalization.dart';

class PutServiceTextFieldForProductWidget extends StatefulWidget {
  final String? content;
  final String iconForForm;
  final TextEditingController controller;
  const PutServiceTextFieldForProductWidget(
      {required this.content,
      required this.iconForForm,
      required this.controller,
      super.key});

  @override
  State<PutServiceTextFieldForProductWidget> createState() =>
      _PutServiceTextFieldForProductWidgetState();
}

class _PutServiceTextFieldForProductWidgetState
    extends State<PutServiceTextFieldForProductWidget> {
  @override
  Widget build(BuildContext context) {
    final ServiceCreateProvider concertAssignProvider =
        Provider.of<ServiceCreateProvider>(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
              '${widget.content}',
              style: headlineTile,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: TextFormField(
            controller: widget.controller,
            onChanged: (value) {
              if (widget.content == 'Title') {
                concertAssignProvider.setTitle(value.trim());
              } else if (widget.content == 'Website/Portfolio') {
                concertAssignProvider.setWebLink(value.trim());
              } else if (widget.content == 'Price') {
                int price;
                if (value.trim().isEmpty) {
                  price = 0;
                } else {
                  price = int.parse(value.trim());
                }
                concertAssignProvider.setPrice(price);
              } else if (widget.content == 'Description') {
                concertAssignProvider.setDescription(value.trim());
              }
            },
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
