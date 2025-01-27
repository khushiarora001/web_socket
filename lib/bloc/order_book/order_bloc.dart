import 'package:bloc/bloc.dart';
import 'package:web_socket_assetment/bloc/order_book/order_event.dart';
import 'package:web_socket_assetment/bloc/order_book/order_state.dart';

import 'package:web_socket_assetment/repositories/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc(this.orderRepository) : super(OrderInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await orderRepository.placeOrder(
          event.eventId,
          event.type,
          event.quantity,
          event.price,
        );
        emit(OrderSuccess());
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });
  }
}
