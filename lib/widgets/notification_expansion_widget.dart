import 'package:eventend/classes/notification_class.dart';
import 'package:eventend/network_services/feedback.dart';
import 'package:flutter/material.dart';

import '../utilities/personalization.dart';

class NotificationExpansionWidget extends StatefulWidget {
  final RequestClass data;
  const NotificationExpansionWidget({required this.data, super.key});

  @override
  State<NotificationExpansionWidget> createState() =>
      _NotificationExpansionWidgetState();
}

class _NotificationExpansionWidgetState
    extends State<NotificationExpansionWidget> {
  final List<Item> _data = generatedItems(1);
  bool? isViewed;
  FeedBack feedBack = FeedBack();

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(
          () {
            _data[index].isExpanded = !isExpanded;
          },
        );
        if (isExpanded == true && widget.data.viewed == false) {
          setState(() {
            isViewed = true;
            feedBack.sendFeedBack('notification', widget.data.id);
          });
        } else {
          setState(() {
            isViewed = false;
          });
        }
      },
      children: _data.map<ExpansionPanel>(
        (Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Stack(
                children: [
                  widget.data.viewed
                      ? const SizedBox()
                      : Positioned(
                          top: 1,
                          right: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: ThemeApplication.lightTheme.warningColor,
                                borderRadius: BorderRadius.circular(24)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'New',
                                style: commonTextNotification,
                              ),
                            ),
                          ),
                        ),
                  ListTile(
                    title: Text(
                      ' ${widget.data.client} requesting for a ${widget.data.serviceTitle}',
                      style: headlineTile,
                    ),
                    subtitle: Text(
                      widget.data.clientNumber,
                      style: headline2Detail,
                    ),
                  ),
                ],
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
                        'https://eventend.pythonanywhere.com${widget.data.clientProfilePicture}',
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
                      widget.data.clientNumber,
                      style: headline2Detail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: commonTextMain,
                    ),
                  ),
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

  confirmView() async {}
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
