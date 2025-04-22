import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/ui/views/home/events_tab/widgets/event_card_item.dart';
import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_event_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utils/messages/messages.dart';

class OrganizerEventsList extends StatelessWidget {
  final List<GetEventsModel> events;

  const OrganizerEventsList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OrganizerEventTitle(),
        SizedBox(height: height * 0.01),
        if (events.isNotEmpty)
          ...events.map((event) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: EventsCardItem(
                cardId: event.id.toString(),
                onTapCard: () {},
                imageUrl: event.imageURL ?? '',
                startDate:
                    event.startDate != null
                        ? DateFormat(
                          'MMM d - EEE - h:mm a',
                        ).format(DateTime.parse(event.startDate!))
                        : Messages.dateNotAvailable,
                title: event.name ?? Messages.noNamedEvent,
                street: event.street ?? Messages.noData,
                city: event.city ?? Messages.noData,
                onDelete: () {},
                userStatus: '0',
              ),
            );
          })
        else
          const Center(child: Text(Messages.organizerHasNoEvents)),
      ],
    );
  }
}
