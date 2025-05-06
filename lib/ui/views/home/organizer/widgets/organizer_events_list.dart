import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/events/get_events/get_events_model.dart';
import '../../../../../generated/l10n/app_localizations.dart';
import '../../events_tab/widgets/event_card_item.dart';
import 'organizer_event_title.dart';

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
                        : AppLocalizations.of(context).dateNotAvailable,
                title: event.name ?? AppLocalizations.of(context).noNamedEvent,
                street: event.street ?? AppLocalizations.of(context).noData,
                city: event.city ?? AppLocalizations.of(context).noData,
                onDelete: () {},
                userStatus: '0',
              ),
            );
          })
        else
          Center(
            child: Text(AppLocalizations.of(context).organizerHasNoEvents),
          ),
      ],
    );
  }
}
