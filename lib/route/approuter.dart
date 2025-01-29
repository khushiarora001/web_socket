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
        path: '/order/:id',
        name: 'order',
        builder: (context, state) {
          final eventId = state.pathParameters['id'] ?? '';
          final extra = state.extra as Map<String, dynamic>?;
          return OrderScreen(eventId: eventId, extra: extra);
        },
      ),
      GoRoute(
        path: '/order-book',
        name: 'order-book',
        builder: (context, state) => OrderBookPage(),
      ),
    ],
  );
}
