import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/shared/constants/app_routes.dart';
import 'package:ascca_app/ui/cubits/profile/update_profile/update_profile_cubit.dart';
import 'package:ascca_app/ui/cubits/profile/user/user_profile_cubit.dart';
import 'package:ascca_app/ui/modules/home/profile_tab/widgets/profile_card_item.dart';
import 'package:ascca_app/ui/modules/home/profile_tab/widgets/profile_log_out_dialog.dart';
import 'package:ascca_app/ui/modules/home/profile_tab/widgets/profile_name.dart';
import 'package:ascca_app/ui/modules/home/profile_tab/widgets/profile_photo.dart';
import 'package:ascca_app/ui/modules/home/services/log_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/constants/app_texts.dart';
import '../widgets/profile_app_bar.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final LogOut _logOut = LogOut();

  final ValueNotifier<String> selectedLanguage = ValueNotifier<String>("AZ");
  final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isEditingProfile = ValueNotifier<bool>(false);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  String? _initialName;
  String? _initialAboutMe;

  @override
  void initState() {
    context.read<UserProfileCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ProfileAppBar(),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is UserProfileSuccess) {
            if (_initialName == null && _initialAboutMe == null) {
              _initialName = state.user.fullName;
              _initialAboutMe = state.user.aboutMe;
            }

            _nameController.text = state.user.fullName ?? '';
            _aboutMeController.text = state.user.aboutMe ?? '';

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: height * 0.012,
                    children: [
                      ProfilePhoto(
                        profilePictureUrl: state.user.profilePictureUrl,
                        isEditingNotifier: isEditingProfile,
                        onSave: () {
                          context.read<UpdateProfileCubit>().updateProfile(
                            _nameController.text.trim(),
                            _aboutMeController.text.trim(),
                            state.user.profilePictureUrl ?? '',
                          );
                          isEditingProfile.value = false;
                        },
                        onCancelEdit: () {
                          _nameController.text = _initialName ?? '';
                          _aboutMeController.text = _initialAboutMe ?? '';
                          isEditingProfile.value = false;
                        },
                      ),
                      ProfileName(
                        isEditingNotifier: isEditingProfile,
                        nameController: _nameController,
                        aboutMeController: _aboutMeController,
                      ),
                      SizedBox(height: height * 0.02),
                      ProfileCardItem(
                        leadingIcon: Icons.bookmark_outline,
                        leadingIconColor: AppColors.lavenderBlue,
                        title: AppTexts.bookmarkedEvents,
                        onTap: () {
                          context.push(AppRoutes.bookmarkedEvents.path).then((
                            _,
                          ) {
                            context.read<UserProfileCubit>().getUserData();
                          });
                        },
                      ),
                      ProfileCardItem(
                        leadingIcon: Icons.notifications_none_outlined,
                        leadingIconColor: AppColors.lavenderBlue,
                        title: AppTexts.notifications,
                        onTap: () {
                          context.push(AppRoutes.notification.path).then((_) {
                            context.read<UserProfileCubit>().getUserData();
                          });
                        },
                      ),
                      ProfileCardItem(
                        leadingIcon: Icons.language_outlined,
                        leadingIconColor: AppColors.lavenderBlue,
                        title: AppTexts.language,
                        isLanguageSelection: true,
                        selectedLanguage: selectedLanguage,
                      ),
                      ProfileCardItem(
                        leadingIcon: Icons.dark_mode_outlined,
                        leadingIconColor: AppColors.lavenderBlue,
                        title: AppTexts.darkMode,
                        isDarkMode: true,
                      ),
                      ProfileCardItem(
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
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    selectedLanguage.dispose();
    isEditingProfile.dispose();
    _nameController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }
}
