import 'package:ascca_app/data/models/events/bookmarked_events/bookmarked_events_model.dart';
import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/cubits/events/bookmarked_events/delete_bookmarked_event.dart/delete_bookmarked_events_cubit.dart';
import 'package:ascca_app/ui/cubits/events/bookmarked_events/post_bookmark_event/bookmark_events_cubit.dart';
import 'package:ascca_app/ui/cubits/profile/organizer/organizer_profile_cubit.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_about.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_app_bar.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_button.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_date.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_location.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_organizer.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailPage extends StatelessWidget {
  final dynamic eventModel;
  const EventDetailPage({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final ValueNotifier<bool> isBookmarked = ValueNotifier<bool>(false);
    String? organizerId;
    String? eventId;

    if (eventModel is GetEventsModel) {
      organizerId = eventModel.organizerId;
      eventId = eventModel.id.toString();
    } else if (eventModel is BookmarkedEventsModel) {
      organizerId = eventModel.organizerId;
      eventId = eventModel.id.toString();

      isBookmarked.value = true;
    }

    if (organizerId != null) {
      context.read<OrganizerProfileCubit>().getOrganizerData(
        int.parse(organizerId),
      );
    }

    return Scaffold(
      body: BlocBuilder<OrganizerProfileCubit, OrganizerProfileState>(
        builder: (context, state) {
          if (state is OrganizerProfileLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is OrganizerProfileFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: AppColors.red, size: 40),
                  const SizedBox(height: 20),
                  Text(
                    'Xəta baş verdi: ${state.errorMessage}',
                    style: TextStyle(color: AppColors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is OrganizerProfileSuccess) {
            final organizer = state.organizer;

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 250,
                    child: CachedNetworkImage(
                      imageUrl: eventModel.imageURL ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: isBookmarked,
                        builder: (context, value, child) {
                          return EventDetailAppBar(
                            onTap: () {
                              if (eventId != null) {
                                if (value) {
                                  context
                                      .read<DeleteBookmarkedEventsCubit>()
                                      .deleteBookmarkEvent(eventId);
                                  isBookmarked.value = false;
                                } else {
                                  context
                                      .read<BookmarkEventsCubit>()
                                      .bookmarkEvent(eventId);
                                  isBookmarked.value = true;
                                }
                              }
                            },
                            icon:
                                value ? Icons.bookmark : Icons.bookmark_border,
                          );
                        },
                      ),
                      SizedBox(height: height * 0.18),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EventDetailTitle(
                                  eventTitle: eventModel.name ?? '',
                                ),
                                const SizedBox(height: 20),
                                EventDetailDate(
                                  eventStartDate: eventModel.startDate ?? '',
                                  eventEndDate: eventModel.endDate ?? '',
                                ),
                                const SizedBox(height: 20),
                                EventDetailLocation(
                                  eventCity:
                                      eventModel.city ?? 'Məlumat yoxdur',
                                  eventStreet:
                                      eventModel.street ?? 'Məlumat yoxdur',
                                ),
                                const SizedBox(height: 10),
                                EventDetailOrganizer(
                                  eventOrganizer: organizer.fullName ?? '',
                                  organizerId: organizer.id.toString(),
                                  profilePictureUrl:
                                      organizer.profilePictureUrl ?? '',
                                  aboutOrganizer: organizer.aboutMe ?? '',
                                ),
                                const SizedBox(height: 30),
                                EventDetailAbout(
                                  eventAbout: eventModel.about ?? '',
                                ),
                                const SizedBox(height: 20),
                                EventDetailButton(eventId: eventModel.id),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Məlumat tapılmadı'));
        },
      ),
    );
  }
}
