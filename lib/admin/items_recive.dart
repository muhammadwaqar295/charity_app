import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charity_app/consts/consts.dart';

class ItemsRecive extends StatelessWidget {
  const ItemsRecive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ourText(color: whiteColor, title: allDonationItems, textSize: 21),
        backgroundColor: yellowColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('itemsDonation')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Empty state
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text(Nodonationsfound));
          }

          // Data exists
          final donationDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: donationDocs.length,
            itemBuilder: (context, index) {
              final data = donationDocs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title:ourText(color: blackColor, title: data['title'] ?? 'No title', textSize: 14),
                    //Text(),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),


             ourText(color: blackColor, title: "Type: ${data['type'] ?? 'N/A'}", textSize: 12),
             ourText(color: blackColor, title: "Time: ${data['availabilityTime'] ?? 'N/A'}", textSize: 12),
             ourText(color: blackColor, title: "Address: ${data['address'] ?? 'N/A'}", textSize: 12),
             ourText(color: blackColor, title: "Description: ${data['description'] ?? 'N/A'}", textSize: 12),


                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
