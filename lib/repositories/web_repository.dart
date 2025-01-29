// order_repository.dart

import 'package:web_socket_assetment/models/order_book_model.dart';
import 'package:web_socket_assetment/service/socket_service.dart';

class WebRepository {
  final WebSocketService webSocketService;

  WebRepository({required this.webSocketService});

  // Method to listen for WebSocket messages and update the order book
  Stream<OrderBookModel> getOrderBookUpdates() {
    return webSocketService.stream.map((data) {
      return OrderBookModel.fromJson(
          data); // Map incoming data to OrderBookModel
    });
  }

  // Send a message (or order data) to the WebSocket server
  void sendOrderMessage(Map<String, dynamic> message) {
    webSocketService.sendMessage(message);
  }
}
