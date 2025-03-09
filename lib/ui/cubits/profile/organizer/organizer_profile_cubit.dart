import 'package:ascca_app/data/models/profile/organizer/organizer_profile_model.dart';
import 'package:ascca_app/data/repositories/profile/organizer/organizer_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'organizer_profile_state.dart';

class OrganizerProfileCubit extends Cubit<OrganizerProfileState> {
  final OrganizerProfileRepository repository;

  OrganizerProfileCubit({required this.repository})
    : super(OrganizerProfileInitial());

  Future<void> getOrganizerData(int organizerId) async {
    emit(OrganizerProfileLoading());
    try {
      final organizer = await repository.getOrganizerData(organizerId);
      emit(OrganizerProfileSuccess(organizer));
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(OrganizerProfileFailure(errorMessage));
    }
  }
}
