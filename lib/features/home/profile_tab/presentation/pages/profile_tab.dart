import 'package:ascca_app/core/constants/app_colors.dart';
import 'package:ascca_app/core/constants/app_routes.dart';
import 'package:ascca_app/features/home/profile_tab/presentation/widgets/profile_card.dart';
import 'package:ascca_app/features/home/profile_tab/presentation/widgets/profile_log_out_dialog.dart';
import 'package:ascca_app/features/home/profile_tab/presentation/widgets/profile_name.dart';
import 'package:ascca_app/features/home/profile_tab/presentation/widgets/profile_photo.dart';
import 'package:ascca_app/features/home/services/log_out.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_texts.dart';
import '../widgets/profile_app_bar.dart';

class ProfileTab extends StatelessWidget {
  final LogOut _logOut = LogOut();
  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ProfileAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: height * 0.012,
              children: [
                SizedBox(height: height * 0.008),
                ProfilePhoto(),
                ProfileName(),
                SizedBox(height: height * 0.02),
                ProfileCard(
                  leadingIcon: Icons.bookmark_outline,
                  leadingIconColor: AppColors.lavenderBlue,
                  title: AppTexts.bookmark,
                  onTap: () {},
                ),
                ProfileCard(
                  leadingIcon: Icons.notifications_none_outlined,
                  leadingIconColor: AppColors.lavenderBlue,
                  title: AppTexts.notifications,
                  onTap: () => context.push(AppRoutes.notification.path),
                ),
                ProfileCard(
                  leadingIcon: Icons.settings_outlined,
                  leadingIconColor: AppColors.lavenderBlue,
                  title: AppTexts.settings,
                  onTap: () {},
                ),
                ProfileCard(
                  leadingIcon: Icons.info_outline,
                  leadingIconColor: AppColors.lavenderBlue,
                  title: AppTexts.about,
                  onTap: () {},
                ),
                ProfileCard(
                  leadingIcon: Icons.logout,
                  leadingIconColor: AppColors.red,
                  title: AppTexts.logOut,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => LogoutDialog(
                            onConfirm: () => _logOut.logout(context),
                          ),
                    );
                  },
                  showTrailing: false,
                  textColor: AppColors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
