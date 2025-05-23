import 'package:ascca_app/data/models/profile/organizer/organizer_profile_model.dart';
import 'package:ascca_app/data/repositories/profile/organizer/organizer_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'organizer_profile_state.dart';

class OrganizerProfileCubit extends Cubit<OrganizerProfileState> {
  final OrganizerProfileRepository repository;
  bool _hasFetched = false;

  OrganizerProfileCubit({required this.repository})
    : super(OrganizerProfileInitial());

  Future<void> getOrganizerData(
    BuildContext context,
    int organizerId, {
    bool forceRefresh = false,
  }) async {
    if (_hasFetched && !forceRefresh) return;

    emit(OrganizerProfileLoading());
    try {
      final organizer = await repository.getOrganizerData(organizerId, context);
      emit(OrganizerProfileSuccess(organizer));
      _hasFetched = true;
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(OrganizerProfileFailure(errorMessage));
    }
  }
}
