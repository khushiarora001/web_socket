class Order {
  String userId;
  String eventId;
  double price;
  int quantity;
  String type;
  bool isExited;
  String status;
  int pendingQuantity;
  int matchedQuantity;
  int cancelledQuantity;
  int exitingQuantity;
  int exitedQuantity;
  int refundedAmount;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int orderNumber;
  String orderSequence;
  int version;

  Order({
    required this.userId,
    required this.eventId,
    required this.price,
    required this.quantity,
    required this.type,
    required this.isExited,
    required this.status,
    required this.pendingQuantity,
    required this.matchedQuantity,
    required this.cancelledQuantity,
    required this.exitingQuantity,
    required this.exitedQuantity,
    required this.refundedAmount,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.orderSequence,
    required this.version,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userId: json['userId'],
      eventId: json['eventId'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      type: json['type'],
      isExited: json['isExited'],
      status: json['status'],
      pendingQuantity: json['pendingQuantity'],
      matchedQuantity: json['matchedQuantity'],
      cancelledQuantity: json['cancelledQuantity'],
      exitingQuantity: json['exitingQuantity'],
      exitedQuantity: json['exitedQuantity'],
      refundedAmount: json['refundedAmount'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      orderNumber: json['orderNumber'],
      orderSequence: json['order_sequence'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'eventId': eventId,
      'price': price,
      'quantity': quantity,
      'type': type,
      'isExited': isExited,
      'status': status,
      'pendingQuantity': pendingQuantity,
      'matchedQuantity': matchedQuantity,
      'cancelledQuantity': cancelledQuantity,
      'exitingQuantity': exitingQuantity,
      'exitedQuantity': exitedQuantity,
      'refundedAmount': refundedAmount,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'orderNumber': orderNumber,
      'order_sequence': orderSequence,
      '__v': version,
    };
  }
}
