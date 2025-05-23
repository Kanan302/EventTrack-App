import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../cubits/events/create_event/create_event_cubit.dart';
import '../../../../utils/widgets/app_elevated_button.dart';
import '../service/create_event_date_service.dart';
import '../widgets/create_event_app_bar.dart';
import '../widgets/create_event_date.dart';
import '../widgets/create_event_description.dart';
import '../widgets/create_event_map.dart';
import '../widgets/create_event_name.dart';
import '../widgets/create_event_photo.dart';
import '../widgets/create_event_title.dart';

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
  final eventCityController = TextEditingController();
  final eventStreetController = TextEditingController();
  final ValueNotifier<File?> _selectedImage = ValueNotifier<File?>(null);
  final ValueNotifier<String?> _imageErrorNotifier = ValueNotifier<String?>(
    null,
  );
  final ValueNotifier<String?> _locationErrorNotifier = ValueNotifier<String?>(
    null,
  );
  final ValueNotifier<String?> _addressNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _cityNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _streetNotifier = ValueNotifier(null);

  LatLng? _selectedLocation;

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
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: CreateEventStreet(
                  //         eventStreetController: eventStreetController,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 20),
                  //     Expanded(
                  //       child: CreateEventCity(
                  //         eventCityController: eventCityController,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  CreateEventDate(
                    eventStartDateTimeController: eventStartDateTimeController,
                    eventEndDateTimeController: eventEndDateTimeController,
                    dateService: eventDateService,
                  ),
                  CreateEventPhoto(
                    imageNotifier: _selectedImage,
                    onImageSelected: (File? image) {
                      _selectedImage.value = image;
                    },
                    errorNotifier: _imageErrorNotifier,
                  ),

                  CreateEventMap(
                    addressNotifier: _addressNotifier,
                    locationErrorNotifier: _locationErrorNotifier,
                    cityNotifier: _cityNotifier,
                    streetNotifier: _streetNotifier,
                    cityController: eventCityController,
                    streetController: eventStreetController,
                    onLocationSelected: (LatLng selected) {
                      _selectedLocation = selected;
                    },
                  ),
                  SizedBox(height: height * 0.005),
                  BlocBuilder<CreateEventCubit, CreateEventState>(
                    builder: (context, state) {
                      return AppElevatedButton(
                        onPressed:
                            state is CreateEventLoading
                                ? () {}
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_selectedImage.value == null) {
                                      _imageErrorNotifier.value =
                                          AppLocalizations.of(
                                            context,
                                          ).uploadImage;
                                      return;
                                    }

                                    if (_selectedLocation == null) {
                                      _locationErrorNotifier.value =
                                          AppLocalizations.of(
                                            context,
                                          ).choosePlaceFromMap;
                                      return;
                                    }

                                    context
                                        .read<CreateEventCubit>()
                                        .createEvent(
                                          context: context,
                                          name: eventNameController.text,
                                          about:
                                              eventDescriptionController.text,
                                          city: eventCityController.text,
                                          street: eventStreetController.text,
                                          lng:
                                              _selectedLocation!.longitude
                                                  .toString(),
                                          lat:
                                              _selectedLocation!.latitude
                                                  .toString(),
                                          image: _selectedImage.value!,
                                          startDate:
                                              eventDateService.startDate!,
                                          endDate: eventDateService.endDate!,
                                        );
                                  }
                                },
                        buttonColor: AppColors.lavenderBlue,
                        text: AppLocalizations.of(context).create,
                        textColor: AppColors.white,
                        isLoading: state is CreateEventLoading,
                      );
                    },
                  ),
                  SizedBox(height: 10),
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
    eventCityController.dispose();
    eventStreetController.dispose();
    super.dispose();
  }
}
