// order_state.dart

import 'package:web_socket_assetment/models/order_book_model.dart';

abstract class WebSocketState {}

class OrderInitial extends WebSocketState {}

class WebSocketLoading extends WebSocketState {}

class WebSocketSuccess extends WebSocketState {
  final List<Map<String, dynamic>> data;

  WebSocketSuccess(this.data);
}

class WebSocketError extends WebSocketState {
  final String message;

  WebSocketError(this.message);
}

class OrderBookUpdated extends WebSocketState {
  final OrderBookModel orderBookData;

  OrderBookUpdated(this.orderBookData);
}
