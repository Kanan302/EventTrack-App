import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EventsCardItem extends StatelessWidget {
  final String cardId;
  final VoidCallback onTapCard;
  final String imageUrl;
  final String startDate;
  final String title;
  final String? location;

  const EventsCardItem({
    super.key,
    required this.cardId,
    required this.onTapCard,
    required this.imageUrl,
    required this.startDate,
    required this.title,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTapCard,
      child: Container(
        width: width * 0.9,
        height: height * 0.17,
        decoration: BoxDecoration(
          color: AppColors.white,
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
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                  ),
                  // Image.asset(imageUrl, fit: BoxFit.cover),
                  // SvgPicture.asset(imageUrl, fit: BoxFit.contain),
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
                      ),
                    ),
                    const SizedBox(height: 25),
                    if (location != null && location!.isNotEmpty)
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
                              location!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.graphiteGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    // const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
