import 'dart:io';

import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/ui/utils/notifications/snackbar.dart';
import 'package:ascca_app/ui/utils/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../shared/theme/app_colors.dart';
import '../../../../../cubits/profile/update_profile/update_profile_cubit.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController aboutController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              spacing: height * 0.025,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppTexts.updateYourProfile,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.graphiteGray,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.007),
                CircleAvatar(
                  backgroundColor: AppColors.lavenderBlue,
                  radius: 40,
                  backgroundImage:
                      _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                  child:
                      _selectedImage == null
                          ? IconButton(
                            icon: Icon(
                              Icons.upload,
                              size: 40,
                              color: AppColors.white,
                            ),
                            onPressed: () async {
                              final pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              if (pickedFile != null) {
                                setState(() {
                                  _selectedImage = File(pickedFile.path);
                                });
                              }
                            },
                          )
                          : null,
                ),
                updateProfileTextField(AppTexts.yourName, nameController),
                updateProfileTextField(AppTexts.yourAbout, aboutController),
                SizedBox(height: 30),
                BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                  listener: (context, state) {
                    if (state is UpdateProfileSuccess) {
                      SnackBarService.showSnackBar(
                        context,
                        'Məlumatlarınız uğurla yeniləndi',
                        AppColors.blue,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateProfileFailure) {
                      return Center(
                        child: Text('Xəta baş verdi: ${state.errorMessage}'),
                      );
                    }
                    return AppElevatedButton(
                      onPressed:
                          () =>
                              context.read<UpdateProfileCubit>().updateProfile(
                                nameController.text.trim().isEmpty
                                    ? null
                                    : nameController.text.trim(),
                                aboutController.text.trim().isEmpty
                                    ? null
                                    : aboutController.text.trim(),
                                _selectedImage,
                              ),

                      buttonColor: AppColors.lavenderBlue,
                      text: AppTexts.add,
                      textColor: AppColors.white,
                      isLoading: state is UpdateProfileLoading,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget updateProfileTextField(
    String hintText,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.graphiteGray),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.warmGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.graphiteGray),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.red),
        ),
      ),
    );
  }
}
