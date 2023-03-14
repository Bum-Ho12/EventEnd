import 'package:eventend/providers/concert_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../utilities/personalization.dart';

class PutTextFieldForProductWidget extends StatefulWidget {
  final String? content;
  final String iconForForm;
  final TextEditingController initialValue;
  const PutTextFieldForProductWidget(
      {required this.content,
      required this.iconForForm,
      required this.initialValue,
      super.key});

  @override
  State<PutTextFieldForProductWidget> createState() =>
      _PutTextFieldForProductWidgetState();
}

class _PutTextFieldForProductWidgetState
    extends State<PutTextFieldForProductWidget> {
  @override
  Widget build(BuildContext context) {
    final ConcertCreateProvider concertAssignProvider =
        Provider.of<ConcertCreateProvider>(context);
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
            controller: widget.initialValue,
            maxLines: widget.content == 'Description' ? 7 : 1,
            onChanged: (value) {
              if (widget.content == 'Title') {
                concertAssignProvider.setTitle(value.trim());
              } else if (widget.content == 'Website/portfolio link') {
                concertAssignProvider.setWebLink(value.trim());
              } else if (widget.content == 'Location') {
                concertAssignProvider.setLocation(value.trim());
              } else if (widget.content == 'Ticket Price') {
                int price;
                if (value.trim().isEmpty) {
                  price = 0;
                } else {
                  price = int.parse(value.trim());
                }
                concertAssignProvider.setPrice(price);
              } else if (widget.content == 'From:') {
                concertAssignProvider.setFromHour(value.trim());
              } else if (widget.content == 'To:') {
                concertAssignProvider.setToHour(value.trim());
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
