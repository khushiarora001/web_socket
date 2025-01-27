# WebSocket Assessment Application

This project is a Flutter-based application that showcases the use of WebSocket connections to create a real-time order book, event list, and authentication system. It leverages Flutter's Bloc architecture to manage state efficiently.

Features

1. Real-Time Order Book

Fetches live data through WebSocket.

Displays the updated order book as new data arrives.

2. Event List Management

Displays a list of events fetched from an external API.

Allows easy navigation and interaction.

3. Authentication System

Handles user authentication using a repository pattern.

Integrates securely with backend APIs.

Project Structure

The application is structured as follows:

1. Bloc

AuthBloc: Manages authentication state.

EventsBloc: Handles state related to the event list.

OrderBloc: Manages state for the real-time order book.

WebSocketBloc: Handles WebSocket connections and interactions.

2. Repositories

AuthRepository: Handles authentication-related API calls.

EventRepository: Manages fetching events from the server.

OrderRepository: Provides backend integration for order data.

3. Services

WebSocketService: Provides WebSocket connection management.

4. Constants

Application-wide constants are defined in constants.dart.

5. Routes

AppRouter: Manages navigation using GoRouter.

# Getting Started

Prerequisites

Flutter SDK

Dart SDK

WebSocket server URL (replace in WebSocketService constructor).

Installation

Clone the repository:

git clone https://github.com/khushiarora001/web_socket

# Navigate to the project directory:

cd websocket-assessment

Install dependencies:

flutter pub get

Run the application:

flutter run

Usage

1. Replace WebSocket URL

Update the WebSocket URL in the WebSocketService constructor:

final webSocketService = WebSocketService(socketUrl: 'ws://your-websocket-url');

2. Run the Application

Use flutter run to start the app.

Explore real-time updates in the order book, view events, and authenticate users.

Technologies Used

Flutter: UI framework for building natively compiled applications.

Dart: Programming language used by Flutter.

Bloc: State management library.

WebSocket: Protocol for real-time communication.

Contribution

We welcome contributions! To contribute:

Fork the repository.

Create a feature branch.

Commit your changes.

Create a pull request.

License

This project is licensed under the MIT License. See the LICENSE file for details.