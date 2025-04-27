
class EventModel {
  final String title;
  final String date;
  final String imagePath;
  final String details;

  EventModel({
    required this.title,
    required this.date,
    required this.imagePath,
    required this.details,
  });
}
/*

List<EventModel> events = snapshot.docs.map((doc) => EventModel(
  title: doc['title'],
  date: doc['date'],
  imagePath: doc['imagePath'], // Maybe url
  details: doc['details'],
)).toList();
*/
