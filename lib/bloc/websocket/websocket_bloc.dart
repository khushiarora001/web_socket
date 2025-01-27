import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_assetment/bloc/websocket/websocket_event.dart';
import 'package:web_socket_assetment/bloc/websocket/websocket_state.dart';
import 'package:web_socket_assetment/models/order_book_model.dart';

import 'package:web_socket_assetment/service/socket_service.dart';

class WebSocketBloc extends Bloc<OrderEvent, WebSocketState> {
  final WebSocketService
      webSocketService; // WebSocket service for managing connections

  WebSocketBloc({required this.webSocketService}) : super(OrderInitial()) {
    on<UpdateOrderBookEvent>(_onUpdateOrderBookEvent);
    on<OrderErrorEvent>(_onOrderErrorEvent);

    // Listening to the WebSocket stream and adding events accordingly
    webSocketService.stream.listen(
      (message) {
        try {
          // Parse the WebSocket message to OrderBookModel
          final OrderBookModel orderBookData = OrderBookModel.fromJson(message);
          add(UpdateOrderBookEvent(orderBookData));
        } catch (e) {
          // Emit an error event if parsing fails
          add(OrderErrorEvent(e.toString()));
        }
      },
      onError: (error) {
        // Emit an error event if WebSocket fails
        add(OrderErrorEvent(error.toString()));
      },
    );
  }

  // Handling UpdateOrderBookEvent
  void _onUpdateOrderBookEvent(
      UpdateOrderBookEvent event, Emitter<WebSocketState> emit) {
    emit(OrderBookUpdated(event.orderBookData));
  }

  // Handling OrderErrorEvent
  void _onOrderErrorEvent(OrderErrorEvent event, Emitter<WebSocketState> emit) {
    emit(WebSocketError(event.error));
  }
}
