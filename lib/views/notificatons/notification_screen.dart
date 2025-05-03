import 'package:charity_app/consts/colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {

  final List<Map<String, String>> notifications = [
    {
      "title": "Personal Support Approved",
      "subtitle": "Your Personal Support request has been approved!",
      "time": "5 min ago",
      "status": "approved",
    },
    {
      "title": "Ramadan Package Approved",
      "subtitle": "Your Ramadan Package is now live for donations.",
      "time": "Today",
      "status": "approved",
    },
    {
      "title": "Eid Package Approved",
      "subtitle": "Your Eid Festival Package has been approved successfully.",
      "time": "Yesterday",
      "status": "approved",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Mark all as read functionality
            },
            child: const Text(
              'Mark all as read',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  Icons.check_circle_outline,
                  color: greenColor,
                ),
              ),
              title: Text(
                notification["title"] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notification["subtitle"] ?? ''),
              trailing: Text(
                notification["time"] ?? '',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              onTap: () {
                // TODO: Handle tap if needed
              },
            ),
          );
        },
      ),
    );
  }
}