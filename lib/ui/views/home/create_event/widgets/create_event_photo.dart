import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CreateEventPhoto extends StatelessWidget {
  const CreateEventPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.warmGray),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Şəkil yükləmək üçün klikləyin',
                    style: TextStyle(
                      color: AppColors.lavenderBlue,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Icon(Icons.upload_file_outlined, color: AppColors.graphiteGray),
            ],
          ),
        ),
      ),
    );
    // Stack(
    //                   children: [
    //                     ClipRRect(
    //                       borderRadius: BorderRadius.circular(8.0),
    //                       child: Image.file(
    //                         // File(imageFile!.path),
    //                         // width: double.infinity,
    //                         // height: 100.0,
    //                         // fit: BoxFit.contain,
    //                       ),
    //                     ),
    //                     Positioned(
    //                       right: 0.0,
    //                       child: IconButton(
    //                         onPressed: () {
    //                           // setState(() {
    //                           //   imageFile = null;
    //                           // });
    //                         },
    //                         icon: const Icon(
    //                           Icons.close,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 );
  }
}
