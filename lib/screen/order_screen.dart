import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_assetment/bloc/order_book/order_bloc.dart';
import 'package:web_socket_assetment/bloc/order_book/order_event.dart';
import 'package:web_socket_assetment/bloc/order_book/order_state.dart';
import 'package:web_socket_assetment/bloc/websocket/websocket_bloc.dart';
import 'package:web_socket_assetment/bloc/websocket/websocket_event.dart';

// ignore: must_be_immutable
class OrderScreen extends StatelessWidget {
  final String eventId;
  Map<String, dynamic>? extra;
  OrderScreen({super.key, required this.extra, required this.eventId});

  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access extra data from the router
    final String description = extra!['description'] ?? '';
    final num price = extra!['price'] ?? 0.0;

    String truncateDescription(String description, int wordLimit) {
      final words = description.split(' ');
      if (words.length <= wordLimit) {
        return description;
      }
      return '${words.sublist(0, wordLimit).join(' ')}...';
    }

    return Scaffold(
      appBar: AppBar(title: Text('Place Order')),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Order placed successfully')));
            context.pushReplacementNamed('order-book');
          } else if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Place Order',
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Event ID: $eventId',
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Description: ${truncateDescription(description, 20)}',
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Price: \$${price.toStringAsFixed(2)}',
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          final quantity =
                              int.tryParse(quantityController.text) ?? 0;
                          if (quantity <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Please enter a valid quantity')));
                            return;
                          }
                          context.read<WebSocketBloc>().add(
                                UpdateOrderBookEvent(
                                  key: 'orderbook_update',
                                  data: {'eventId': eventId},
                                ),
                              );
                          context.read<OrderBloc>().add(
                                PlaceOrderEvent(
                                  eventId: eventId,
                                  type: 'yes',
                                  quantity: quantity,
                                  price: price,
                                ),
                              );
                        },
                        child: Text('Place Order'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
