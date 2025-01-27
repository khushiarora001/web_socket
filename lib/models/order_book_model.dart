// order_book_model.dart

class OrderBookModel {
  final List<Order> orders;

  OrderBookModel({required this.orders});

  factory OrderBookModel.fromJson(Map<String, dynamic> json) {
    return OrderBookModel(
      orders: (json['orders'] as List)
          .map((order) => Order.fromJson(order))
          .toList(),
    );
  }
}

class Order {
  final String orderId;
  final String type;
  final int quantity;
  final double price;

  Order({
    required this.orderId,
    required this.type,
    required this.quantity,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      type: json['type'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
