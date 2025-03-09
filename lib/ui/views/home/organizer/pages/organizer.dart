import 'package:ascca_app/data/models/profile/organizer/organizer_profile_model.dart';
import 'package:ascca_app/ui/cubits/profile/organizer/organizer_profile_cubit.dart';
import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_about.dart';
import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_events_list.dart';
import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_name.dart';
import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizerPage extends StatefulWidget {
  final int organizerId;
  const OrganizerPage({super.key, required this.organizerId});

  @override
  State<OrganizerPage> createState() => _OrganizerPageState();
}

class _OrganizerPageState extends State<OrganizerPage> {
  @override
  void initState() {
    context.read<OrganizerProfileCubit>().getOrganizerData(widget.organizerId);
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OrganizerPhoto(),
                    OrganizerName(name: organizer.fullName ?? ''),
                    SizedBox(height: height * 0.01),
                    OrganizerAbout(about: organizer.aboutMe ?? ''),
                    SizedBox(height: height * 0.04),
                    OrganizerEventsList(events: organizer.events ?? []),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Məlumat tapılmadı'));
        },
      ),
    );
  }
}
