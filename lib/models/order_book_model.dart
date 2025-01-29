class OrderBookModel {
  final List<Order> orders;

  OrderBookModel({required this.orders});

  // Method to convert OrderBookModel to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'orders': orders.map((order) => order.toMap()).toList(),
    };
  }

  // Method to create an OrderBookModel from a JSON object
  factory OrderBookModel.fromJson(Map<String, dynamic> json) {
    return OrderBookModel(
      orders: List<Order>.from(
          json['orders'].map((orderJson) => Order.fromJson(orderJson))),
    );
  }
}

class Order {
  final String name;
  final int quantity;

  Order({required this.name, required this.quantity});

  // Method to convert Order to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }

  // Method to create an Order from a JSON object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}
