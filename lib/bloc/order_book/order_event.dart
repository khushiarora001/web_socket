// order_event.dart

abstract class OrderEvent {}

class PlaceOrderEvent extends OrderEvent {
  final String eventId;
  final String type;
  final int quantity;
  final double price;

  PlaceOrderEvent({
    required this.eventId,
    required this.type,
    required this.quantity,
    required this.price,
  });

  // Optional: Override equality manually if needed
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlaceOrderEvent &&
        other.eventId == eventId &&
        other.type == type &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode =>
      eventId.hashCode ^ type.hashCode ^ quantity.hashCode ^ price.hashCode;
}
