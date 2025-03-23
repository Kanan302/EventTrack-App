import 'package:ascca_app/data/models/events/create_event/create_event_request_model.dart';
import 'package:ascca_app/data/repositories/events/create_event/create_event_repository.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
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
    required String imageURL,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    emit(CreateEventLoading());
    try {
      final userId = await secureService.userId;

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID tapılmadı!');
      }
      final CreateEventRequestModel createEventRequestModel =
          CreateEventRequestModel(
            name: name,
            about: about,
            city: city,
            street: street,
            imageURL: imageURL,
            startDate: startDate,
            endDate: endDate,
            organizerId: userId,
          );
      await repository.createEvent(createEventRequestModel);

      emit(CreateEventSuccess());

      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      SnackBarService.showSnackBar(
        context,
        'Tədbir uğurla yarandı!',
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
