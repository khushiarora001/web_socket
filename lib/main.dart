import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_assetment/bloc/auth/auth_bloc.dart';
import 'package:web_socket_assetment/bloc/event_list/event_list_bloc.dart';
import 'package:web_socket_assetment/bloc/order_book/order_bloc.dart';
import 'package:web_socket_assetment/bloc/websocket/websocket_bloc.dart';
import 'package:web_socket_assetment/constant/api_constant.dart';
import 'package:web_socket_assetment/constant/constant.dart';
import 'package:web_socket_assetment/repositories/auth_repository.dart';
import 'package:web_socket_assetment/repositories/event_repository.dart';
import 'package:web_socket_assetment/repositories/order_repository.dart';
import 'package:web_socket_assetment/route/approuter.dart';
import 'package:web_socket_assetment/service/socket_service.dart';
import 'package:web_socket_assetment/utils/data_source/api_service.dart';

void main() {
  // Initialize WebSocket Service
  final webSocketService = WebSocketService(socketUrl: webSocketUrl);

  runApp(
    MultiBlocProvider(
      providers: [
        // Provide AuthBloc with its repository
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),

        // Provide EventsBloc with its repository
        BlocProvider(create: (_) => EventsBloc(EventRepository())),

        // Provide OrderBloc with its repository
        BlocProvider(create: (_) => OrderBloc(OrderRepository())),

        // Provide WebSocketBloc with the WebSocketService instance
        BlocProvider(
          create: (_) => WebSocketBloc(webSocketService: webSocketService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.eventApp, // Use a constant title
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          prefixIconColor: Colors.blueAccent,
          labelStyle: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 29),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      routerConfig: AppRouter.router, // GoRouter configuration
    );
  }
}
