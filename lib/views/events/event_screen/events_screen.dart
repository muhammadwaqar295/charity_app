import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import '../components/event_model.dart';
import 'events_details_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ourText(color: blackColor, title: eventss, textSize: 17),
        leading: ourBackButton(context),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('events')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text(no_events_found));
          }

          final docs = snapshot.data!.docs;

          final List<EventModel> events = docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            data['id'] = doc.id; // inject the ID
            return EventModel.fromMap(data);
          }).toList();

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(event: events[index]);
            },
          );
        },
      ),
    );
  }
}
class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => EventDetailScreen(event: event));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: yellowColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  event.imageUrls.isNotEmpty
                      ? event.imageUrls[0]
                      : 'https://via.placeholder.com/200',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: ourText(
                    color: blackColor, title: event.title, textSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 12),
                child: ourText(
                  color: blackColor,
                  title: event.date,
                  textSize: 14,
                  bgColor: yellowColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
