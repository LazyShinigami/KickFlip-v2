import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/models.dart';

class NotificationHandler {
  final _store = FirebaseFirestore.instance.collection('NotificationDB');

  // Create
  generateNotif() {}

  // View
  Stream<List<S_NotificationItem>> viewNotifications(String email) {
    return _store.doc(email).snapshots().map((snapshot) {
      List<S_NotificationItem> notifications = [];
      if (snapshot.exists) {
        List<dynamic> rawData = snapshot.get('sNotif');
        notifications = rawData.map((data) {
          return S_NotificationItem(
            uID: data['uID'],
            category: data['category'],
            title: data['title'],
            msg: data['msg'],
            read: data['read'],
            date: data['date'],
            time: data['time'],
          );
        }).toList();
      }
      DateTimeClass().sortNotifications(notifications);
      return notifications;
    });
  }

  // Delete

  // Update: mark as read

  // View - just get the pID if applicable
}
