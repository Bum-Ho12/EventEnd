import 'package:eventend/widgets/notification_expansion_widget.dart';
import 'package:flutter/material.dart';
import '../../utilities/personalization.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
      body: Center(
        child: ListView(
          children: [
            SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.05
                        : 20),
            const NotificationExpansionWidget(),
          ],
        ),
      ),
    );
  }
}
