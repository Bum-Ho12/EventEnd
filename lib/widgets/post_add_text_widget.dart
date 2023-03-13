import 'package:eventend/providers/concert_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../utilities/personalization.dart';

class TextFieldForProductWidget extends StatefulWidget {
  final String? content;
  final String iconForForm;
  const TextFieldForProductWidget(
      {required this.content, required this.iconForForm, super.key});

  @override
  State<TextFieldForProductWidget> createState() =>
      _TextFieldForProductWidgetState();
}

class _TextFieldForProductWidgetState extends State<TextFieldForProductWidget> {
  TextEditingController _description = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _fromHour = TextEditingController();
  TextEditingController _toHour = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _webLink = TextEditingController();
  @override
  void initState() {
    final ConcertCreateProvider concertProvider =
        Provider.of<ConcertCreateProvider>(context, listen: false);
    super.initState();
    _description = TextEditingController(text: concertProvider.description);
    _title = TextEditingController(text: concertProvider.title);
    _fromHour = TextEditingController(text: concertProvider.fromHour);
    _toHour = TextEditingController(text: concertProvider.toHour);
    _location = TextEditingController(text: concertProvider.location);
    _price = TextEditingController(text: concertProvider.price.toString());
    _webLink = TextEditingController(text: concertProvider.webLink);
  }

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
            controller: widget.content == 'Title'
                ? _title
                : widget.content == 'Website/portfolio link'
                    ? _webLink
                    : widget.content == 'Location'
                        ? _location
                        : widget.content == 'Ticket Price'
                            ? _price
                            : widget.content == 'From:'
                                ? _fromHour
                                : widget.content == 'To:'
                                    ? _toHour
                                    : _description,
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
