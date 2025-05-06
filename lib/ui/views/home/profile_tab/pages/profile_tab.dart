import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/constants/app_routes.dart';
import '../../../../../shared/services/injection/di.dart';
import '../../../../../shared/services/local/secure_service.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../../../cubits/profile/user/user_profile_cubit.dart';
import '../../services/log_out.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_card_item.dart';
import '../widgets/profile_log_out_dialog.dart';
import '../widgets/profile_name.dart';
import '../widgets/profile_photo.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final LogOut _logOut = LogOut();

  // final ValueNotifier<String> selectedLanguage = ValueNotifier<String>("AZ");
  ValueNotifier<String>? selectedLanguageNotifier;

  final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  final _secureStorage = getIt.get<SecureService>();
  String? userStatus;

  Future<void> _loadUserStatus() async {
    final status = await _secureStorage.userStatus;
    setState(() {
      userStatus = status;
    });
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('selected_locale') ?? 'az';
    selectedLanguageNotifier = ValueNotifier(langCode.toUpperCase());
    setState(() {});
  }

  @override
  void initState() {
    _loadUserStatus();
    _loadSelectedLanguage();
    context.read<UserProfileCubit>().getUserData(context);
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
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<UserProfileCubit>().getUserData(
                    context,
                    forceRefresh: true,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: height * 0.012,
                      children: [
                        ProfilePhoto(
                          profilePictureUrl: state.user.profilePictureUrl,
                        ),
                        ProfileName(
                          name: state.user.fullName ?? '',
                          aboutMe: state.user.aboutMe ?? '',
                        ),
                        SizedBox(height: height * 0.02),
                        if (userStatus == '1')
                          ProfileCardItem(
                            leadingIcon: Icons.document_scanner_outlined,
                            leadingIconColor: AppColors.lavenderBlue,
                            title: AppLocalizations.of(context).doScan,
                            onTap: () {
                              context.push(AppRoutes.doScan.path);
                            },
                          ),
                        if (userStatus == '1')
                          ProfileCardItem(
                            leadingIcon: Icons.event_seat_outlined,
                            leadingIconColor: AppColors.lavenderBlue,
                            title: AppLocalizations.of(context).myEvents,
                            onTap: () {
                              context.push(AppRoutes.myEvents.path);
                            },
                          ),
                        if (userStatus != '1')
                          ProfileCardItem(
                            leadingIcon: Icons.bookmark_outline,
                            leadingIconColor: AppColors.lavenderBlue,
                            title:
                                AppLocalizations.of(context).bookmarkedEvents,
                            onTap: () {
                              context
                                  .push(AppRoutes.bookmarkedEvents.path)
                                  .then((_) {
                                    context
                                        .read<UserProfileCubit>()
                                        .getUserData(context);
                                  });
                            },
                          ),
                        ProfileCardItem(
                          leadingIcon: Icons.edit,
                          leadingIconColor: AppColors.lavenderBlue,
                          title: AppLocalizations.of(context).editProfile,
                          onTap: () {
                            context.push(AppRoutes.updateProfile.path).then((
                              _,
                            ) {
                              context.read<UserProfileCubit>().getUserData(
                                context,
                                forceRefresh: true,
                              );
                            });
                          },
                        ),
                        ProfileCardItem(
                          leadingIcon: Icons.notifications_none_outlined,
                          leadingIconColor: AppColors.lavenderBlue,
                          title: AppLocalizations.of(context).notifications,
                          onTap: () {
                            context.push(AppRoutes.notification.path);
                          },
                        ),
                        ProfileCardItem(
                          leadingIcon: Icons.language_outlined,
                          leadingIconColor: AppColors.lavenderBlue,
                          title: AppLocalizations.of(context).language,
                          isLanguageSelection: true,
                          selectedLanguage: selectedLanguageNotifier,
                        ),
                        ProfileCardItem(
                          leadingIcon: Icons.dark_mode_outlined,
                          leadingIconColor: AppColors.lavenderBlue,
                          title: AppLocalizations.of(context).darkMode,
                          isDarkMode: true,
                        ),

                        ProfileCardItem(
                          leadingIcon: Icons.logout,
                          leadingIconColor: AppColors.red,
                          title: AppLocalizations.of(context).logOut,
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
                        SizedBox(height: 30),
                      ],
                    ),
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
    selectedLanguageNotifier?.dispose();
    super.dispose();
  }
}
