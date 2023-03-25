import 'package:eventend/classes/concert_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../network_services/update_list_provider.dart';
import '../utilities/personalization.dart';

class PastExpansionWidget extends StatefulWidget {
  final Concert data;
  final int index;
  const PastExpansionWidget({required this.data, required this.index, super.key});

  @override
  State<PastExpansionWidget> createState() => _PastExpansionWidgetState();
}

class _PastExpansionWidgetState extends State<PastExpansionWidget> {
  final List<Item> _data = generatedItems(1);

  Widget _buildPanel() {
    return Consumer<UpdateListProvider>(builder: (context, value, child) {
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
                );
              },
              body: ListTile(
                title: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://eventend.pythonanywhere.com${widget.data.concertPicture}',
                    fit: BoxFit.fill,
                    height: 100,
                    width: 150,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: Text('Loading...'));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Error Loading the image!'),
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
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, bottom: 8),
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, bottom: 8),
                          child: Text(
                            'Tickets: ',
                            style: headline1detail,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 8, bottom: 8),
                          child: Text(
                            widget.data.tickets.toString(),
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
    });
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
    return Item(headerValue: '', expandedValue: 'This is Item number $index');
  });
}
