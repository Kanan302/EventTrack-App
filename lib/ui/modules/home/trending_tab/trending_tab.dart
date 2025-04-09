import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/cubits/events/top_events/top_events_cubit.dart';
import 'package:ascca_app/ui/modules/home/create_event/service/create_event_date_service.dart';
import 'package:ascca_app/ui/modules/home/create_event/widgets/create_event_formfield.dart';
import 'package:ascca_app/ui/modules/home/events_tab/widgets/event_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../shared/constants/app_texts.dart';

class TrendingTab extends StatefulWidget {
  const TrendingTab({super.key});

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
  final eventDateService = CreateEventDateService();
  final eventStartDateTimeController = TextEditingController();
  final eventEndDateTimeController = TextEditingController();

  @override
  void initState() {
    context.read<TopEventsCubit>().getTopEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.topEvents)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: CreateEventFormfield(
                        labelText: 'Başlanğıc Tarixi',
                        controller: eventStartDateTimeController,
                        onTap:
                            () => pickDateTime(
                              context,
                              eventStartDateTimeController,
                              true,
                              eventDateService,
                            ),
                        validator: validateDateTimeFormat,
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: CreateEventFormfield(
                        labelText: 'Bitiş Tarixi',
                        controller: eventEndDateTimeController,
                        onTap:
                            () => pickDateTime(
                              context,
                              eventEndDateTimeController,
                              false,
                              eventDateService,
                            ),
                        validator: validateDateTimeFormat,
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                      return ListView.builder(
                        itemCount: topEvents.length,
                        itemBuilder: (context, index) {
                          final event = topEvents[index];
                          return Stack(
                            children: [
                              EventsCardItem(
                                cardId: event.id.toString(),
                                onTapCard: () {},
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
                                child: Container(
                                  width: 45,
                                  padding: const EdgeInsets.all(6),
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
                          );
                        },
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

  @override
  void dispose() {
    eventStartDateTimeController.dispose();
    eventEndDateTimeController.dispose();
    super.dispose();
  }
}
