import 'package:eventend/providers/service_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../utilities/personalization.dart';

class ServiceTextFieldForProductWidget extends StatefulWidget {
  final String? content;
  final String iconForForm;
  const ServiceTextFieldForProductWidget(
      {required this.content, required this.iconForForm, super.key});

  @override
  State<ServiceTextFieldForProductWidget> createState() =>
      _ServiceTextFieldForProductWidgetState();
}

class _ServiceTextFieldForProductWidgetState
    extends State<ServiceTextFieldForProductWidget> {
  TextEditingController _description = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _webLink = TextEditingController();
  @override
  void initState() {
    final ServiceCreateProvider serviceProvider =
        Provider.of<ServiceCreateProvider>(context, listen: false);
    super.initState();
    _description = TextEditingController(text: serviceProvider.description);
    _title = TextEditingController(text: serviceProvider.title);
    _price = TextEditingController(text: serviceProvider.price.toString());
    _webLink = TextEditingController(text: serviceProvider.webLink);
  }

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
            controller: widget.content == 'Title'
                ? _title
                : widget.content == 'Website/portfolio'
                    ? _webLink
                    : widget.content == 'Price'
                        ? _price
                        : _description,
            maxLines: widget.content == 'Description' ? 7 : 1,
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
