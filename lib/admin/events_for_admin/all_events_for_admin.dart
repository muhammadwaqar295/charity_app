import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:charity_app/consts/consts.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import '../../views/events/components/event_model.dart';
import 'add_events_screen.dart';
import 'edit_events_screen.dart';

class AllEventsForAdmin extends StatelessWidget {
  const AllEventsForAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowColor,
        centerTitle: true,
        title: ourText(color: whiteColor, title: eventss, textSize: 22),

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
            data['id'] = doc.id; // ensure document ID is used
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


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddEventsScreen());
        },
        backgroundColor: yellowColor,
        child: const Icon(Icons.add,color: whiteColor,),
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
          // Navigate to detail screen (optional)
          // Get.to(() => EventDetailScreen(event: event));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: yellowColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      event.imageUrls.isNotEmpty
                          ? event.imageUrls[0]
                          : 'https://via.placeholder.com/200',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                  // Popup Menu for edit/delete
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == edit) {
                        // TODO: Navigate to EditEventScreen
                         Get.to(() => EditEventScreen(event: event));
                      } else if (value == delete) {
                        _deleteEvent(context);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: edit,
                          child: Text(edit),
                        ),
                        const PopupMenuItem(
                          value: delete,
                          child: Text(delete),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: ourText(color: blackColor, title: event.title, textSize: 16),
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

  void _deleteEvent(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('events').doc(event.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(eventdeletedsuccessfully)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete event: $e')),
      );
    }
  }
}
