class EventModel {
  final String title;
  final String date;
  final String details;
  final List<String> imageUrls;

  EventModel({
    required this.title,
    required this.date,
    required this.details,
    required this.imageUrls,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      title: map['title'] ?? '',
      date: map['created_date'] ?? '',
      details: map['des'] ?? '',
      imageUrls: List<String>.from(map['images'] ?? []),
    );
  }
}
