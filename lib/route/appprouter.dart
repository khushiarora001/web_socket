import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_assetment/screen/event_screen.dart';
import 'package:web_socket_assetment/screen/login_screen.dart';
import 'package:web_socket_assetment/screen/order_list_screen.dart';
import 'package:web_socket_assetment/screen/order_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => EventsScreen(),
      ),
      GoRoute(
        path: '/order',
        builder: (context, state) {
          final eventId = state.pathParameters['eventId'] ?? "2";
          return OrderScreen(eventId: eventId);
        },
      ),
      GoRoute(
        path: '/order-book',
        builder: (context, state) => OrderBookPage(),
      ),
    ],
  );
}
