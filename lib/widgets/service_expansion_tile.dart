import 'package:eventend/classes/service_class.dart';
import 'package:flutter/material.dart';

import '../utilities/personalization.dart';

class ServiceExpansionWidget extends StatefulWidget {
  final Service data;
  const ServiceExpansionWidget({required this.data, super.key});

  @override
  State<ServiceExpansionWidget> createState() => _ServiceExpansionWidgetState();
}

class _ServiceExpansionWidgetState extends State<ServiceExpansionWidget> {
  final List<Item> _data = generatedItems(1);

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(
          () {
            _data[index].isExpanded = !isExpanded;
          },
        );
      },
      children: _data.map<ExpansionPanel>(
        (Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  widget.data.title,
                  style: headlineTile,
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'Update',
                            style: headlineTile,
                          ),
                          Icon(
                            Icons.edit,
                            size: 30,
                            color: ThemeApplication.lightTheme.backgroundColor2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            body: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://eventend.pythonanywhere.com${widget.data.organizerProfilePicture}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: SizedBox(
                                  height: 100, child: Text('Loading...')));
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Text('Error Loading the image!'),
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Column(
                children: [
                  Text(
                    widget.data.description,
                    style: commonTextMain,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.receipt,
                      color: ThemeApplication.lightTheme.backgroundColor2
                          .withOpacity(0.7),
                    ),
                    title: Text(
                      'Ksh. ${widget.data.price}',
                      style: headline1detail,
                    ),
                    subtitle: Text(
                      'on Eventend',
                      style: headline2Detail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data.webLink,
                      style: headline2detail,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                        child: Text(
                          'Views: ',
                          style: headline1detail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 8, bottom: 8),
                        child: Text(
                          widget.data.traffic.toString(),
                          style: headline2Detail,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            isExpanded: item.isExpanded!,
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }
}

class Item {
  String? expandedValue;
  String? headerValue;
  bool? isExpanded;

  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });
}

List<Item> generatedItems(int numberOfItems) {
  return List.generate(numberOfItems, (index) {
    return Item(
        headerValue: 'Ticket for Develop Concert $index',
        expandedValue: 'This is Item number $index');
  });
}
