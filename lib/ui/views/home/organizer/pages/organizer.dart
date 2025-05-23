import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/profile/organizer/organizer_profile_model.dart';
import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../cubits/profile/organizer/organizer_profile_cubit.dart';
import '../widgets/organizer_about.dart';
import '../widgets/organizer_events_list.dart';
import '../widgets/organizer_name.dart';
import '../widgets/organizer_photo.dart';

class OrganizerPage extends StatefulWidget {
  final int organizerId;

  const OrganizerPage({super.key, required this.organizerId});

  @override
  State<OrganizerPage> createState() => _OrganizerPageState();
}

class _OrganizerPageState extends State<OrganizerPage> {
  @override
  void initState() {
    context.read<OrganizerProfileCubit>().getOrganizerData(
      context,
      widget.organizerId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<OrganizerProfileCubit, OrganizerProfileState>(
        builder: (context, state) {
          if (state is OrganizerProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrganizerProfileFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is OrganizerProfileSuccess) {
            final OrganizerProfileModel organizer = state.organizer;
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<OrganizerProfileCubit>().getOrganizerData(
                    context,
                    widget.organizerId,
                    forceRefresh: true,
                  );
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OrganizerPhoto(
                        profilePictureUrl: organizer.profilePictureUrl,
                      ),
                      SizedBox(height: height * 0.01),
                      OrganizerName(name: organizer.fullName ?? ''),
                      SizedBox(height: height * 0.01),
                      OrganizerAbout(about: organizer.aboutMe ?? ''),
                      SizedBox(height: height * 0.04),
                      OrganizerEventsList(events: organizer.events ?? []),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(child: Text(AppLocalizations.of(context).noData));
        },
      ),
    );
  }
}
