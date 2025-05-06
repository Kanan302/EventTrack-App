import 'package:flutter/material.dart';

import '../../../../generated/l10n/app_localizations.dart';
import '../../../../shared/theme/app_colors.dart';

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
      tabs: [
        Tab(
          text: AppLocalizations.of(context).events,
          icon: Icon(Icons.event_seat_outlined, size: 25),
        ),
        Tab(
          text: AppLocalizations.of(context).popular,
          icon: Icon(Icons.trending_up_outlined, size: 25),
        ),
        Tab(
          text: AppLocalizations.of(context).map,
          icon: Icon(Icons.map, size: 25),
        ),
        Tab(
          text: AppLocalizations.of(context).profile,
          icon: Icon(Icons.person, size: 25),
        ),
      ],
    );
  }
}
