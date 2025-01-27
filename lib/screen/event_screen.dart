import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_list/event_list_bloc.dart';
import '../bloc/event_list/event_list_state.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.description),
                  onTap: () =>
                      Navigator.pushNamed(context, '/order', arguments: event),
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
