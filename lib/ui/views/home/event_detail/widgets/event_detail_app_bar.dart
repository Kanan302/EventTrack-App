import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/services/injection/di.dart';
import '../../../../../shared/services/local/secure_service.dart';
import '../../../../../shared/theme/app_colors.dart';

class EventDetailAppBar extends StatefulWidget {
  final Function()? onTap;
  final IconData? icon;

  const EventDetailAppBar({super.key, this.onTap, this.icon});

  @override
  State<EventDetailAppBar> createState() => _EventDetailAppBarState();
}

class _EventDetailAppBarState extends State<EventDetailAppBar> {
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
    _loadUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
      ),
      title: Text(
        AppLocalizations.of(context).eventDetails,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
      ),
      titleSpacing: 0,
      actions:
          userStatus != '1'
              ? [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 1000),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: AppColors.softWhite,
                        child: InkWell(
                          onTap: widget.onTap,
                          child: Icon(
                            widget.icon,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
              : null,
      centerTitle: false,
    );
  }
}
