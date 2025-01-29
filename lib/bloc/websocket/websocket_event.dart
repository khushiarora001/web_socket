import 'package:web_socket_assetment/models/order_book_model.dart';

abstract class WebBlocEvent {}

class UpdateOrderBookEvent extends WebBlocEvent {
  final String key;
  final Map<String, dynamic> data;

  UpdateOrderBookEvent({required this.key, required this.data});
}

class OrderErrorEvent extends WebBlocEvent {
  final String error;

  OrderErrorEvent(this.error);
}
