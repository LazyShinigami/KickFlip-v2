import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/firebase/notificationHandler.dart';
import 'package:kickflip/models.dart';
import 'package:kickflip/screens/commonElements/appbar.dart';
import 'package:kickflip/screens/commonElements/bottomNavBar.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key, required this.user});

  final KFUser user;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final String email = 'hello@world.com';

  late Stream<List<S_NotificationItem>> _notificationStream;

  @override
  void initState() {
    super.initState();
    _notificationStream = NotificationHandler().viewNotifications(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KickFlipAppBar(showLeading: true),
      body: StreamBuilder<List<S_NotificationItem>>(
        stream: NotificationHandler().viewNotifications(email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('--------------------> ${snapshot.error}');
            return Center(
              child: MyText('Error! Restart the app'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: MyText('You have no notifications'),
            );
          } else {
            List<S_NotificationItem> notifications = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: MyText(
                      'Your Notifications',
                      weight: FontWeight.bold,
                      spacing: 2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (int i = 0; i < notifications.length; i++)
                    NotificationElement(item: notifications[i]),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 3, user: widget.user, accountType: 'seller'),
    );
  }
}

class NotificationElement extends StatelessWidget {
  const NotificationElement({super.key, required this.item});
  final S_NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      child: Stack(
        children: [
          GestureDetector(
            onLongPress: () {
              print('Edit notification');
            },
            child: Container(
              height: 70,
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ThemeColors().light,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(item.title, weight: FontWeight.w500, spacing: 0.5),
                      // date and time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyText(
                            item.time,
                            size: 11,
                            weight: FontWeight.w500,
                          ),
                          MyText(
                            // 06 Apr, 23 gets turned into 06 Apr
                            item.date.substring(0, 6),
                            size: 13,
                            weight: FontWeight.w500,
                          ),
                        ],
                      )
                    ],
                  ),
                  MyText(
                    item.msg,
                    size: 14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    spacing: 0.5,
                  ),
                ],
              ),
            ),
          ),
          if (!item.read)
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
              height: 70,
              width: 10,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.grey),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
