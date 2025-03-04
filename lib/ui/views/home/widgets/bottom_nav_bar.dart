import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/constants/app_texts.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (value) {
        widget.tabController.index = value;
        setState(() {});
      },
      controller: widget.tabController,
      dividerColor: AppColors.transparent,
      indicatorColor: AppColors.transparent,
      labelColor: AppColors.lavenderBlue,
      unselectedLabelColor: AppColors.graphiteGray,
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      tabs: const [
        Tab(
          text: AppTexts.trends,
          icon: Icon(Icons.trending_up_outlined, size: 25),
        ),
        Tab(
          text: AppTexts.events,
          icon: Icon(Icons.event_seat_outlined, size: 25),
        ),
        Tab(
          text: AppTexts.calendar,
          icon: Icon(Icons.calendar_month, size: 25),
        ),
        Tab(text: AppTexts.profile, icon: Icon(Icons.person, size: 25)),
      ],
    );
  }
}
