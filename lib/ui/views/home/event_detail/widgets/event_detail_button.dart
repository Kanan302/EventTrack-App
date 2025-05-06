import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/services/injection/di.dart';
import '../../../../../shared/services/local/secure_service.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../cubits/events/export_event/export_event_cubit.dart';
import '../../../../cubits/events/register_event/register_event_cubit.dart';
import '../../../../utils/notifications/snackbar.dart';
import '../../../../utils/widgets/app_elevated_button.dart';

class EventDetailButton extends StatefulWidget {
  final String eventId;

  const EventDetailButton({super.key, required this.eventId});

  @override
  State<EventDetailButton> createState() => _EventDetailButtonState();
}

class _EventDetailButtonState extends State<EventDetailButton> {
  final _secureStorage = getIt.get<SecureService>();
  String? userStatus;

  Future<void> _loadUserStatus() async {
    final status = await _secureStorage.userStatus;
    setState(() {
      userStatus = status;
    });
  }

  @override
  void initState() {
    _loadUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userStatus == '1'
        ? Align(
          alignment: Alignment.bottomCenter,
          child: BlocConsumer<ExportEventCubit, ExportEventState>(
            listener: (context, state) {
              if (state is ExportEventSuccess) {
                SnackBarService.showSnackBar(
                  context,
                  AppLocalizations.of(context).exported,
                  AppColors.black,
                );
              } else if (state is ExportEventFailure) {
                SnackBarService.showSnackBar(
                  context,
                  '${AppLocalizations.of(context).anErrorOccurred} ${state.errorMessage}',
                  AppColors.red,
                );
              }
            },
            builder: (context, state) {
              return AppElevatedButton(
                onPressed:
                    () => context.read<ExportEventCubit>().exportEvent(
                      context,
                      widget.eventId,
                    ),
                buttonColor: AppColors.lavenderBlue,
                text: AppLocalizations.of(context).export,
                textColor: AppColors.white,
                isLoading: state is ExportEventLoading,
              );
            },
          ),
        )
        : Align(
          alignment: Alignment.bottomCenter,
          child: BlocConsumer<RegisterEventCubit, RegisterEventState>(
            listener: (context, state) {
              if (state is RegisterEventSuccess) {
                SnackBarService.showSnackBar(
                  context,
                  AppLocalizations.of(context).qrCodeSent,
                  AppColors.black,
                );
              } else if (state is RegisterEventFailure) {
                SnackBarService.showSnackBar(
                  context,
                  '${AppLocalizations.of(context).anErrorOccurred} ${state.errorMessage}',
                  AppColors.red,
                );
              }
            },
            builder: (context, state) {
              return AppElevatedButton(
                onPressed:
                    () => context.read<RegisterEventCubit>().registerEvent(
                      context,
                      widget.eventId,
                    ),
                buttonColor: AppColors.lavenderBlue,
                text: AppLocalizations.of(context).registerEvent,
                textColor: AppColors.white,
                isLoading: state is RegisterEventLoading,
              );
            },
          ),
        );
  }
}
