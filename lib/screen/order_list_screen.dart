import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/websocket/websocket_bloc.dart';
import '../bloc/websocket/websocket_state.dart';

class OrderBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Book")),
      body: BlocBuilder<WebSocketBloc, WebSocketState>(
        builder: (context, state) {
          if (state is WebSocketLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is WebSocketError) {
            return Center(child: Text(state.message));
          }
          if (state is WebSocketSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final order = state.data[index];
                return ListTile(
                  title: Text(order['name']),
                  subtitle: Text('Quantity: ${order['quantity']}'),
                );
              },
            );
          }
          return Center(child: Text("No Orders"));
        },
      ),
    );
  }
}
