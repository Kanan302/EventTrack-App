import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/services/injection/di.dart';
import 'package:ascca_app/shared/services/local/secure_service.dart';
import 'package:ascca_app/ui/cubits/events/bookmarked_events/get_bookmarked_events/bookmarked_events_cubit.dart';
import 'package:ascca_app/ui/views/home/events_tab/widgets/event_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookmarkedEventsPage extends StatefulWidget {
  const BookmarkedEventsPage({super.key});

  @override
  State<BookmarkedEventsPage> createState() => _BookmarkedEventsPageState();
}

class _BookmarkedEventsPageState extends State<BookmarkedEventsPage> {
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
    super.initState();
    context.read<BookmarkedEventsCubit>().getBookmarkedEvents();
    _loadUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.bookmarkedEvents)),
      body: SafeArea(
        child: BlocBuilder<BookmarkedEventsCubit, BookmarkedEventsState>(
          builder: (context, state) {
            if (state is BookmarkedEventsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookmarkedEventsSuccess) {
              if (state.events.isEmpty) {
                return const Center(child: Text("Heç bir tədbir tapılmadı"));
              }
              return ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
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
                      onDelete: () {},
                      userStatus: userStatus ?? '',
                    ),
                  );
                },
              );
            } else if (state is BookmarkedEventsFailure) {
              return Center(child: Text(state.errorMessage));
            }
            return const Center(child: Text("Tədbirlər yüklənəcək..."));
          },
        ),
      ),
    );
  }
}
