import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/cubits/events/create_event/create_event_cubit.dart';
import 'package:ascca_app/ui/views/home/create_event/service/create_event_date_service.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_app_bar.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_date.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_description.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_location.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_name.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_photo.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_title.dart';
import 'package:ascca_app/ui/utils/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final eventDateService = CreateEventDateService();
  final eventStartDateTimeController = TextEditingController();
  final eventEndDateTimeController = TextEditingController();
  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CreateEventAppbar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: height * 0.02,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CreateEventTitle(),
                  CreateEventName(eventNameController: eventNameController),
                  CreateEventDescription(
                    eventDescriptionController: eventDescriptionController,
                  ),
                  CreateEventLocation(
                    eventLocationController: eventLocationController,
                  ),
                  CreateEventDate(
                    eventStartDateTimeController: eventStartDateTimeController,
                    eventEndDateTimeController: eventEndDateTimeController,
                    dateService: eventDateService,
                  ),
                  CreateEventPhoto(),
                  SizedBox(height: height * 0.01),
                  BlocBuilder<CreateEventCubit, CreateEventState>(
                    builder: (context, state) {
                      return AppElevatedButton(
                        onPressed:
                            state is CreateEventLoading
                                ? () {}
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<CreateEventCubit>()
                                        .createEvent(
                                          context: context,
                                          name: eventNameController.text,
                                          about:
                                              eventDescriptionController.text,
                                          location:
                                              eventLocationController.text,
                                          startDate:
                                              eventDateService.startDate!,
                                          endDate: eventDateService.endDate!,
                                        );
                                  }
                                },
                        buttonColor: AppColors.lavenderBlue,
                        text: AppTexts.create,
                        textColor: AppColors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    eventStartDateTimeController.dispose();
    eventEndDateTimeController.dispose();
    eventNameController.dispose();
    eventDescriptionController.dispose();
    eventLocationController.dispose();
    super.dispose();
  }
}
