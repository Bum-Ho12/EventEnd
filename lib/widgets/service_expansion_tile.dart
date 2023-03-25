import 'package:eventend/classes/service_class.dart';
import 'package:eventend/network_services/delete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../forms/service_put_form.dart';
import '../network_services/update_list_provider.dart';
import '../providers/get_service_posts_provider.dart';
import '../providers/service_create_provider.dart';
import '../utilities/personalization.dart';

class ServiceExpansionWidget extends StatefulWidget {
  final Service data;
  final int index;
  const ServiceExpansionWidget(
      {required this.data, required this.index, super.key});

  @override
  State<ServiceExpansionWidget> createState() => _ServiceExpansionWidgetState();
}

class _ServiceExpansionWidgetState extends State<ServiceExpansionWidget> {
  final List<Item> _data = generatedItems(1);
  Delete delete = Delete();

  Widget _buildPanel() {
    final ServiceCreateProvider serviceAssignProvider =
        Provider.of<ServiceCreateProvider>(context);
    final GetServicePostsProvider concertProvider =
        Provider.of<GetServicePostsProvider>(context);
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
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            serviceAssignProvider.setTitle(widget.data.title);
                            double newPrice = double.parse(widget.data.price);
                            serviceAssignProvider.setPrice(newPrice.round());
                            serviceAssignProvider
                                .setWebLink(widget.data.webLink);
                            serviceAssignProvider
                                .setDescription(widget.data.description);
                          });
                          Navigator.push(
                            context,
                            SlideRightRoute(
                              page: UpdateService(
                                id: widget.data.id.toString(),
                                permit: widget.data.permit,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'Update',
                              style: headlineTile,
                            ),
                            Icon(
                              Icons.edit,
                              size: 30,
                              color:
                                  ThemeApplication.lightTheme.backgroundColor2,
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await value.deleteItem(
                              widget.data.id, 'service', context);
                          if (value.isDeleted == true) {
                            setState(() {
                              concertProvider.updateList(widget.index);
                            });
                          }
                        },
                        color: ThemeApplication.lightTheme.warningColor,
                        child: Text(
                          'Decommission',
                          style: headline2Profile,
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
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
    return Item(
        headerValue: 'Ticket for Develop Concert $index',
        expandedValue: 'This is Item number $index');
  });
}
