import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/constants/app_routes.dart';
import '../../../../../shared/services/injection/di.dart';
import '../../../../../shared/services/local/secure_service.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../cubits/events/delete_event/delete_event_cubit.dart';
import '../../../../cubits/events/get_events/get_events_cubit.dart';
import '../../profile_tab/service/theme_cubit.dart';
import '../widgets/event_card_item.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ValueNotifier<bool> isSearching = ValueNotifier(false);
  final ValueNotifier<List<dynamic>> filteredEvents = ValueNotifier([]);
  final _secureStorage = getIt.get<SecureService>();
  String? userStatus;
  late GetEventsCubit getEventsCubit;
  late DeleteEventCubit deleteEventCubit;

  Future<void> _loadUserStatus() async {
    final status = await _secureStorage.userStatus;
    setState(() {
      userStatus = status;
    });
  }

  void _toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      _searchController.clear();
      _filterEvents('');
      _searchFocusNode.unfocus();
    } else {
      _searchFocusNode.requestFocus();
    }
  }

  void _filterEvents(String query) {
    final state = context.read<GetEventsCubit>().state;
    if (state is GetEventsSuccess) {
      if (query.isEmpty) {
        filteredEvents.value = state.events;
      } else {
        filteredEvents.value =
            state.events
                .where(
                  (event) =>
                      event.name!.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    }
  }

  void _deleteEvent(String eventId) {
    deleteEventCubit.deleteEvent(context, eventId);

    filteredEvents.value =
        filteredEvents.value
            .where((event) => event.id.toString() != eventId)
            .toList();

    getEventsCubit.getEvents(context);
  }

  @override
  void initState() {
    super.initState();
    _loadUserStatus();
    getEventsCubit = context.read<GetEventsCubit>();
    deleteEventCubit = context.read<DeleteEventCubit>();
    getEventsCubit.getEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            final bool isDarkMode = themeMode == ThemeMode.dark;
            final Color textColor =
                isDarkMode ? AppColors.white : AppColors.black;

            return ValueListenableBuilder<bool>(
              valueListenable: isSearching,
              builder: (context, isSearchActive, child) {
                return isSearchActive
                    ? TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onChanged: _filterEvents,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).searchEvent,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: textColor),
                    )
                    : Text(AppLocalizations.of(context).events);
              },
            );
          },
        ),
        centerTitle: true,
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: isSearching,
            builder: (context, isSearchActive, child) {
              return IconButton(
                onPressed: _toggleSearch,
                icon: Icon(isSearchActive ? Icons.close : Icons.search),
              );
            },
          ),
          // InkWell(
          //   onTap: () => context.push(AppRoutes.notification.path),
          //   child: Icon(Icons.notifications_none_outlined),
          // ),
          SizedBox(width: 5),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteEventCubit, DeleteEventState>(
            listener: (context, deleteState) {
              if (deleteState is DeleteEventSuccess) {
                getEventsCubit.getEvents(context);
              }
            },
          ),
        ],
        child: BlocBuilder<GetEventsCubit, GetEventsState>(
          builder: (context, state) {
            if (state is GetEventsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetEventsFailure) {
              return Center(child: Text(state.errorMessage));
            } else if (state is GetEventsSuccess) {
              return ValueListenableBuilder<List<dynamic>>(
                valueListenable: filteredEvents,
                builder: (context, events, child) {
                  final eventList = isSearching.value ? events : state.events;
                  if (eventList.isEmpty) {
                    return Center(
                      child: Text(AppLocalizations.of(context).noEventFound),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      await getEventsCubit.getEvents(
                        context,
                        forceRefresh: true,
                      );
                    },
                    child: ListView.builder(
                      itemCount: eventList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == eventList.length) {
                          return SizedBox(height: 20);
                        }
                        final event = eventList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 15.0,
                            bottom: 20.0,
                            top: 5.0,
                          ),
                          child: EventsCardItem(
                            cardId: event.id.toString(),
                            onTapCard:
                                () => context.push(
                                  AppRoutes.eventDetails.path,
                                  extra: event,
                                ),
                            imageUrl: event.imageURL ?? '',
                            startDate:
                                event.startDate != null
                                    ? DateFormat(
                                      'MMM d - EEE - h:mm a',
                                    ).format(DateTime.parse(event.startDate!))
                                    : AppLocalizations.of(context).noData,
                            title: event.name!,
                            street:
                                event.street ??
                                AppLocalizations.of(context).noData,
                            city:
                                event.city ??
                                AppLocalizations.of(context).noData,
                            onDelete: () {
                              _deleteEvent(event.id.toString());
                            },
                            userStatus: userStatus ?? '',
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    isSearching.dispose();
    filteredEvents.dispose();
    super.dispose();
  }
}
