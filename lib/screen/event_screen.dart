import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_assetment/bloc/event_list/event_list_event.dart';
import 'package:web_socket_assetment/bloc/event_list/event_list_state.dart';

import '../bloc/event_list/event_list_bloc.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  String truncateDescription(String description, int wordLimit) {
    final words = description.split(' ');
    if (words.length <= wordLimit) {
      return description;
    }
    return words.sublist(0, wordLimit).join(' ') + '...';
  }

  @override
  Widget build(BuildContext context) {
    context.read<EventsBloc>().add(FetchEventsEvent());
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EventsLoaded) {
            return ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
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
                          event.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Description: ${truncateDescription(event.description, 50)}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Price: \$${event.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              context.pushNamed(
                                'order',
                                pathParameters: {'id': event.id},
                                extra: {
                                  'description': event.description,
                                  'price': event.price,
                                },
                              );
                            },
                            child: Text('View Details'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is EventsError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No events available'));
        },
      ),
    );
  }
}
