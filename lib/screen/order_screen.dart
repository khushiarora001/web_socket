import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_assetment/bloc/order_book/order_bloc.dart';
import 'package:web_socket_assetment/bloc/order_book/order_event.dart';
import 'package:web_socket_assetment/bloc/order_book/order_state.dart';

class OrderScreen extends StatelessWidget {
  final String eventId;

  OrderScreen({super.key, required this.eventId});

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Place Order')),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Order placed successfully')));
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
            child: Column(
              children: [
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final quantity = int.parse(quantityController.text);
                    final price = double.parse(priceController.text);
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
              ],
            ),
          );
        },
      ),
    );
  }
}
