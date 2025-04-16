import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';

class CreateEventPhoto extends StatelessWidget {
  final ValueNotifier<File?> imageNotifier;
  final Function(File?) onImageSelected;
  final ValueNotifier<String?> errorNotifier;

  const CreateEventPhoto({
    super.key,
    required this.imageNotifier,
    required this.onImageSelected,
    required this.errorNotifier,
  });

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageNotifier.value = File(pickedFile.path);
      onImageSelected(imageNotifier.value);
      errorNotifier.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: ValueListenableBuilder<File?>(
            valueListenable: imageNotifier,
            builder: (context, imageFile, _) {
              return Container(
                width: double.infinity,
                height: 120.0,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.warmGray),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child:
                    imageFile != null
                        ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                imageFile,
                                width: double.infinity,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 8.0,
                              top: 8.0,
                              child: GestureDetector(
                                onTap: () {
                                  imageNotifier.value = null;
                                  onImageSelected(null);
                                  errorNotifier.value =
                                      "Zəhmət olmasa, şəkil yükləyin";
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.close, color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        )
                        : const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Şəkil yükləmək üçün klikləyin',
                                style: TextStyle(
                                  color: AppColors.graphiteGray,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.upload_file_outlined,
                                color: AppColors.graphiteGray,
                              ),
                            ],
                          ),
                        ),
              );
            },
          ),
        ),

        ValueListenableBuilder<String?>(
          valueListenable: errorNotifier,
          builder: (context, error, _) {
            return error != null
                ? Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
