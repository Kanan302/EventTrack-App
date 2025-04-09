import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/cubits/events/register_event/register_event_cubit.dart';
import 'package:ascca_app/ui/utils/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailButton extends StatelessWidget {
  final String eventId;
  const EventDetailButton({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BlocBuilder<RegisterEventCubit, RegisterEventState>(
        builder: (context, state) {
          if (state is RegisterEventFailure) {
            return Text('xəta baş verdi: $state');
          }
          return AppElevatedButton(
            onPressed:
                () => context.read<RegisterEventCubit>().registerEvent(eventId),
            buttonColor: AppColors.lavenderBlue,
            text: AppTexts.registerEvent,
            textColor: AppColors.white,
            isLoading: state is RegisterEventLoading,
          );
        },
      ),
    );
  }
}
