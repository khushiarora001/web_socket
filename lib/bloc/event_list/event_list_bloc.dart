import 'package:bloc/bloc.dart';
import 'package:web_socket_assetment/bloc/event_list/event_list_event.dart';
import 'package:web_socket_assetment/bloc/event_list/event_list_state.dart';

import 'package:web_socket_assetment/repositories/event_repository.dart';
import 'package:web_socket_assetment/utils/api_utils/api_status.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventRepository eventRepository;

  EventsBloc(this.eventRepository) : super(EventsInitial()) {
    // In EventsBloc
    on<FetchEventsEvent>((event, emit) async {
      emit(EventsLoading()); // Emitting loading state
      try {
        final response = await eventRepository.fetchEvents();

        if (response.apiStatus == ApiStatus.REQUEST_SUCCESS) {
          emit(EventsLoaded(
              response.data!)); // Use response.data when successful
        } else {
          emit(EventsError(
              response.message!)); // Use response.message in case of error
        }
      } catch (e) {
        emit(EventsError('An unexpected error occurred'));
      }
    });
  }
}
