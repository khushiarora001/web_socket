class EventsList {
  final List<EventModel> events;

  EventsList({required this.events});

  /// Factory method to parse JSON into an EventsList object
  factory EventsList.fromJson(List<dynamic> jsonList) {
    return EventsList(
      events: jsonList
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final num price;
  final String icon;
  final String eventStatus;
  final String eventExpiresOn;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.price,
    required this.eventStatus,
    required this.eventExpiresOn,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['eventRules'] ?? '',
      price: json['currentYesPrice'] ?? 0.0,
      icon: json['icons'] ?? '',
      eventStatus: json['eventStatus'] ?? '',
      eventExpiresOn: json['eventExpiresOn'] ?? '',
    );
  }
}
