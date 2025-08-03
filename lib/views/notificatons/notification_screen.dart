import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:charity_app/views/donation/donation_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../home_screens/home_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
        backgroundColor: yellowColor,
        title: ourText(color: whiteColor, title: notification, textSize: 22),
        actions: [
          TextButton(
            onPressed: () async {
              final snapshots = await FirebaseFirestore.instance
                  .collection('notifications')
                  .where('isRead', isEqualTo: false)
                  .get();

              for (var doc in snapshots.docs) {
                await doc.reference.update({'isRead': true});
              }
            },
            child: ourText(
              color: yellowColor,
              title: 'Mark all as read',
              textSize: 10,
            ),
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

          if (notifications.isEmpty) {
            return const Center(child: Text(no_notifications_found));
          }

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
                    // Mark as read
                    if (notifications[index]['isRead'] == false) {
                      await notifications[index].reference.update({'isRead': true});
                    }

                    // Navigate to campaign
                    final donationId = data['donationId'];
                    if (donationId != null && donationId.toString().isNotEmpty) {
                      final doc = await FirebaseFirestore.instance
                          .collection('donation_compaigns')
                          .doc(donationId)
                          .get();

                      if (doc.exists) {
                        final campaignData = doc.data()!;
                        Get.to(()=>DonationDetailsScreen(campaign: DonationCampaignModel.fromMap(campaignData, doc.id)));


                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(

                          const SnackBar(content: Text('Campaign not found')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No campaign ID found')),
                      );
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
                  subtitle: Text(data['subtitle'] ?? 'No description'),
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
