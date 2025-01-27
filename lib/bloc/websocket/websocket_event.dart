import 'package:web_socket_assetment/models/order_book_model.dart';

abstract class OrderEvent {}

class UpdateOrderBookEvent extends OrderEvent {
  final OrderBookModel orderBookData;

  UpdateOrderBookEvent(this.orderBookData);
}

class OrderErrorEvent extends OrderEvent {
  final String error;

  OrderErrorEvent(this.error);
}
