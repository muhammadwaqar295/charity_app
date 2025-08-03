import 'package:charity_app/consts/colors.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () async {
              // Mark all as read
              final snapshots = await FirebaseFirestore.instance
                  .collection('notifications')
                  .where('isRead', isEqualTo: false)
                  .get();

              for (var doc in snapshots.docs) {
                await doc.reference.update({'isRead': true});
              }
            },
            child:
            ourText(color: whiteColor, title: 'Mark all as read', textSize: 10)
          /*  const Text(
              'Mark all as read',
              style: TextStyle(color: Colors.white),
            ),*/
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final data = notifications[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  onTap: () async {
                    if (notifications[index]['isRead'] == false) {
                      await notifications[index].reference.update({'isRead': true});
                    }
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: greenColor,
                    ),
                  ),
                  title: Text(data['title'] ?? ''),
                  subtitle: Text(data['subtitle'] ?? ''),
                  trailing: Text(
                    formatTimeAgo(data['time']),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

              );
            },
          );
        },
      ),
    );
  }




  String formatTimeAgo(Timestamp timestamp) {
    final date = timestamp.toDate();
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return '${diff.inDays} days ago';
  }

}