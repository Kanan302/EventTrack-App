import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_app_bar.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_date.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_description.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_location.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_name.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_photo.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_title.dart';
import 'package:ascca_app/ui/utils/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      // key: _scaffoldKey,
      appBar: const CreateEventAppbar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: height * 0.02,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CreateEventTitle(),
                  CreateEventName(),
                  CreateEventDescription(),
                  CreateEventLocation(),
                  CreateEventDate(),
                  CreateEventPhoto(),
                  SizedBox(height: height * 0.01),
                  AppElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    buttonColor: AppColors.lavenderBlue,
                    text: AppTexts.create,
                    textColor: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
