import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/shared/constants/app_images.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_about.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_app_bar.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_button.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_date.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_location.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_organizer.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_title.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final GetEventsModel eventModel;
  const EventDetailPage({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final ValueNotifier<bool> isBookmarked = ValueNotifier<bool>(false);

    return Scaffold(
      // appBar: AppBar(title: Text('event detail')),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 250,
              child: Image.asset(
                AppImages.example.path,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              //  SvgPicture.asset(
              //   AppImages.logo.path,
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              // ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: SizedBox(),
          ),
          SafeArea(
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: isBookmarked,
                  builder: (context, value, child) {
                    return EventDetailAppBar(
                      onTap: () {
                        isBookmarked.value = !isBookmarked.value;
                      },
                      icon: value ? Icons.bookmark : Icons.bookmark_border,
                    );
                  },
                ),
                SizedBox(height: height * 0.18),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EventDetailTitle(eventTitle: eventModel.name ?? ''),
                          const SizedBox(height: 20),
                          EventDetailDate(
                            eventStartDate: eventModel.startDate ?? '',
                            eventEndDate: eventModel.endDate ?? '',
                          ),
                          const SizedBox(height: 20),
                          EventDetailLocation(
                            eventLocation: eventModel.location ?? '',
                          ),
                          const SizedBox(height: 10),
                          EventDetailOrganizer(
                            eventOrganizer: eventModel.organizerName ?? '',
                            organizerId: eventModel.organizerId.toString(),
                          ),
                          const SizedBox(height: 30),
                          EventDetailAbout(eventAbout: eventModel.about ?? ''),
                          const SizedBox(height: 20),
                          EventDetailButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
