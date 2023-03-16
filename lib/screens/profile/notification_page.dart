import 'package:eventend/providers/notification_provider.dart';
import 'package:eventend/widgets/notification_expansion_widget.dart';
import 'package:eventend/widgets/update_expansion_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/personalization.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Future<void> initializeProviders() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RequestsProvider>(context, listen: false).getAllConcerts();
    });
  }

  bool? _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: pageTitle),
        backgroundColor: ThemeApplication.lightTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ThemeApplication.lightTheme.backgroundColor2,
          ),
        ),
      ),
      body: FutureBuilder(
          future: initializeProviders(),
          builder: (context, _) {
            return Center(
              child:
                  Consumer<RequestsProvider>(builder: (context, value, child) {
                return value.requests.isEmpty
                    ? FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            _isLoading = false;
                          });
                        }),
                        builder: (context, _) {
                          return _isLoading == true
                              ? CircularProgressIndicator(
                                  color: ThemeApplication
                                      .lightTheme.backgroundColor2,
                                )
                              : Text('No notifications present',
                                  style: headline2Detail);
                        })
                    : ListView(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.05
                                  : 20),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.isLoading == false
                                ? value.requests.length
                                : 2,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return value.isLoading
                                  ? const UpdateShimmer()
                                  : NotificationExpansionWidget(
                                      data: value.requests[index]);
                            },
                          ),
                        ],
                      );
              }),
            );
          }),
    );
  }
}
