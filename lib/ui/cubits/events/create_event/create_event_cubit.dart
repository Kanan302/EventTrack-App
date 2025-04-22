import 'dart:io';

import 'package:ascca_app/data/models/events/create_event/create_event_request_model.dart';
import 'package:ascca_app/data/repositories/events/create_event/create_event_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/utils/messages/messages.dart';
import 'package:ascca_app/ui/utils/notifications/snackbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  final CreateEventRepository repository;
  final SecureService secureService;

  CreateEventCubit({required this.repository, required this.secureService})
    : super(CreateEventInitial());

  Future<void> createEvent({
    required BuildContext context,
    required String name,
    required String about,
    required String city,
    required String street,
    required String lat,
    required String lng,
    required File image,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(CreateEventLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        throw Exception(Messages.userIdNotFound);
      }
      final CreateEventRequestModel createEventRequestModel =
          CreateEventRequestModel(
            name: name,
            about: about,
            city: city,
            street: street,
            lat: lat,
            lng: lng,
            image: image,
            startDate: startDate,
            endDate: endDate,
            organizerId: userId,
          );

      await repository.createEvent(createEventRequestModel);
      // .timeout(
      //   const Duration(seconds: 10),
      //   onTimeout: () {
      //     throw Exception(
      //       "Server cavab vermir, zəhmət olmasa sonra yenidən yoxlayın!",
      //     );
      //   },
      // );

      emit(CreateEventSuccess());

      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      SnackBarService.showSnackBar(
        context,
        Messages.eventCreatedSuccessfully,
        isDarkMode ? AppColors.white : AppColors.black,
      );

      Navigator.of(context).pop();
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(CreateEventFailure(errorMessage: errorMessage));
    }
  }
}
