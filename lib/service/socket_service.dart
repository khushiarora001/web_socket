// websocket_service.dart

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class WebSocketService {
  late WebSocket _socket;
  late StreamController<Map<String, dynamic>> _controller;

  final String socketUrl;

  WebSocketService({required this.socketUrl}) {
    _controller = StreamController<Map<String, dynamic>>.broadcast();
  }

  // Connect to the WebSocket
  Future<void> connect() async {
    try {
      _socket = await WebSocket.connect(socketUrl);
      print('Connected to WebSocket: $socketUrl');

      // Listen for messages from the server
      _socket.listen((data) {
        final decodedData = json.decode(data);
        _controller
            .add(decodedData); // Add incoming data to the stream controller
      }, onError: (error) {
        _controller.addError(error); // Add error to the stream
      }, onDone: () {
        _controller.close(); // Close the stream when the connection is done
      });
    } catch (e) {
      print('Error connecting to WebSocket: $e');
      _controller.addError(e);
    }
  }

  // Send a message to the WebSocket server
  void sendMessage(Map<String, dynamic> message) {
    if (_socket != null && _socket.readyState == WebSocket.open) {
      _socket.add(
          json.encode(message)); // Send the message to the WebSocket server
    } else {
      print('WebSocket is not open.');
    }
  }

  // Expose the stream to listen for incoming messages
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  // Close the WebSocket connection
  void close() {
    _socket.close();
    _controller.close();
  }
}
