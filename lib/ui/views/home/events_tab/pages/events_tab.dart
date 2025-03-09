import 'package:ascca_app/shared/constants/app_images.dart';
import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:ascca_app/ui/views/home/events_tab/widgets/event_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/cubits/events/get_events/get_events_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  void initState() {
    context.read<GetEventsCubit>().getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.events),
        centerTitle: true,
        actions: [
          Transform.translate(
            offset: Offset(-8, 0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_outlined),
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetEventsCubit, GetEventsState>(
        builder: (context, state) {
          if (state is GetEventsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetEventsFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is GetEventsSuccess) {
            final events = state.events;
            if (events.isEmpty) {
              return Center(child: Text('No events found.'));
            }
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: EventsCardItem(
                    cardId: event.id.toString(),
                    onTapCard:
                        () => context.push(
                          AppRoutes.eventDetails.path,
                          extra: event,
                        ),
                    imageUrl: AppImages.example.path,
                    startDate:
                        event.startDate != null
                            ? DateFormat(
                              ' MMM d - EEE - h:mm a',
                            ).format(DateTime.parse(event.startDate!))
                            : 'No Date Available',
                    title: event.name!,
                    location: event.location,
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
