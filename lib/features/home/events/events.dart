import 'package:ascca_app/core/constants/app_routes.dart';
import 'package:ascca_app/core/constants/app_texts.dart';
import 'package:ascca_app/features/home/widgets/drawer_part.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventsPage extends StatelessWidget {
  final TabController tabController;
  const EventsPage({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.events),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
          IconButton(
            onPressed: () => context.push(AppRoutes.notification.path),
            icon: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      drawer: DrawerPart(tabController: tabController),
      // extendBodyBehindAppBar: true,
      body: SafeArea(child: Center(child: Text('events page'))),
    );
  }
}
