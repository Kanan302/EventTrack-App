import 'package:ascca_app/data/models/events/get_events/get_events_model.dart';
import 'package:ascca_app/shared/constants/app_images.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/cubits/profile/organizer/organizer_profile_cubit.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_about.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_app_bar.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_button.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_date.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_location.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_organizer.dart';
import 'package:ascca_app/ui/views/home/event_detail/widgets/event_detail_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailPage extends StatelessWidget {
  final GetEventsModel eventModel;
  const EventDetailPage({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final ValueNotifier<bool> isBookmarked = ValueNotifier<bool>(false);
    context.read<OrganizerProfileCubit>().getOrganizerData(
      int.parse(eventModel.organizerId!),
    );

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
                    child: Image.network(
                      eventModel.imageURL ?? AppImages.example.path,
                      fit: BoxFit.cover,
                      width: double.infinity,
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
                              isBookmarked.value = !isBookmarked.value;
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
                                  eventLocation: eventModel.location ?? '',
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
            );
          }

          return const Center(child: Text('Məlumat tapılmadı'));
        },
      ),
    );
  }
}
