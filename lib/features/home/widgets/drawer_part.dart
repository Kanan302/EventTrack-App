import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_texts.dart';
import '../services/log_out.dart';

class DrawerPart extends StatefulWidget {
  final TabController tabController;

  const DrawerPart({super.key, required this.tabController});

  @override
  State<DrawerPart> createState() => _DrawerPartState();
}

class _DrawerPartState extends State<DrawerPart> {
  @override
  Widget build(BuildContext context) {
    final logOut = LogOut();

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Name',
                // profileProvider.profileModel?.fullName ?? 'Guest User',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  fontSize: 20,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: const CircleAvatar(
                backgroundColor: AppColors.lavenderBlue,
                // backgroundImage: NetworkImage('https://example.com/user-profile.jpg'),
              ),
              decoration: const BoxDecoration(color: AppColors.transparent),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text(AppTexts.myProfile),
              onTap: () => widget.tabController.index = 3,
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text(AppTexts.calendar),
              onTap: () => widget.tabController.index = 2,
            ),
            ListTile(
              leading: const Icon(Icons.trending_up_outlined),
              title: const Text(AppTexts.trending),
              onTap: () => widget.tabController.index = 1,
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_outline),
              title: const Text(AppTexts.bookmark),
              onTap: () {},
              // => context.push(AppRoutes.bookmarkedEvents.path),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text(AppTexts.settings),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(AppTexts.signOut),
              onTap: () => logOut.logout(context),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
