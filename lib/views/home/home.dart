import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/errors/flushbar.dart';
import '../../core/services/local/secure_service.dart';
import '../../core/services/injection.dart';

import 'calendar_tab/calendar_tab.dart';
import 'events_tab/events_tab.dart';
import 'profile_tab/pages/profile_tab.dart';
import 'trends_tab/trends_tab.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/floating_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController;
  final _secureStorage = getIt.get<SecureService>();
  String? userStatus;
  Map<String, dynamic>? flushbarMessage;

  Future<void> _loadUserStatus() async {
    final status = await _secureStorage.userStatus;
    setState(() {
      userStatus = status;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserStatus();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

      if (extra != null && extra.containsKey('message')) {
        setState(() {
          flushbarMessage = extra;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (flushbarMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlushbarService.showFlushbar(
          context: context,
          message: flushbarMessage!['message'],
          isSuccess: flushbarMessage!['isSuccess'],
        );

        setState(() {
          flushbarMessage = null;
        });
      });
    }

    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          TrendingTab(),
          EventsTab(),
          CalendarTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(tabController: tabController),
      floatingActionButton: userStatus == "1" ? FloatingButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
