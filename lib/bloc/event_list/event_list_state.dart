import 'package:web_socket_assetment/models/event_model.dart';
// Link to the events_bloc.dart file

// Define the base class for Events State

abstract class EventsState {}

// Initial state before any events are fetched
class EventsInitial extends EventsState {}

// Loading state when events are being fetched
class EventsLoading extends EventsState {}

// State for when events have been successfully loaded
class EventsLoaded extends EventsState {
  final List<EventModel> events;

  EventsLoaded(this.events);
}

// State for when there is an error fetching events
class EventsError extends EventsState {
  final String message;

  EventsError(this.message);
}
