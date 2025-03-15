import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:ascca_app/shared/services/injection/di.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/cubits/events/delete_event/delete_event_cubit.dart';
import 'package:ascca_app/ui/views/home/events_tab/widgets/event_card_item.dart';
import 'package:ascca_app/ui/views/home/profile_tab/service/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/cubits/events/get_events/get_events_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
    deleteEventCubit.deleteEvent(eventId);

    filteredEvents.value =
        filteredEvents.value
            .where((event) => event.id.toString() != eventId)
            .toList();

    getEventsCubit.getEvents();
  }

  @override
  void initState() {
    super.initState();
    _loadUserStatus();
    getEventsCubit = context.read<GetEventsCubit>();
    deleteEventCubit = context.read<DeleteEventCubit>();
    getEventsCubit.getEvents();
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
                        hintText: "Tədbir axtarın...",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: textColor),
                    )
                    : Text(AppTexts.events);
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
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteEventCubit, DeleteEventState>(
            listener: (context, deleteState) {
              if (deleteState is DeleteEventSuccess) {
                getEventsCubit.getEvents();
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
                    return Center(child: Text('Heç bir tədbir tapılmadı.'));
                  }
                  return ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      final event = eventList[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
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
                                  : 'No Date Available',
                          title: event.name!,
                          location: event.location,
                          onDelete: () {
                            _deleteEvent(event.id.toString());
                          },
                          userStatus: userStatus ?? '',
                        ),
                      );
                    },
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
