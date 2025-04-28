import 'package:charity_app/consts/images.dart';
import 'package:charity_app/reusable_widgets/our_back_button.dart';
import 'package:charity_app/reusable_widgets/our_text.dart';
import 'package:get/get.dart';
import '../../../consts/consts.dart';
import '../components/event_model.dart';
import 'events_details_screen.dart';





class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //array
    List<EventModel> events = [
      EventModel(
        title: ramazanPackage,
        date: date,
        imagePath: imgRamazanPackage,
        details: ramazanPackageDetails
      ),
      EventModel(
        title: eidPackage,
        date: date,
        imagePath: imgEidPackage,
        details: ramazanPackageDetails,
      ),
      EventModel(
          title: ramazanPackage,
          date: date,
          imagePath: imgRamazanPackage,
          details: ramazanPackageDetails
      ),
      EventModel(
        title: eidPackage,
        date: date,
        imagePath: imgEidPackage,
        details: ramazanPackageDetails,
      ),
      EventModel(
          title: ramazanPackage,
          date: date,
          imagePath: imgRamazanPackage,
          details: ramazanPackageDetails
      ),
      EventModel(
        title: eidPackage,
        date: date,
        imagePath: imgEidPackage,
        details: ramazanPackageDetails,
      ),
      EventModel(
          title: ramazanPackage,
          date: date,
          imagePath: imgRamazanPackage,
          details: ramazanPackageDetails
      ),
    ];


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ourText(color: blackColor, title: eventss, textSize: 17),
        leading: ourBackButton(context)
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(event: events[index]);
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
          Get.to(()=>EventDetailScreen(event: event));
        },

        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: yellowColor, width: 1),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  event.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),

                child: ourText(color: blackColor, title: event.title, textSize: 16)
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child:     ourText(color: blackColor, title: event.date, textSize: 14,bgColor: yellowColor)

              ),
            ],
          ),
        ),
      ),
    );
  }
}




