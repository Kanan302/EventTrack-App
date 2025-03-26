import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/views/home/profile_tab/service/theme_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EventsCardItem extends StatelessWidget {
  final String cardId;
  final VoidCallback onTapCard;
  final String imageUrl;
  final String startDate;
  final String title;
  final String? city;
  final String? street;
  final VoidCallback onDelete;
  final String userStatus;

  const EventsCardItem({
    super.key,
    required this.cardId,
    required this.onTapCard,
    required this.imageUrl,
    required this.startDate,
    required this.title,
    this.city,
    this.street,
    required this.onDelete,
    required this.userStatus,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (userStatus != "1") {
      return BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final bool isDarkMode = themeMode == ThemeMode.dark;
          return InkWell(
            onTap: onTapCard,
            child: Container(
              width: width * 0.9,
              height: height * 0.17,
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.softGray,
                    blurRadius: 6,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      height: height * 0.2,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, url) {
                            return Icon(
                              Icons.broken_image,
                              size: 50,
                              color: AppColors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            startDate,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lavenderBlue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            title,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.graphiteGray,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.graphiteGray,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  "${street ?? ''} - ${city ?? ''} ",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.graphiteGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final bool isDarkMode = themeMode == ThemeMode.dark;
        return Slidable(
          startActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              CustomSlidableAction(
                onPressed: (context) => onDelete(),
                backgroundColor: AppColors.red,
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 30,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 6),
                    Text(
                      AppTexts.delete,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTapCard,
            child: Container(
              width: width * 0.9,
              height: height * 0.17,
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.softGray,
                    blurRadius: 6,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      height: height * 0.2,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, url) {
                            return Icon(
                              Icons.broken_image,
                              size: 50,
                              color: AppColors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            startDate,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lavenderBlue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            title,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.graphiteGray,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.graphiteGray,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  "${street ?? ''} - ${city ?? ''} ",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.graphiteGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
