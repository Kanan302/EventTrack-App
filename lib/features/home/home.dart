import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../../core/errors/flushbar.dart';
import '../../data/local/secure_service.dart';
import '../../injection.dart';

import 'calendar/calendar.dart';
import 'events/events.dart';
import 'profile/profile.dart';
import 'trending/trending.dart';
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

  Future<void> _logout() async {
    await _secureStorage.clearToken();
    if (mounted) {
      context.go(AppRoutes.login.path);
    }
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
      appBar: AppBar(
        title: Text('Home'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _logout)],
      ),
      body: TabBarView(
        controller: tabController,
        children: [EventsPage(), TrendingPage(), CalendarPage(), ProfilePage()],
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
