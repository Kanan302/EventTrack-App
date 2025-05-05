import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../shared/theme/app_colors.dart';
import '../../../../../cubits/profile/update_profile/update_profile_cubit.dart';
import '../../../../../utils/notifications/snackbar.dart';
import '../../../../../utils/widgets/app_elevated_button.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File? _selectedImage;
  late TextEditingController nameController;
  late TextEditingController aboutController;

  @override
  void initState() {
    nameController = TextEditingController();
    aboutController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                spacing: height * 0.025,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context).updateYourProfile,
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
                                final pickedFile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  setState(() {
                                    _selectedImage = File(pickedFile.path);
                                  });
                                }
                              },
                            )
                            : null,
                  ),
                  updateProfileTextField(
                    AppLocalizations.of(context).yourName,
                    nameController,
                  ),
                  updateProfileTextField(
                    AppLocalizations.of(context).yourAbout,
                    aboutController,
                  ),
                  SizedBox(height: 30),
                  BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                    listener: (context, state) {
                      if (state is UpdateProfileSuccess) {
                        SnackBarService.showSnackBar(
                          context,
                          AppLocalizations.of(context).dataUpdatedSuccessfully,
                          AppColors.blue,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateProfileFailure) {
                        return Center(
                          child: Text(
                            '${AppLocalizations.of(context).anErrorOccurred} ${state.errorMessage}',
                          ),
                        );
                      }
                      return AppElevatedButton(
                        onPressed:
                            () => context
                                .read<UpdateProfileCubit>()
                                .updateProfile(
                                  context,
                                  nameController.text.trim().isEmpty
                                      ? null
                                      : nameController.text.trim(),
                                  aboutController.text.trim().isEmpty
                                      ? null
                                      : aboutController.text.trim(),
                                  _selectedImage,
                                ),

                        buttonColor: AppColors.lavenderBlue,
                        text: AppLocalizations.of(context).add,
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

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    super.dispose();
  }
}
