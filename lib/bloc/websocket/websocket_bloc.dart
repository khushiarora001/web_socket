import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_assetment/bloc/websocket/websocket_event.dart';
import 'package:web_socket_assetment/bloc/websocket/websocket_state.dart';
import 'package:web_socket_assetment/models/order_book_model.dart';

import 'package:web_socket_assetment/service/socket_service.dart';

class WebSocketBloc extends Bloc<WebBlocEvent, WebSocketState> {
  final WebSocketService
      webSocketService; // WebSocket service for managing connections

  WebSocketBloc({required this.webSocketService}) : super(OrderInitial()) {
    on<OrderErrorEvent>(_onOrderErrorEvent);

    // Listening to the WebSocket stream and adding events accordingly
    webSocketService.stream.listen(
      (message) {
        try {
          // Parse the WebSocket message to OrderBookModel
          final OrderBookModel orderBookData = OrderBookModel.fromJson(message);
          final orderBookDataMap = orderBookData.toMap();

          add(UpdateOrderBookEvent(
            key: 'orderbook_update',
            data: orderBookDataMap,
          ));
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

  // Handling OrderErrorEvent
  void _onOrderErrorEvent(OrderErrorEvent event, Emitter<WebSocketState> emit) {
    emit(WebSocketError(event.error));
  }
}
