class EventModel {
  final String id;
  final String name;
  final String description;
  final DateTime date;

  EventModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.date});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
