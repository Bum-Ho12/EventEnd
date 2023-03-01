import 'package:flutter/material.dart';

import '../utilities/personalization.dart';

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({super.key});

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  final List<Item> _data = generatedItems(4);

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
                  item.headerValue!,
                  style: headlineTile,
                ),
                subtitle: Text('Location: 13th Street Avenue, Nairobi',
                    style: commonTextMain),
              );
            },
            body: ListTile(
              title: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/band.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              subtitle: Column(
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consenter advising elite, sed do elusion '
                    'tempore incident ut laborer et dolores magna aliquant. Ut enid ad minim venial, '
                    'quia nostrum exercitation ullages labors nisi ut aliquot ex ea commode consequent.',
                    style: commonTextMain,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.receipt,
                      color: ThemeApplication.lightTheme.backgroundColor2
                          .withOpacity(0.7),
                    ),
                    title: Text(
                      'Ksh. 141.95',
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
                      'Website or portfolio',
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
                          '129',
                          style: headline2Detail,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                        child: Text(
                          'Tickets: ',
                          style: headline1detail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 8, bottom: 8),
                        child: Text(
                          '100',
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
