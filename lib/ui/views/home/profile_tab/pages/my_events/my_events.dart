import 'package:ascca_app/ui/utils/messages/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/models/profile/organizer/organizer_profile_model.dart';
import '../../../../../../shared/constants/app_texts.dart';
import '../../../../../../shared/services/injection/di.dart';
import '../../../../../../shared/services/local/secure_service.dart';
import '../../../../../cubits/profile/organizer/organizer_profile_cubit.dart';
import '../../../events_tab/widgets/event_card_item.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  final _secureStorage = getIt.get<SecureService>();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadOrganizerData();
  }

  Future<void> _loadOrganizerData() async {
    final userId = await _secureStorage.userId;
    if (!mounted) return;
    setState(() {
      _userId = userId;
    });
    context.read<OrganizerProfileCubit>().getOrganizerData(int.parse(userId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.myEvents)),
      body: BlocBuilder<OrganizerProfileCubit, OrganizerProfileState>(
        builder: (context, state) {
          if (state is OrganizerProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrganizerProfileFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is OrganizerProfileSuccess) {
            final OrganizerProfileModel organizer = state.organizer;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Center(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      if (_userId != null) {
                        await context
                            .read<OrganizerProfileCubit>()
                            .getOrganizerData(
                              int.parse(_userId!),
                              forceRefresh: true,
                            );
                      }
                    },
                    child: ListView.builder(
                      itemCount: organizer.events!.length,
                      itemBuilder: (context, index) {
                        final event = organizer.events![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: EventsCardItem(
                            cardId: event.id.toString(),
                            onTapCard: () {},
                            imageUrl: event.imageURL ?? '',
                            startDate:
                                event.startDate != null
                                    ? DateFormat(
                                      'MMM d - EEE - h:mm a',
                                    ).format(DateTime.parse(event.startDate!))
                                    : Messages.dateNotAvailable,
                            title: event.name ?? Messages.noNamedEvent,
                            street: event.street ?? Messages.noData,
                            city: event.city ?? Messages.noData,
                            onDelete: () {},
                            userStatus: '0',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: Text(Messages.noData));
        },
      ),
    );
  }
}
