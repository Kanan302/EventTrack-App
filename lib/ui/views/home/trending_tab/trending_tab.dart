import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/cubits/events/top_events/top_events_cubit.dart';
import 'package:ascca_app/ui/views/home/events_tab/widgets/event_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../shared/constants/app_texts.dart';

class TrendingTab extends StatefulWidget {
  const TrendingTab({super.key});

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
  // final eventDateService = CreateEventDateService();
  // final eventStartDateTimeController = TextEditingController();
  // final eventEndDateTimeController = TextEditingController();

  @override
  void initState() {
    context.read<TopEventsCubit>().getTopEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // SizedBox(height: 20),
              // Row(
              //   children: [
              //     Expanded(
              //       child: SizedBox(
              //         height: 60,
              //         child: CreateEventFormfield(
              //           labelText: 'Başlanğıc Tarixi',
              //           controller: eventStartDateTimeController,
              //           onTap:
              //               () => pickDateTime(
              //                 context,
              //                 eventStartDateTimeController,
              //                 true,
              //                 eventDateService,
              //               ),
              //           validator: validateDateTimeFormat,
              //           prefixIcon: Icon(Icons.calendar_month_outlined),
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Expanded(
              //       child: SizedBox(
              //         height: 60,
              //         child: CreateEventFormfield(
              //           labelText: 'Bitiş Tarixi',
              //           controller: eventEndDateTimeController,
              //           onTap:
              //               () => pickDateTime(
              //                 context,
              //                 eventEndDateTimeController,
              //                 false,
              //                 eventDateService,
              //               ),
              //           validator: validateDateTimeFormat,
              //           prefixIcon: Icon(Icons.calendar_month_outlined),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppTexts.topEvents,
                  style: TextStyle(
                    color: AppColors.graphiteGray,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<TopEventsCubit, TopEventsState>(
                  builder: (context, state) {
                    if (state is TopEventsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is TopEventsFailure) {
                      return Center(
                        child: Text('Xəta baş verdi: ${state.errorMessage}'),
                      );
                    } else if (state is TopEventsSuccess) {
                      final topEvents = state.topEvents;
                      if (topEvents.isEmpty) {
                        return const Center(
                          child: Text('Heç bir tədbir tapılmadı.'),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          await context.read<TopEventsCubit>().getTopEvents(
                            forceRefresh: true,
                          );
                        },
                        child: ListView.builder(
                          itemCount: topEvents.length,
                          itemBuilder: (context, index) {
                            final event = topEvents[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Stack(
                                children: [
                                  EventsCardItem(
                                    cardId: event.id.toString(),
                                    onTapCard:
                                        () => context.push(
                                          AppRoutes.eventDetails.path,
                                          extra: event,
                                        ),
                                    imageUrl: event.imageURL ?? '',
                                    startDate:
                                        event.startDate != null
                                            ? DateFormat(
                                              'MMM d - EEE - h:mm a',
                                            ).format(
                                              DateTime.parse(event.startDate!),
                                            )
                                            : 'No Date Available',
                                    title: event.name!,
                                    street: event.street ?? 'Məlumat yoxdur',
                                    city: event.city ?? 'Məlumat yoxdur',
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 10,
                                    child: SizedBox(
                                      width: 50,
                                      child: Text(
                                        '🔥${event.registrationCount}',
                                        style: TextStyle(
                                          color: AppColors.graphiteGray,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
